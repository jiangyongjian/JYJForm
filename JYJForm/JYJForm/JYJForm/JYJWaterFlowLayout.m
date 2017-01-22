//
//  JYJWaterFlowLayout.m
//  瀑布流
//
//  Created by JYJ on 15/11/20.
//  Copyright © 2015年 com.shuai. All rights reserved.
//

#import "JYJWaterFlowLayout.h"
#import "JYJConst.h"

@interface JYJWaterFlowLayout()

//用来保存所有item
@property(nonatomic,strong) NSMutableArray *attrArray;

//用来保存每列最大Y值
@property(nonatomic,strong) NSMutableDictionary *maxXDict;

//用来保存最大X值
@property(nonatomic,assign) CGFloat maxX;

@end

@implementation JYJWaterFlowLayout


#pragma mark -- 实现瀑布流功能方法

//当collectionView第一次要显示的时候会调用此方法来准备布局。
//当collectionView的布局发生变化时，也会来调用此方法。
//当刷新数据时，也会调用此方法。

//在这个方法中计算每一个cell的位置大小(frame)
- (void)prepareLayout{
    [super prepareLayout];
    
    // 清空，防止下次调用
    self.maxX = 0;
    
    //字典列值初始化   解决了 每次获取字典中最小值得问题。
    for(int i = 0;i<self.widthArray.count;i++){
        NSString *key = [NSString stringWithFormat:@"%zd",i];
        self.maxXDict[key] = [NSString stringWithFormat:@"%f", self.maxX];
        CGFloat width = [self.widthArray[i] floatValue];
        self.maxX = self.maxX + width;
    }
    //需要先移除数组中的数据
    [self.attrArray removeAllObjects];
    
    //遍历数据源数组
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //需要自己调用
    for(int i = 0; i<count; i++){ // 3列
        for (int j = 0; j<self.widthArray.count; j++) { // 10组
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:j];
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrArray addObject:attrs];
        }
    }
}

//设置collectionView的可滚动区域的大小。也就是内容大小
- (CGSize)collectionViewContentSize{
    // return [super collectionViewContentSize];
    NSUInteger count = self.widthArray.count - 1;
    NSString *countStr = [NSString stringWithFormat:@"%zd", count];
    //返回字典中最大Y值
    NSString *maxKey = self.maxXDict[countStr];
    CGFloat width = [self.widthArray[count] floatValue];
    NSInteger totalRow = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake([maxKey floatValue] + width, itemCellH * totalRow);
}

//返回每一个子控件(也就是cell)在collectionView的显示区域内的位置大小
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    // return [super layoutAttributesForElementsInRect:rect];
    return self.attrArray;
}

//返回某一个指定cell的属性  默认不会被调用  需要在 prepareLayout 方法中调用
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellH = itemCellH;
    //宽度计算方法
    CGFloat cellW = [self.delegate waterFlow:self cellIndexPath:indexPath];
    
    //X位置 计算方法
    //要求出当前cell是哪一列，然后加上间距和边距就可以了
    NSString *key = [NSString stringWithFormat:@"%zd", indexPath.section];
    NSString *maxX = self.maxXDict[key];
    CGFloat cellX = [maxX floatValue];
    
    //Y位置 计算方法
    CGFloat cellY = cellH * indexPath.item;
    
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attrs.frame = CGRectMake(cellX, cellY, cellW, cellH);
    NSLog(@"%@",attrs);
    return attrs;
}

#pragma mark -- 懒加载

- (NSMutableArray *)attrArray{
    if(_attrArray == nil){
        _attrArray = [NSMutableArray array];
    }
    return _attrArray;
}

- (NSMutableDictionary *)maxXDict{
    if(_maxXDict == nil){
        _maxXDict = [NSMutableDictionary dictionary];
    }
    return _maxXDict;
}

@end
