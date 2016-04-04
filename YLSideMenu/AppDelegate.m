//
//  AppDelegate.m
//  YLSideMenu
//
//  Created by eviloo7 on 16/4/2.
//  Copyright © 2016年 eviloo7. All rights reserved.
//

#import "AppDelegate.h"
#import "YLSideMenu.h"
#import "ViewView.h"
#import "YLLeftView.h"
#import "YLRightView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    YLLeftView *view = [[YLLeftView alloc] init];
    YLRightView *view2 = [[YLRightView alloc] init];
    view2.view.frame = CGRectMake(300, 100, 200, 300);
    ViewView *mm = [[ViewView alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mm];
   
    YLSideMenu *me = [[YLSideMenu alloc] initWithContentController:nav leftMenuController:view rightMenuController:view2];
    me.scaleContent = 0.6;
    me.scaleMenu = 1.7;
    me.backgroundImage = [UIImage imageNamed:@"Stars"];
    self.window.rootViewController = me;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
