//
//  JYJCollectionViewCell.h
//  MaiBaoXian
//
//  Created by JYJ on 17/1/21.
//  Copyright © 2017年 17maibaoxian.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYJCollectionViewCell : UICollectionViewCell
//赋值的方法
- (void)setDataFunction:(NSIndexPath *)path andTotalPath:(NSIndexPath *)TotalPath andTitle:(NSString *)title;
@end
