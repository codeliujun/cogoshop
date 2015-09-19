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

@end

@implementation LIUOrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViews];
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
    
    [_cell2View setOrderData:self.orderData];
    
    [_cell3View setOrderDetails:self.orderData[@"OrderDetails"][0]];
    
    [_cell5View setOrderDetail:self.orderData];
    
    [self.tableView reloadData];
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
