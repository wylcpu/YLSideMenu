//
//  YLRightView.m
//  YLSideMenu
//
//  Created by eviloo7 on 16/4/3.
//  Copyright © 2016年 eviloo7. All rights reserved.
//

#import "YLRightView.h"
#import "YLTableView.h"
@implementation YLRightView
- (void)viewDidLoad {
    [super viewDidLoad];
    YLTableView *table = [[YLTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //    table.backgroundView = nil;
//    table.backgroundColor = [UIColor clearColor];
    table.opaque = NO;
    table.frame = CGRectMake(0  , 200, self.view.bounds.size.width, 200);
    table.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    table.cellData = ^(UITableViewCell*cell,id data,NSIndexPath*indexPath){
        cell.backgroundColor = [UIColor clearColor];
        cell.opaque = NO;
        cell.textLabel.text = data;
    };
    
    [self.view addSubview:table];
}

@end
