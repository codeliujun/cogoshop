//
//  LIUOrderDetailController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/7.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUOrderDetailController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "SVProgressHUD.h"
#import "LIUConfirmViewController.h"
#import "LIUOrderModel.h"
#import "LIUEvalatController.h"
#import "MJExtension.h"

#import "LIUGapCell.h"
#import "LIUOrderHeaderView.h"
#import "LIUOrderAddressView.h"
#import "LIUOrderGoodInfo.h"
#import "LIUOtherCost.h"
#import "LIUOrderInfo.h"

@interface LIUOrderDetailController ()<UITableViewDataSource,UITableViewDelegate> {
    LIUOrderHeaderView      *_cell1View;
    LIUOrderAddressView     *_cell2View;
    LIUOrderGoodInfo        *_cell3View;
    LIUOtherCost            *_cell4View;
    LIUOrderInfo            *_cell5View;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSDictionary *orderData;
@property (nonatomic,assign) NSInteger index;

@property (weak, nonatomic) IBOutlet UIView *bottomBackView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation LIUOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViews];
    self.bottomBackView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    self.button.layer.cornerRadius = 5.0f;
    self.button.layer.masksToBounds = YES;
    [self getData];
    self.index = 0;
}

- (void)getData {
    WS(ws);
    [self requestWithUrl:kGetOrderDetail Parameters:@{@"orderid":self.model.Id} Success:^(NSDictionary *result) {
        ws.orderData = result[@"Data"];
        [ws configViews];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
}

- (void)creatViews {
    
    _cell1View = [LIUOrderHeaderView view];
    
    _cell2View = [LIUOrderAddressView view];
    
    _cell3View = [LIUOrderGoodInfo view];
    
    _cell4View = [LIUOtherCost view];
    
    _cell5View = [LIUOrderInfo view];
    
    [self.tableView registerClass:[LIUGapCell class] forCellReuseIdentifier:@"gapCell"];
}

- (void)configViews {
    /*
     typedef NS_ENUM(NSInteger, OrderStatus) {
     OrderStatusAll = 0,
     OrderStatussWillPay = 1,  生成订单了
     OrderStatusDidPay = 2,   //待发货 等于3的适合才是发货
     OrderStatusHaveSender = 4, //已经发货，也就是确认收货了
     OrderStatusEve = 8, //订单已经完成了
     };
     */
    NSInteger status = [self.orderData[@"Status"] integerValue];
    NSInteger index = 1;
    switch (status) {
        case 1:
            index = 1;
            break;
            
        case 3:
            index = 2;
            break;
            
        case 4:
            index = 3;
            break;
            
        case 8:
            index = 4;
            break;
            
        default:
            break;
    }
    self.index = index;
    //[_cell1View setStatusViewHighlighted:4];
    
    self.title = self.orderData[@"OrderStatusDes"];
    [_cell2View setOrderData:self.orderData];
    
    [_cell3View setOrderDetails:self.orderData[@"OrderDetails"][0]];
    
    [_cell5View setOrderDetail:self.orderData];
    
    self.totalLabel.text = [NSString stringWithFormat:@"总金额：￥%@",self.orderData[@"OrderDetails"][0][@"TotalMoney"]];
    [self configButton];
    
    [self.tableView reloadData];
}

- (void)configButton {
    
    NSInteger status = [self.orderData[@"Status"] integerValue];
    NSString *title = @"不可用";
    switch (status) {
        case 1:
            title = @"付款";//@"付款";
            break;
        case 2:
            title = @"提醒发货";
            break;
        case 4:
            title = @"确认收货";
            break;
        case 8:
            title = @"待评价";
            break;
        default:
            title = @"不可用";
            break;
    }
    [self.button setTitle:title forState:UIControlStateNormal];
    if ([title isEqualToString:@"不可用"]) {
        self.button.enabled = NO;
        self.button.backgroundColor = [UIColor lightGrayColor];
    }else {
        self.button.enabled = YES;
        self.button.backgroundColor = [UIColor redColor];
    }
    
}
- (IBAction)tapButton:(UIButton *)sender {

    NSString *title = sender.titleLabel.text;
    
    if ([title isEqualToString:@"提醒发货"]) {
        [self requestWithUrl:kRemindDeliver Parameters:@{@"userid":[self getUserId],@"orderid":self.orderData[@"OrderId"]} Success:^(NSDictionary *result) {
            
            [SVProgressHUD showSuccessWithStatus:@"提醒发货成功" duration:1.5f];
            //[ws.navigationController popViewControllerAnimated:YES];
        } Failue:^(NSDictionary *failueInfo) {
            
        }];
    }
    
    if ([title isEqualToString:@"付款"]) {
        LIUConfirmViewController *controller = [[LIUConfirmViewController alloc]init];
        LIUOrderModel *model = [LIUOrderModel objectWithKeyValues:self.orderData];
        controller.orderModel = model;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if ([title isEqualToString:@"确认收货"]) {
        
        [self requestWithUrl:kReciveCOnfirm Parameters:@{@"userid":[self getUserId],@"orderid":self.orderData[@"OrderId"]} Success:^(NSDictionary *result) {
            
            [SVProgressHUD showSuccessWithStatus:@"确认收货成功" duration:1.5f];
            
        } Failue:^(NSDictionary *failueInfo) {
            
        }];
        
    }
    
    if ([title isEqualToString:@"待评价"]) {
        
        LIUEvalatController *evaVc = [[LIUEvalatController alloc]init];
        LIUOrderModel *order = [LIUOrderModel objectWithKeyValues:self.orderData];
        evaVc.model = order;
        [self.navigationController pushViewController:evaVc animated:YES];
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LIUGapCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gapCell" forIndexPath:indexPath];
    
    if (0 == indexPath.row) {
        [cell setCellCustomView:_cell1View];
        [_cell1View setStatusViewHighlighted:self.index];
    }
    
    if (1 == indexPath.row) {
        [cell setCellCustomView:_cell2View];
    }
    
    if (2 == indexPath.row) {
        [cell setCellCustomView:_cell3View];
    }
    
    if (3 == indexPath.row) {
        [cell setCellCustomView:_cell4View];
    }
    
    if (4 == indexPath.row) {
        [cell setCellCustomView:_cell5View];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 44.f;
    
    if (0 == indexPath.row) {
        height = _cell1View.frame.size.height;
    }
    
    if (1 == indexPath.row) {
        height = _cell2View.frame.size.height;
    }
    
    if (2 == indexPath.row) {
        height = _cell3View.frame.size.height;
    }
    
    if (3 == indexPath.row) {
        height = _cell4View.frame.size.height;
    }
    
    if (4 == indexPath.row) {
        height = _cell5View.frame.size.height;
    }
    
    return height;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}


@end
