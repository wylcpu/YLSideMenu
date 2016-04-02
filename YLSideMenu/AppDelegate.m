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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    YLLeftView *view = [[YLLeftView alloc] init];
//    view.view.backgroundColor = [UIColor redColor];
    ViewView *mm = [[ViewView alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mm];
    UIViewController *viewRight = [[UIViewController alloc] init];
    viewRight.view.backgroundColor = [UIColor grayColor];
    YLSideMenu *me = [[YLSideMenu alloc] initWithContentController:nav leftMenuController:view rightMenuController:viewRight];
    me.backgroundImage = [UIImage imageNamed:@"qqbgg"];
    self.window.rootViewController = me;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
