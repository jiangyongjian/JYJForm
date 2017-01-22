//
//  JYJWaterFlowLayout.h
//  瀑布流
//
//  Created by JYJ on 15/11/20.
//  Copyright © 2015年 com.shuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JYJWaterFlowLayout;
@protocol JYJWaterFlowLayoutDelegate <NSObject>

// 计算item高度
- (CGFloat)waterFlow:(JYJWaterFlowLayout *)waterFlow cellIndexPath:(NSIndexPath *)indexPath;

@end

@interface JYJWaterFlowLayout : UICollectionViewFlowLayout

//数据源  从中可以获得每个cell的宽高 和 一共有多少个cell
@property(nonatomic,strong) NSArray *widthArray;

@property(nonatomic,weak) id<JYJWaterFlowLayoutDelegate> delegate;
@end
