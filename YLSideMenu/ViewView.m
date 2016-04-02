//
//  ViewView.m
//  MenuPage
//
//  Created by eviloo7 on 16/4/1.
//  Copyright © 2016年 eviloo7. All rights reserved.
//

#import "ViewView.h"
#import "UIViewController+YLSideMenu.h"
@implementation ViewView
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"23" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"34" style:UIBarButtonItemStylePlain target:self action:@selector(click2)];
    self.view.backgroundColor = [UIColor greenColor];
}
-(void)click{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendA" object:nil];
    [self hideShowLeftMenu];
}
- (void)click2{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"sendB" object:nil ];
    [self hideShowRightMenu];
}
@end
