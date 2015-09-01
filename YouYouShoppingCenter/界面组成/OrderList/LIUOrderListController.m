//
//  LIUOrderListController.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUOrderListController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "MJExtension.h"
#import "LIUEvalatController.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUOrderListController ()<UITableViewDataSource,UITableViewDelegate,LIUOrderTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic ,strong)NSArray *orderListArray;

@end

@implementation LIUOrderListController

- (NSArray *)orderListArray {
    if (!_orderListArray) {
        _orderListArray = @[];
    }
    
    return _orderListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LIUOrderTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LIUOrderTableViewCell class])];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getData];
}

- (void)getData {
    /*userid={userid}&pageindex={pageindex}&pagesize={pagesize}&orderstatus={orderstatus}&begintime={begintime}&endtime={endtime}*/
    WS(ws);
    NSString *orderStatus = @"1";
    
    switch (self.status) {
        case OrderStatusAll:
            orderStatus = @"0";
            break;
        case OrderStatussWillPay:
            orderStatus = @"1";
            break;
        case OrderStatusHaveSender:
            orderStatus = @"4";
            break;
        case OrderStatusEve:
            orderStatus = @"8";
            break;
        default:
            break;
    }
    
    
    [self requestWithUrl:KGetOrderList Parameters:@{
                                @"userid":[self getUserId],
                                @"pageindex":@1,
                                @"pagesize":@20,
                                @"goodsname":@"",
                                @"shopname":@"",
                                @"orderstatus":orderStatus,
                                @"begintime":@"",
                                @"endtime":@""}
    Success:^(NSDictionary *result) {
        NSArray *arr = result[@"Data"];
        ws.orderListArray = [LIUOrderModel objectArrayWithKeyValuesArray:arr];
        [ws.tableView reloadData];
        NSLog(@"%@",result);
        
    } Failue:^(NSDictionary *failueInfo) {
        
    }];;
    
    
}

#pragma --mark Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.orderListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LIUOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LIUOrderTableViewCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    cell.status = self.status;
    cell.order = self.orderListArray[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

- (void)cellDidTapButton:(LIUOrderTableViewCell *)cell {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    LIUOrderModel *order = self.orderListArray[indexPath.section];
    
    if (self.status == OrderStatusEve) {
        
        LIUEvalatController *evaVc = [[LIUEvalatController alloc]init];
        evaVc.model = order;
        [self.navigationController pushViewController:evaVc animated:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
