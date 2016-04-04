//
//  YLSideMenu.m
//  YLSideMenu
//
//  Created by eviloo7 on 16/4/2.
//  Copyright © 2016年 eviloo7. All rights reserved.
//

#import "YLSideMenu.h"

#ifndef YLScreenWidth
#define YLScreenWidth [UIScreen mainScreen].bounds.size.width
#define YLScreenHeight [UIScreen mainScreen].bounds.size.height
#endif
@interface YLSideMenu()<UIGestureRecognizerDelegate> {
    UIViewController *_contentController;
    UIViewController *_leftMenuController;
    UIViewController *_rightMenuController;
    
    UIView *_contentView;
    UIView *_leftMenuView;
    UIView *_rightMenView;
    
    UIImageView *_backgroundView;
//    判断是那个menu要显示
    NSUInteger _isShow;
    NSUInteger _isLeftRight;
}
@end
@implementation YLSideMenu

#pragma mark - init Method
- (instancetype)initWithContentController:(UIViewController *)contentController leftMenuController:(UIViewController *)leftMenuController rightMenuController:(UIViewController *)rightMenuController {
    self = [super init];
    if (self == nil) {
        return nil;
    }
    _contentController   = contentController;
    _leftMenuController  = leftMenuController;
    _rightMenuController = rightMenuController;
    
    [self defaultConfig];
    [self defaultInit];
    
    return self;
}
- (instancetype)initWithContentController:(UIViewController *)contentController leftMenuController:(UIViewController *)leftMenuController {
    return [[[self class] alloc ] initWithContentController:contentController leftMenuController:leftMenuController rightMenuController:nil];
}
- (instancetype)initWithContentController:(UIViewController *)contentController rightMenuController:(UIViewController *)rightMenuController {
    return [[[self class] alloc] initWithContentController:contentController leftMenuController:nil rightMenuController:rightMenuController];
}
#pragma mark - private Method
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)hideViewController:(UIViewController*)viewController {
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}
- (void)defaultConfig {
    _translationDistance = YLScreenWidth*4/5;
    _backgroundColor = [UIColor grayColor];
    _menuTranslationDistance = self.translationDistance/4;
    _animationTime = 0.4;
    _scaleMenu = 1;
    _scaleContent = 1;
}
- (void)setScaleMenu:(CGFloat)scaleMenu {
    _scaleMenu = scaleMenu;
    _menuTranslationDistance =0;
    if (_leftMenuController) {
        _leftMenuView.frame  = (CGRect){_menuTranslationDistance,0,YLScreenWidth,YLScreenHeight};
        _leftMenuView.transform = CGAffineTransformMakeScale(_scaleMenu, _scaleMenu);
    }
    if (_rightMenuController) {
        _rightMenView.frame  = (CGRect){_menuTranslationDistance,0,YLScreenWidth,YLScreenHeight};
        _rightMenView.transform = CGAffineTransformMakeScale(_scaleMenu, _scaleMenu);
        
    }
    
}

- (void)defaultInit {
    
    if (_leftMenuController) {
        [self addChildViewController:_leftMenuController];
        [self didMoveToParentViewController:_leftMenuController];
        [self.view addSubview:_leftMenuController.view];
        _leftMenuView        = _leftMenuController.view;
        _leftMenuView.hidden = YES;
        _leftMenuView.frame  = (CGRect){-_menuTranslationDistance,0,YLScreenWidth,YLScreenHeight};
    }
    if (_rightMenuController) {
        [self addChildViewController:_rightMenuController];
        [self didMoveToParentViewController:_rightMenuController];
        [self.view addSubview:_rightMenuController.view];
        _rightMenView        = _rightMenuController.view;
        _rightMenView.hidden = YES;
        _rightMenView.frame  = (CGRect){_menuTranslationDistance,0,YLScreenWidth,YLScreenHeight};
    }
    
    [self addChildViewController:_contentController];
    [self didMoveToParentViewController:_contentController];
    [self.view addSubview:_contentController.view];
    _contentView                 = _contentController.view;
    [self.view bringSubviewToFront:_contentView];
    _contentView.frame           = (CGRect){0,0,YLScreenWidth,YLScreenHeight};
    _contentView.backgroundColor = [UIColor whiteColor];
    
//    添加滑动手势
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:panGR];
//    添加点击手势
    UITapGestureRecognizer *tapGT = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGT.delegate = self;
    [_contentView addGestureRecognizer:tapGT];
}

