//
//  LIUZhangHuGuanLiViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/30.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUZhangHuGuanLiViewController.h"

@interface LIUZhangHuGuanLiViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *tableSuperView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSArray *dataArray;

@end

@implementation LIUZhangHuGuanLiViewController

- (NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@"销户",@"激活",@"换卡",@"挂换",@"挂失",@"冻结",@"解冻"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户管理";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tableView.bounces = NO;
    self.tableSuperView.layer.cornerRadius = 15.0;
    self.tableSuperView.layer.masksToBounds = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark TbaleViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArray[indexPath.row];
   // cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewVC = [[UIViewController alloc]init];
    viewVC.view.backgroundColor = [UIColor whiteColor];
    viewVC.title = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:viewVC animated:YES];
}

@end
