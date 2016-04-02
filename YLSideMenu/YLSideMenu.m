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
    BOOL _isShowLeft;
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
    self.translationDistance = YLScreenWidth*4/5;
    self.backgroundColor = [UIColor grayColor];
    self.menuTranslationDistance = self.translationDistance/5;
    self.animationTime = 0.4;
}
- (void)defaultInit {
    
    if (_leftMenuController) {
        [self addChildViewController:_leftMenuController];
        [self didMoveToParentViewController:_leftMenuController];
        [self.view addSubview:_leftMenuController.view];
        _leftMenuView        = _leftMenuController.view;
        _leftMenuView.hidden = YES;
        _leftMenuView.frame  = (CGRect){-_menuTranslationDistance,0,_translationDistance,YLScreenHeight};
    }
    if (_rightMenuController) {
        [self addChildViewController:_rightMenuController];
        [self didMoveToParentViewController:_rightMenuController];
        [self.view addSubview:_rightMenuController.view];
        _rightMenView        = _rightMenuController.view;
        _rightMenView.hidden = YES;
        _rightMenView.frame  = (CGRect){YLScreenWidth-_translationDistance+ _menuTranslationDistance,0,_translationDistance,YLScreenHeight};
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
    [self.view addGestureRecognizer:tapGT];
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        CGPoint point = [touch locationInView:self.view];
        if (point.x >=_translationDistance&&_isShowLeft) {
            
            return YES;
        } else if(point.x<=_translationDistance/4&&!_isShowLeft) {
            return YES;
        }
        return NO;
    }
    return YES;
}

