//
//  YLSideMenu.h
//  YLSideMenu
//
//  Created by eviloo7 on 16/4/2.
//  Copyright © 2016年 eviloo7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+YLSideMenu.h"
@interface YLSideMenu : UIViewController
/**
 *  设置可以滑动的距离，默认是屏幕的0.8宽
 */
@property (nonatomic,assign)CGFloat translationDistance;
/**
 *  菜单栏的滑动距离
 */
@property (nonatomic,assign)CGFloat menuTranslationDistance;
/**
 *  默认是1，没有缩放效果
 */
@property (nonatomic,assign)CGFloat scaleMenu;
@property (nonatomic,assign)CGFloat scaleContent;
/**
 *  默认是0.3s
 */
@property (nonatomic,assign)CGFloat animationTime;
/**
 *  设置图片背景
 */
@property (nonatomic,strong) UIImage *backgroundImage;
/**
 *  设置背景颜色
 */
@property (nonatomic,strong) UIColor *backgroundColor;

@property (nonatomic,copy) void(^beginSlideMenu)(YLSideMenu*menu,UIViewController*controller);
@property (nonatomic,copy) void(^endSlideMenu)(YLSideMenu*menu,UIViewController*controller);

- (instancetype)initWithContentController:(UIViewController*)contentController leftMenuController:(UIViewController *)leftMenuController rightMenuController:(UIViewController *)rightMenuController;
- (instancetype)initWithContentController:(UIViewController*)contentController leftMenuController:(UIViewController *)leftMenuController;
- (instancetype)initWithContentController:(UIViewController *)contentController rightMenuController:(UIViewController *)rightMenuController;
/**
 *  显示和隐藏左菜单
 */
- (void)showHideLeftMenu;
/**
 *  显示和隐藏有菜单
 */
- (void)showHideRightMenu;



@end
