//
//  JYJCollectionViewCell.m
//  MaiBaoXian
//
//  Created by JYJ on 17/1/21.
//  Copyright © 2017年 17maibaoxian.cn. All rights reserved.
//

#import "JYJCollectionViewCell.h"
#import "UIView+Extension.h"
#import "JYJConst.h"

@interface JYJCollectionViewCell ()
/** titleLabel */
@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIView *leftView;
@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UIView *rigthView;
@property (nonatomic, weak) UIView *topView;

@end

@implementation JYJCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    
    // 预先创建titleLabel
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = JYJColor(51, 51, 51);
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:topView];
    self.topView = topView;
    self.topView.hidden = YES;
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:leftView];
    self.leftView = leftView;
    self.leftView.hidden = YES;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:bottomView];
    self.bottomView = bottomView;
    self.bottomView.hidden = YES;
    
    UIView *rigthView = [[UIView alloc] init];
    rigthView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:rigthView];
    self.rigthView = rigthView;
    self.rigthView.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titleLabelX = 10;
    CGFloat titleLabelY = 0;
    CGFloat titleLabelW = self.width - 2 * titleLabelX ;
    CGFloat titleLabelH = self.height;
    self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    CGFloat topViewX = 0.5;
    CGFloat topViewY = 0.5;
    CGFloat topViewW = self.width - 2 * topViewX;
    CGFloat topViewH = 0.5;
    self.topView.frame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    CGFloat leftViewX = 0.5;
    CGFloat leftViewY = 0.5;
    CGFloat leftViewW = 0.5;
    CGFloat leftViewH = self.height - 2 * leftViewX;
    self.leftView.frame = CGRectMake(leftViewX, leftViewY, leftViewW, leftViewH);
    
    CGFloat bottomViewX = 0.5;
    CGFloat bottomViewH = 0.5;
    CGFloat bottomViewY = self.height - 1;
    CGFloat bottomViewW = self.width - 2 * bottomViewX;
    self.bottomView.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    
    CGFloat rigthViewX = self.width - 1;
    CGFloat rigthViewY = 0.5;
    CGFloat rigthViewW = 0.5;
    CGFloat rigthViewH = leftViewH;
    self.rigthView.frame = CGRectMake(rigthViewX, rigthViewY, rigthViewW, rigthViewH);
}

- (void)setDataFunction:(NSIndexPath *)path andTotalPath:(NSIndexPath *)TotalPath andTitle:(NSString *)title{
    
    self.titleLabel.hidden = NO;
    self.titleLabel.text = title;
    [self HiddenAllSpaceViewFunction];
    [self ViewIsHiddenAndShowFuntion:path andTotalPath:TotalPath];
    
}
- (void)HiddenAllSpaceViewFunction{
    self.topView.hidden = YES;
    self.bottomView.hidden = YES;
    self.rigthView.hidden = YES;
    self.leftView.hidden = YES;
}

- (void)ViewIsHiddenAndShowFuntion:(NSIndexPath *)path andTotalPath:(NSIndexPath *)TotalPath{
    NSInteger DQSection = 0;
    NSInteger DQRow = 0;
    if (TotalPath.section>=0) {//防止为负数
        DQSection = TotalPath.section;
    }
    
    if (TotalPath.row>=0) {
        DQRow = TotalPath.row;
    }
    
    if (DQSection == 0) { //只有一组
        self.leftView.hidden = NO;
        self.rigthView.hidden = NO;
        [self fristShowleftViewAndLastShowRightView:path andTatolPath:TotalPath];
    } else {//两组或者两组以上
        if (path.section == 0) {//第一组
            self.leftView.hidden = NO;
            
            [self fristShowleftViewAndLastShowRightView:path andTatolPath:TotalPath];
            
        } else if (path.section >= DQSection) {//最后一组
            self.rigthView.hidden = NO;
            [self fristShowleftViewAndLastShowRightView:path andTatolPath:TotalPath];
        } else {//中间的
            [self fristShowleftViewAndLastShowRightView:path andTatolPath:TotalPath];
        }
    }
}
- (void)fristShowleftViewAndLastShowRightView:(NSIndexPath *)path andTatolPath:(NSIndexPath *)TotalPath{
    NSInteger DQRow = 0;
    if (TotalPath.row>=0) {//防止为负数
        DQRow = TotalPath.row;
    }
    if (path.row == 0) {
        self.topView.hidden = NO;
    }
    if (path.row >= DQRow) {
        self.bottomView.hidden = NO;
    }
    
}

@end
