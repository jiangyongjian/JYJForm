//
//  JYJTableCell.h
//  MaiBaoXian
//
//  Created by JYJ on 17/1/21.
//  Copyright © 2017年 17maibaoxian.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYJTableCell : UITableViewCell
/** 数据 */
@property (nonatomic, strong) NSArray *data;

/** 宽度 */
@property (nonatomic, strong) NSArray *widthArray;


+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