#pragma mark - private
- (void)tapGesture:(UITapGestureRecognizer*)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.view];
    if (!_leftMenuView.hidden&&_leftMenuController) {
        if (point.x >= _translationDistance) {
            [UIView animateWithDuration:_animationTime animations:^{
                _leftMenuView.transform = CGAffineTransformIdentity;
                _contentView.transform  = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (finished) {
                    _leftMenuView.hidden = YES;
                }
            }];
           
        }
    } else if(!_rightMenView.hidden&&_rightMenuController) {
        
        if (point.x <= _translationDistance/4) {
            [UIView animateWithDuration:_animationTime animations:^{
                _rightMenView.transform = CGAffineTransformIdentity;
                _contentView.transform  = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (finished) {
                    _rightMenView.hidden = YES;
                }
            }];
            
        }
    }
}
- (void)panGesture:(UIGestureRecognizer*)gestureRecognizer {
//    获取滑动的距离
    CGPoint point = [(UIPanGestureRecognizer*)gestureRecognizer translationInView:self.view];
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        在滑动过程中一直调用
        if (_isShowLeft&&_leftMenuController) {
//            操作左菜单
            if (_contentView.transform.tx <= _translationDistance&&point.x>0) {
                //            向右滑
                _contentView.transform  = CGAffineTransformMakeTranslation(point.x, 0);
                _leftMenuView.transform = CGAffineTransformMakeTranslation(_menuTranslationDistance/_translationDistance *point.x, 0);
                
            } else if(point.x<=0&&_contentView.transform.tx > 0){
                
                _contentView.transform  = CGAffineTransformMakeTranslation(_translationDistance +point.x, 0);
                _leftMenuView.transform = CGAffineTransformMakeTranslation(_menuTranslationDistance+_menuTranslationDistance/_translationDistance *point.x, 0);
            }
        } else if(!_isShowLeft&&_rightMenuController){
//            操作右菜单
            if (_contentView.transform.tx >= -_translationDistance&&point.x<=0) {
                //            向右滑
                _contentView.transform  = CGAffineTransformMakeTranslation(point.x, 0);
                _rightMenView.transform = CGAffineTransformMakeTranslation(_menuTranslationDistance/_translationDistance *point.x, 0);
                
            } else if(point.x>=0&&_contentView.transform.tx < 0){
                
                _contentView.transform  = CGAffineTransformMakeTranslation(-_translationDistance +point.x, 0);
                _rightMenView.transform = CGAffineTransformMakeTranslation(-_menuTranslationDistance+_menuTranslationDistance/_translationDistance *point.x, 0);
            }
        
        }
        
        
    } else if(gestureRecognizer.state == UIGestureRecognizerStateEnded){
        if (_isShowLeft&&_leftMenuController) {
            if (_contentView.transform.tx <= 0) {
                //主界面下，没有右菜单，还要左滑下的情况
                _contentView.transform  = CGAffineTransformIdentity;
                _leftMenuView.transform = CGAffineTransformIdentity;
            } else if(_contentView.transform.tx <= _translationDistance/5 && point.x >=0) {
                //            在主界面下，右滑没有超过五分之一，返回原位置
                [UIView animateWithDuration:self.animationTime/2 animations:^{
                    _contentView.transform  = CGAffineTransformIdentity;
                    _leftMenuView.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    if (finished) {
                        _leftMenuView.hidden = YES;
                    }
                }];
            } else if(_contentView.transform.tx >=_translationDistance*4/5&&point.x<=0){
                //            在左菜单下，左滑没有超过五分之一，返回原位置
                [UIView animateWithDuration:self.animationTime/2 animations:^{
                    _contentView.transform  = CGAffineTransformMakeTranslation(_translationDistance, 0);
                    _leftMenuView.transform = CGAffineTransformMakeTranslation(_menuTranslationDistance, 0);
                } completion:^(BOOL finished) {
                    
                }];
                
            } else if(_contentView.transform.tx>_translationDistance/5 && point.x > 0) {
                //            在主界面下，滑动超过五分之一，并且是右滑时，显示左菜单
                [UIView animateWithDuration:self.animationTime/2 animations:^{
                    _contentView.transform  = CGAffineTransformMakeTranslation(_translationDistance, 0);
                    _leftMenuView.transform = CGAffineTransformMakeTranslation(_menuTranslationDistance, 0);
                } completion:^(BOOL finished) {
                    
                }];
            } else if(_contentView.transform.tx<_translationDistance*4/5 && point.x <0) {
                //            在左菜单下，滑动超过五分之一，并且是左滑，显示主界面
                [UIView animateWithDuration:self.animationTime/2 animations:^{
                    _contentView.transform  = CGAffineTransformIdentity;
                    _leftMenuView.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    if (finished) {
                        _leftMenuView.hidden = YES;
                    }
                }];
            }

        }else if(!_isShowLeft&&_rightMenuController){
            if (_contentView.transform.tx >= 0) {
                //主界面下，没有右菜单，还要左滑下的情况
                _contentView.transform  = CGAffineTransformIdentity;
                _rightMenView.transform = CGAffineTransformIdentity;
            } else if(_contentView.transform.tx >= -_translationDistance/5 && point.x <=0) {
                //            在主界面下，右滑没有超过五分之一，返回原位置
                [UIView animateWithDuration:self.animationTime/2 animations:^{
                    _contentView.transform  = CGAffineTransformIdentity;
                    _rightMenView.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    if (finished) {
                        
                        _rightMenView.hidden = YES;
                    }
                }];
            } else if(_contentView.transform.tx <=-_translationDistance*4/5&&point.x>=0){
                //            在左菜单下，左滑没有超过五分之一，返回原位置
                [UIView animateWithDuration:self.animationTime/2 animations:^{
                    _contentView.transform  = CGAffineTransformMakeTranslation(-_translationDistance, 0);
                    _rightMenView.transform = CGAffineTransformMakeTranslation(-_menuTranslationDistance, 0);
                } completion:^(BOOL finished) {
                    
                }];
                
            } else if(_contentView.transform.tx<-_translationDistance/5 && point.x < 0) {
                //            在主界面下，滑动超过五分之一，并且是右滑时，显示左菜单
                [UIView animateWithDuration:self.animationTime/2 animations:^{
                    _contentView.transform  = CGAffineTransformMakeTranslation(-_translationDistance, 0);
                    _rightMenView.transform = CGAffineTransformMakeTranslation(-_menuTranslationDistance, 0);
                } completion:^(BOOL finished) {
                    
                }];
            } else if(_contentView.transform.tx>-_translationDistance*4/5 && point.x >0) {
                //            在左菜单下，滑动超过五分之一，并且是左滑，显示主界面
                [UIView animateWithDuration:self.animationTime/2 animations:^{
                    _contentView.transform  = CGAffineTransformIdentity;
                    _rightMenView.transform = CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    if (finished) {
                        _rightMenView.hidden = YES;
                    }
                }];
            }

        
        }
    } else if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        if (((_contentView.transform.tx ==0&&point.x>=0) ||!_leftMenuView.hidden)&&_leftMenuController) {
            _isShowLeft = YES;
            _leftMenuView.hidden = NO;
            _rightMenView.hidden = YES;
        } else if(((_contentView.transform.tx==0&&point.x<=0)||!_rightMenView.hidden)&&_rightMenuController){
            _isShowLeft = NO;
            _rightMenView.hidden = NO;
            _leftMenuView.hidden = YES;
        }
    }
    
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
        _contentView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:self.animationTime animations:^{
            _leftMenuView.transform = CGAffineTransformMakeTranslation(_menuTranslationDistance, 0);
            _contentView.transform = CGAffineTransformMakeTranslation(_translationDistance, 0);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [UIView animateWithDuration:self.animationTime animations:^{
            _leftMenuView.transform = CGAffineTransformIdentity;
            _contentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                _leftMenuView.hidden = YES;
            }
        }];
    }
}
- (void)showHideRightMenu {
    if (_rightMenView.hidden) {
        _rightMenView.hidden = NO;
        _contentView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:self.animationTime animations:^{
            _rightMenView.transform = CGAffineTransformMakeTranslation(-_menuTranslationDistance, 0);
            _contentView.transform = CGAffineTransformMakeTranslation(-_translationDistance, 0);
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [UIView animateWithDuration:self.animationTime animations:^{
            _rightMenView.transform = CGAffineTransformIdentity;
            _contentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            if (finished) {
                _rightMenView.hidden = YES;
            }
        }];
    }
}
@end
