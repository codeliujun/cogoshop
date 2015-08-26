//
//  LIUQueRenDingController.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/23.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUQueRenDingController.h"
#import "LIUQueRenTableViewCell.h"
#import "LIUAddressChooseView.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUAdressManagerViewController.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUQueRenDingController ()<UITableViewDataSource,UITableViewDelegate,LIUAdressManagerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) LIUAddressChooseView *addressView;

@property (nonatomic,strong)NSArray *addressArray;
@property (nonatomic,strong)NSArray *orderList;

@end

@implementation LIUQueRenDingController

- (NSArray *)orderList {
    
    if (!_orderList) {
        _orderList = @[];
    }
    
    return _orderList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"LIUQueRenTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
    [self addHeaderView];
    [self getData];
}

- (void)getData {
    
    WS(ws);
    //获取订单/*userid={userid}&pageindex={pageindex}&pagesize={pagesize}&goodsname={goodsname}&shopname={shopname}&orderstatus={orderstatus}&begintime={begintime}&endtime={endtime}*/
    [self requestWithUrl:KGetOrderList Parameters:@{
                                                    @"userid":[self getUserId],
                                                    @"pageindex":@1,
                                                    @"pagesize":@20,
                                                    @"goodsname":@"",
                                                    @"shopname":@"",
                                                    @"orderstatus":@1,
                                                    @"begintime":@"",
                                                    @"endtime":@""}
                 Success:^(NSDictionary *result) {
                     ws.orderList = [LIUOrderModel objectArrayWithKeyValuesArray:result[@"Data"]];
                     [ws.tableView reloadData];
                 } Failue:^(NSDictionary *failueInfo) {
                     
                 }];
    [self getAddressData];
}

- (void)getAddressData {
    WS(ws);
    //获取收货地址 //pageindex={pageindex}&pagesize={pagesize}
    [self requestWithUrl:kGetAddressList Parameters:@{@"pageindex":@1,@"userid":[self getUserId],@"pagesize":@20} Success:^(NSDictionary *result) {
        NSArray *arr = result[@"Data"];
        if (arr.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"地址获取失败" duration:1.5f];
            return ;
        }
        
        ws.addressArray = [LIURecevingAderess objectArrayWithKeyValuesArray:result[@"Data"]];
        
        for (LIURecevingAderess *address in ws.addressArray) {
            if (address.IsDefault) {
                [ws.addressView setAddRess:address];
                break;
            }
        }
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
    
}

- (void)addHeaderView {
    WS(ws);
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 90)];
    self.addressView = [LIUAddressChooseView view];
    
    self.addressView.didTapButtonBlock = ^ {
        [ws changeRecevingAdress];
    };
    [view addSubview:self.addressView];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view).insets(UIEdgeInsetsZero);
    }];
    self.tableView.tableHeaderView = view;
}

#pragma --mark 修改收货地址
- (void)changeRecevingAdress {
    LIUAdressManagerViewController *addressVC = [LIUAdressManagerViewController new];
    addressVC.addressArray = self.addressArray;
    addressVC.delegate = self;
    [self presentViewController:addressVC animated:YES completion:nil];
}

- (void)didSelectAddress:(LIURecevingAderess *)address {
    [self.addressView setAddRess:address];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.orderList.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LIUOrderModel *orderModel = self.orderList[section];
    NSArray *detail = orderModel.OrderDetails;
    return detail.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LIUQueRenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    LIUOrderModel *orderModel = self.orderList[indexPath.section];
    NSArray *detail = orderModel.OrderDetails;
    LIUOrderdetails *detaile = detail[indexPath.row];
    cell.orderDetail = detaile;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 20)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel  alloc]init];
    LIUOrderModel *order = self.orderList[section];
    label.text = [NSString stringWithFormat:@"订单编号：%@",order.Id];
    label.font = [UIFont systemFontOfSize:20.0f];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view).insets(UIEdgeInsetsMake(0, 10, 0, 0));
    }];
    
    return view;
}


@end
