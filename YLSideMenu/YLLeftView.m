//
//  YLLeftView.m
//  MenuPage
//
//  Created by eviloo7 on 16/4/2.
//  Copyright © 2016年 eviloo7. All rights reserved.
//

#import "YLLeftView.h"

@implementation YLLeftView
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *tabe = [[UILabel alloc]  init];
    tabe.text = @"dfhdsufgsuf";
    tabe.textColor = [UIColor blueColor];
    tabe.frame = CGRectMake(0, 200, 100, 20);
    [self.view addSubview:tabe];
//    UIImageView *imge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"qqbgg" ]];
//    imge.frame = self.view.bounds;
//    [self.view addSubview:imge];
    [self.view bringSubviewToFront:tabe];
}
@end
