//
//  JYJTableCell.m
//  MaiBaoXian
//
//  Created by JYJ on 17/1/21.
//  Copyright © 2017年 17maibaoxian.cn. All rights reserved.
//

#import "JYJTableCell.h"
#import "JYJTableCell.h"
#import "JYJWaterFlowLayout.h"
#import "JYJCollectionViewCell.h"
#import "UIView+Extension.h"
#import "JYJConst.h"


/** CollectionViewCell */
static NSString *const CollectionViewCell = @"CollectionViewCell";

@interface JYJTableCell () <UICollectionViewDelegate, UICollectionViewDataSource, JYJWaterFlowLayoutDelegate>

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
/** flowLayout */
@property (nonatomic, weak) JYJWaterFlowLayout *flowLayout;

/** 背景 */
@property (nonatomic, weak) UIView *bgView;

@end

@implementation JYJTableCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    // 创建cell
    static NSString *ID = @"PersonDetailCell";
    JYJTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[JYJTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 初始化操作
        [self setupSubviews];
        
    }
    return self;
}

/**
 *  初始化子控件
 */
- (void)setupSubviews {
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    self.bgView = bgView;
    
    // 创建一个流水布局
    JYJWaterFlowLayout *flowLayout = [[JYJWaterFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //cell间距
    flowLayout.minimumInteritemSpacing = 0;
    //cell行距
    flowLayout.minimumLineSpacing = 0;
    flowLayout.delegate = self;
    
    // 创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    // 注册一个cell
    [collectionView registerClass:[JYJCollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCell];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    // 设置数据源对象
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.contentView addSubview:collectionView];
    self.collectionView = collectionView;
    self.flowLayout = flowLayout;

}

- (void)setData:(NSArray *)data {
    _data = data;
    [self.collectionView reloadData];
}

- (void)setWidthArray:(NSArray *)widthArray {
    _widthArray = widthArray;
    self.flowLayout.widthArray = widthArray;
    [self.collectionView reloadData];
}

#pragma mark -- UICollectionViewDataSource 数据源方法

//返回 一共有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.data.count;
}

//返回 每组一共有多少item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = [self.data firstObject];
    return arr.count;
}

//返回 每个item具体样子
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JYJCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = self.data[indexPath.section];
    // 给cell设置数据
    [cell setDataFunction:indexPath andTotalPath:[NSIndexPath indexPathForRow:arr.count -1 inSection:self.data.count -1] andTitle:arr[indexPath.row]];
    return cell;
}


- (CGFloat)waterFlow:(JYJWaterFlowLayout *)waterFlow cellIndexPath:(NSIndexPath *)indexPath {
    
    return [self.widthArray[indexPath.section] floatValue];
}

/**
 * 设置子控件的frame
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat cellH = self.contentView.height;
    CGFloat cellW = JYJScreenW;
    
    /** 背景 */
    CGFloat bgViewX = 10;
    CGFloat bgViewY = 10;
    CGFloat bgViewW = cellW - 2 * bgViewX;
    CGFloat bgViewH =cellH - 2 * bgViewY;
    self.bgView.frame = CGRectMake(bgViewX, bgViewY, bgViewW, bgViewH);
    self.collectionView.frame = self.bgView.frame;
}
@end


