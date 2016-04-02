//
//  UIViewController+YLSideMenu.m
//  YLSideMenu
//
//  Created by eviloo7 on 16/4/3.
//  Copyright © 2016年 eviloo7. All rights reserved.
//

#import "UIViewController+YLSideMenu.h"
#import "YLSideMenu.h"
@implementation UIViewController (YLSideMenu)
- (YLSideMenu *)sideMenuController {
    UIViewController *controller = self.parentViewController;
   
    while (![controller isKindOfClass:[YLSideMenu class]]) {
        controller = controller.parentViewController;
        if (controller == nil ) {
            return nil;
        }
    }
    if ([controller isKindOfClass:[YLSideMenu class]]) {
        return (YLSideMenu*)controller;
    }
    return nil;
}
-(void)hideShowLeftMenu{
    [[self sideMenuController] showHideLeftMenu];
}
- (void)hideShowRightMenu{
    [[self sideMenuController] showHideRightMenu];
}
@end
