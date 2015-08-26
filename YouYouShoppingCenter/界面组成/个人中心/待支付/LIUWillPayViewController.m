//
//  LIUWillPayViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/30.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUWillPayViewController.h"
#import "LIUWillPayTableViewCell.h"
#import "LIUQueRenDingController.h"
#import "LIUPersonModel.h"
#import "LIUOrderModel.h"

@interface LIUWillPayViewController ()<UITableViewDataSource,UITableViewDelegate,LIUWillPayTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *willPayOrder;

@end

@implementation LIUWillPayViewController

- (NSArray *)willPayOrder {
    if (!_willPayOrder) {
        _willPayOrder = [[LIUPersonModel defaultUser].willPayOrders copy];
    }
    return _willPayOrder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"LIUWillPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark TableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.willPayOrder.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LIUWillPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.orderModel = self.willPayOrder[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (void)cellDidTapPayButtonWithOrder:(LIUOrderModel *)order {
    LIUQueRenDingController *confirmVC = [LIUQueRenDingController new];
   // confirmVC.orderModel = order;
    //[self.navigationController pushViewController:confirmVC animated:YES];
    [self presentViewController:confirmVC animated:YES completion:nil];
}

@end
