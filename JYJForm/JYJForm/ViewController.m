//
//  ViewController.m
//  JYJForm
//
//  Created by JYJ on 17/1/22.
//  Copyright © 2017年 baobeikeji. All rights reserved.
//

#import "ViewController.h"
#import "JYJTableCell.h"
#import "JYJConst.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
/** tableView */
@property (nonatomic, weak) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray *data1;

@property (nonatomic, strong) NSMutableArray *data2;

/** 宽度 */
@property (nonatomic, strong) NSArray *widthArray1;
@property (nonatomic, strong) NSArray *widthArray2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, JYJScreenW, JYJScreenH);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = JYJColor(235, 235, 235);
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView = tableView;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"觉得牛逼请点个赞";
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:25];
    label.frame = CGRectMake(0, JYJScreenH - 100, JYJScreenW, 100);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    [self setupdata];
    
    
}

- (void)setupdata {
    NSArray *arr =  @[@[@"尺寸",@"非常好",@"灰色垃圾",@"蓝色",@"红色"],
                      @[@"SM",@"0000",@"10",@"2",@"02"],
                      @[@"S",@"10",@"20",@"3",@"03"],
                      @[@"MMMM",@"20",@"0",@"4",@"04"],
                      @[@"L",@"0",@"20000",@"5",@"5"],
                      @[@"XL",@"20",@"10",@"6",@"6"],
                      @[@"XXL",@"10",@"10",@"7",@"7"],
                      @[@"KKKK",@"10",@"10",@"8",@"8"],
                      @[@"XXL",@"10",@"10",@"9",@"9"],
                      @[@"总计",@"60",@"70",@"10",@"10"]];//二维数组
    // 这里的数据源 必定是二维数组
    self.data1 = [arr mutableCopy];
    self.data2 = [arr mutableCopy];
    // 跟着每组最大的宽度设置
    self.widthArray1 = @[@80, @120, @100, @140, @80, @100, @160, @200,@80, @140];
    self.widthArray2 = @[@100, @180, @100, @180, @80, @100, @200, @100,@80, @100];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JYJTableCell *cell = [JYJTableCell cellWithTableView:tableView];
    if (indexPath.row == 0) {
        cell.data = self.data1;
        cell.widthArray = self.widthArray1;
    } else {
        cell.data = self.data2;
        cell.widthArray = self.widthArray2;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
       NSArray *arr = [self.data1 firstObject];
        return itemCellH * arr.count + 20;
    } else {
        NSArray *arr = [self.data2 firstObject];
        return itemCellH * arr.count + 20;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