#pragma mark - private
- (void)tapGesture:(UITapGestureRecognizer*)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:_contentView];
    if (_isShow ==1) {
        
        [UIView animateWithDuration:self.animationTime animations:^{
            _leftMenuView.transform = CGAffineTransformMake(_scaleMenu, 0, 0, _scaleMenu, -_menuTranslationDistance, 0);
            _contentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                _leftMenuView.hidden = YES;
                _isShow = 3;
            }
        }];
    } else if(_isShow == 2){
        [UIView animateWithDuration:self.animationTime animations:^{
            _rightMenView.transform = CGAffineTransformMake(_scaleMenu, 0, 0, _scaleMenu,0, 0);;
            _contentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                _rightMenView.hidden = YES;
                _isShow = 3;
            }
        }];
    }
}
- (void)panGesture:(UIPanGestureRecognizer*)gestureRecognizer {
//    获取滑动的距离
    CGPoint point = [gestureRecognizer translationInView:self.view];
    
    if(gestureRecognizer.state == UIGestureRecognizerStateChanged){
        
        if(point.x>0){
            //      右滑
            _isLeftRight = 1;
            if (_leftMenuController&&_contentView.transform.tx==0&&_leftMenuView.hidden) {
//                活动视图是左视图
                _isShow = 1;
                _leftMenuView.hidden = NO;
                _rightMenView.hidden = YES;
            }
        }
        if (point.x<0) {
        _isLeftRight = 2;
//      左滑
            if(_rightMenuController&&_contentView.transform.tx==0&&_rightMenView.hidden) {
                //                活动视图是右视图
                _isShow = 2;
                _leftMenuView.hidden = YES;
                _rightMenView.hidden = NO ;
            }
        }
        if (_isShow == 1) {
            CGFloat la = _leftMenuView.transform.a-(_scaleMenu-1)*point.x/_translationDistance*2;
            CGFloat ld = _leftMenuView.transform.d-(_scaleMenu-1)*point.x/_translationDistance*2;
            CGFloat ltx = _leftMenuView.transform.tx;
            if (_scaleMenu == 1) {
                     ltx = _leftMenuView.transform.tx+point.x/_translationDistance*_menuTranslationDistance;
            }
            
            
            CGFloat ca = _contentView.transform.a-(_scaleMenu-1)*point.x/_translationDistance;
            CGFloat cd = _contentView.transform.d-(_scaleMenu-1)*point.x/_translationDistance;
            CGFloat ctx = _contentView.transform.tx+point.x;
            
            _leftMenuView.transform = CGAffineTransformMake(la, 0, 0, ld, ltx, 0);
            _contentView.transform = CGAffineTransformMake(ca, 0, 0, cd, ctx, 0);
        } else if(_isShow == 2){
            CGFloat la = _rightMenView.transform.a+(_scaleMenu-1)*point.x/_translationDistance*2;
            CGFloat ld = _rightMenView.transform.d+(_scaleMenu-1)*point.x/_translationDistance*2;
            CGFloat ltx = _rightMenView.transform.tx;
            if (_scaleMenu == 1) {
                    ltx = _rightMenView.transform.tx+point.x/_translationDistance*_menuTranslationDistance;
            }
            
            
            CGFloat ca = _contentView.transform.a+(_scaleMenu-1)*point.x/_translationDistance;
            CGFloat cd = _contentView.transform.d+(_scaleMenu-1)*point.x/_translationDistance;
            CGFloat ctx = _contentView.transform.tx+point.x;
            
            _rightMenView.transform = CGAffineTransformMake(la, 0, 0, ld, ltx, 0);
            _contentView.transform = CGAffineTransformMake(ca, 0, 0, cd, ctx, 0);
        }
        if (_contentView.transform.tx==0) {
            return;
        }
    } else if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (_isShow == 1) {
            if (_contentView.transform.tx>=_translationDistance*_scaleContent*4/5) {
                [UIView animateWithDuration:_animationTime/2 animations:^{
                    _leftMenuView.transform = CGAffineTransformMake(1, 0, 0, 1, _menuTranslationDistance, 0);
                    _contentView.transform = CGAffineTransformMake(_scaleContent, 0, 0, _scaleContent, _translationDistance*_scaleContent, 0);
                }];
            } else if(_contentView.transform.tx<=_translationDistance*_scaleContent/5){
                
                [UIView animateWithDuration:_animationTime/2 animations:^{
                    _leftMenuView.transform = CGAffineTransformMake(_scaleMenu, 0, 0, _scaleMenu, 0, 0);
                    _contentView.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    if (finished) {
                        _leftMenuView.hidden = YES;
                    }
                }];
            } else {
                if (_isLeftRight == 1) {
                    [UIView animateWithDuration:_animationTime/2 animations:^{
                        _leftMenuView.transform = CGAffineTransformMake(1, 0, 0, 1, _menuTranslationDistance, 0);
                        _contentView.transform = CGAffineTransformMake(_scaleContent, 0, 0, _scaleContent, _translationDistance*_scaleContent, 0);
                    }];
                    
                } else if(_isLeftRight == 2) {
                    [UIView animateWithDuration:_animationTime/2 animations:^{
                        _leftMenuView.transform = CGAffineTransformMake(_scaleMenu, 0, 0, _scaleMenu, 0, 0);
                        _contentView.transform = CGAffineTransformIdentity;
                    } completion:^(BOOL finished) {
                        if (finished) {
                            _leftMenuView.hidden = YES;
                        }
                    }];
                    
                }
                
            }
            
        } else if(_isShow == 2){
            
            if (_contentView.transform.tx <=- _translationDistance*_scaleContent*4/5) {
                [UIView animateWithDuration:_animationTime/2 animations:^{
                    _rightMenView.transform = CGAffineTransformMake(1, 0, 0, 1, -_menuTranslationDistance, 0);
                    _contentView.transform = CGAffineTransformMake(_scaleContent, 0, 0, _scaleContent, -_translationDistance*_scaleContent, 0);
                }];
                
                
            } else if(_contentView.transform.tx>=-_translationDistance*_scaleContent/5){
                
                [UIView animateWithDuration:_animationTime/2 animations:^{
                    _rightMenView.transform = CGAffineTransformMake(_scaleMenu, 0, 0, _scaleMenu, 0, 0);
                    _contentView.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    if (finished) {
                        _rightMenView.hidden = YES;
                    }
                }];
                
            } else {
                if (_isLeftRight == 1) {
                    
                    [UIView animateWithDuration:_animationTime/2 animations:^{
                        _rightMenView.transform = CGAffineTransformMake(_scaleMenu, 0, 0, _scaleMenu, 0, 0);
                        _contentView.transform = CGAffineTransformIdentity;
                    } completion:^(BOOL finished) {
                        if (finished) {
                            _rightMenView.hidden = YES;
                        }
                    }];
                } else if(_isLeftRight == 2) {
                
                    [UIView animateWithDuration:self.animationTime animations:^{
                        _rightMenView.transform = CGAffineTransformMake(1, 0, 0, 1, -_menuTranslationDistance, 0);
                        _contentView.transform = CGAffineTransformMake(_scaleContent, 0, 0, _scaleContent, -_translationDistance*_scaleContent, 0);
                    } completion:^(BOOL finished) {
                        if (finished) {
                            
                        }
                    }];
                    
                    
                }
                
            }

        }
    }
    [gestureRecognizer setTranslation:CGPointZero inView:self.view];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    
    _backgroundImage = backgroundImage;
    _backgroundView = [[UIImageView alloc] initWithImage:self.backgroundImage];
    _backgroundView.frame = self.view.bounds;
    _backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    
    if (_leftMenuController) {
        [self.view insertSubview:_backgroundView belowSubview:_leftMenuView];
    } else {
        [self.view insertSubview:_backgroundView belowSubview:_rightMenView];
    }
}
- (void)showHideLeftMenu {
    if (_leftMenuView.hidden) {
        _leftMenuView.hidden = NO;
        _isShow = 1;
        [UIView animateWithDuration:self.animationTime animations:^{
            _leftMenuView.transform = CGAffineTransformMake(1, 0, 0, 1, _menuTranslationDistance, 0);
            _contentView.transform = CGAffineTransformMake(_scaleContent, 0, 0, _scaleContent, _translationDistance*_scaleContent, 0);
        
        } completion:^(BOOL finished) {
            
        }];
    } else {
        
        [UIView animateWithDuration:self.animationTime animations:^{
            _leftMenuView.transform = CGAffineTransformMake(_scaleMenu, 0, 0, _scaleMenu, -_menuTranslationDistance, 0);
            _contentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                _leftMenuView.hidden = YES;
                _isShow = 3;
            }
        }];
    }
}
- (void)showHideRightMenu {
    if (_rightMenView.hidden) {
        _rightMenView.hidden = NO;
        _isShow = 2;
        [UIView animateWithDuration:self.animationTime animations:^{
            _rightMenView.transform = CGAffineTransformMake(1, 0, 0, 1, -_menuTranslationDistance, 0);
            _contentView.transform = CGAffineTransformMake(_scaleContent, 0, 0, _scaleContent, -_translationDistance*_scaleContent, 0);
        } completion:^(BOOL finished) {
            if (finished) {
               
            }
        }];
    } else {
        
        [UIView animateWithDuration:self.animationTime animations:^{
            _rightMenView.transform = CGAffineTransformMake(_scaleMenu, 0, 0, _scaleMenu,0, 0);;
            _contentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                _rightMenView.hidden = YES;
                _isShow = 3;
            }
        }];
    }
}
@end
