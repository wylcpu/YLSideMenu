//
//  YLTableView.h
//  YLTableView
//
//  Created by eviloo7 on 16/3/30.
//  Copyright © 2016年 eviloo7. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  使用block使代码显得紧凑
 */
@interface YLTableView : UITableView
/**
 *  数据，可以是一维数组，二维数组
 */
@property (nonatomic,copy) NSArray *dataArray;
/**
 *  设置Identifier,使用的是cell名字,NSString类型
 */
@property (nonatomic,copy) NSArray<NSString*> *cellClassNameArray;
/**
 *  设置header固定高
 */
@property (nonatomic,assign) CGFloat headerHeight;
/**
 *  设置cell固定高
 */
@property (nonatomic,assign) CGFloat cellHeight;
/**
 *  设置footer固定高
 */
@property (nonatomic,assign) CGFloat footerHeight;
/**
 *  设置没有数据时的显示
 */
@property (nonatomic,strong) UIView *noResultView;



/**
 *  设置footer高
 */
@property (nonatomic,copy) CGFloat (^footerHeightBlock)(UITableView *tableView,NSInteger section);
/**
 *  设置header的高
 */
@property (nonatomic,copy) CGFloat (^headerHeightBlock)(UITableView *tableView,NSInteger section);
/**
 *  设置cell的高
 */
@property (nonatomic,copy) CGFloat(^cellHeightBlock)(UITableView *tableView,NSIndexPath *indexPath);
/**
 *  指定使用的cell名字
 */
@property (nonatomic,copy) NSString *(^cellIdentifierBlock)(NSIndexPath*indexPath);
/**
 *  数据填充，使用自定义的cell时，需要强转，（customCell *）cell;
 */
@property (nonatomic,copy) void(^cellData)(UITableViewCell* cell,id data,NSIndexPath *indexPath);
/**
 *  设置headerTitle
 */
@property (nonatomic,copy) NSString *(^headerTitleBlock)(UITableView *tableView,NSInteger section);
/**
 *  设置footerTitle
 */
@property (nonatomic,copy) NSString *(^footerTitleBlock)(UITableView *tableView,NSInteger section);
/**
 *  点击
 */
@property (nonatomic,copy) void(^didSelectCell)(UITableView *tableView,NSIndexPath  *indexPath);
@end
