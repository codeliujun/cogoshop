//
//  LIUQueRenDingController.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/23.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#define kGoodsCartCell          @"cell"

#import "LIUQueRenDingController.h"
//#import "LIUQueRenTableViewCell.h"
#import "LIUAddressChooseView.h"
#import "UIColor+HexColor.h"
#import "LIUCaquView.h"
#import "LIUCartGoodModel.h"
#import "Masonry.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUGoodsCartTableViewCell.h"
#import "LIUAdressManagerViewController.h"
#import "LIUConfirmViewController.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUQueRenDingController ()<UITableViewDataSource,UITableViewDelegate,LIUAdressManagerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (nonatomic ,strong) LIUAddressChooseView *addressView;

@property (nonatomic,strong)LIURecevingAderess *currentAddress;

@property (nonatomic,strong)NSArray *addressArray;
@property (nonatomic,strong)LIUCaquView *caquView;

@end

@implementation LIUQueRenDingController


- (LIUCaquView *)caquView {
    
    if (!_caquView) {
        WS(ws);
        _caquView = [LIUCaquView view];
        _caquView.confirmButtonBlock = ^() {
            /*
             shopid={shopid}&userid={userid}&addressid={addressid}
             */
            
            NSMutableArray *shopIdStrArr = @[].mutableCopy;
            
            for (LIUCartGoodModel *model in ws.orderList) {
                [shopIdStrArr addObject:model.ShopId];
            }
            
            NSString *shopId = nil;
            if (shopIdStrArr.count == 0) {
                return ;
            }
            if (shopIdStrArr.count == 1) {
                shopId = shopIdStrArr[0];
            }else {
                shopId = [shopIdStrArr componentsJoinedByString:@","];
            }
            
            //跳转支付
            [ws requestWithUrl:kCreatOrder Parameters:@{@"shopid":shopId,
                                                        @"userid":[ws getUserId],
                                                        @"addressid":ws.currentAddress.Id} Success:^(NSDictionary *result) {
        LIUConfirmViewController *confirm = [[LIUConfirmViewController alloc]init];
        confirm.orderModel = [LIUOrderModel objectWithKeyValues:result[@"Data"]];
        [ws.navigationController pushViewController:confirm animated:YES];
                                                        } Failue:^(NSDictionary *failueInfo) {
                                                            
                                                        }];
            
            //            LIUConfirmViewController *confirm = [[LIUConfirmViewController alloc]init];
            //            confirm.orederModels = ws.orderList;
            //            [ws.navigationController pushViewController:confirm animated:YES];
            
        };
    }
    return _caquView;
    
}

- (NSArray *)orderList {
    
    if (!_orderList) {
        _orderList = @[];
    }
    
    return _orderList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    [self.tableView registerNib:[UINib nibWithNibName:@"LIUGoodsCartTableViewCell" bundle:nil] forCellReuseIdentifier:kGoodsCartCell];
    //    [self.tableView registerNib:[UINib nibWithNibName:@"LIUQueRenTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
    [self addHeaderView];
    [self addFootView];
    [self getData];
}

- (void)addFootView {
    
    WS(ws);
    [self.footView addSubview:self.caquView];
    [self.caquView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.footView).insets(UIEdgeInsetsZero);
    }];
    
    [self.view addSubview:self.footView];
    //    [self.view bringSubviewToFront:view];
    
}

- (void)getData {
    
    WS(ws);
    //获取订单/*userid={userid}&pageindex={pageindex}&pagesize={pagesize}&goodsname={goodsname}&shopname={shopname}&orderstatus={orderstatus}&begintime={begintime}&endtime={endtime}*/
    //    [self requestWithUrl:KGetOrderList Parameters:@{
    //                                                    @"userid":[self getUserId],
    //                                                    @"pageindex":@1,
    //                                                    @"pagesize":@20,
    //                                                    @"goodsname":@"",
    //                                                    @"shopname":@"",
    //                                                    @"orderstatus":@1,
    //                                                    @"begintime":@"",
    //                                                    @"endtime":@""}
    //                 Success:^(NSDictionary *result) {
    //                     ws.orderList = [LIUOrderModel objectArrayWithKeyValuesArray:result[@"Data"]];
    //                     [ws caqulateTotalPrice];
    //                     [ws.tableView reloadData];
    //                 } Failue:^(NSDictionary *failueInfo) {
    //
    //                 }];
    [self getAddressData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self caqulateTotalPrice];
}

- (void)caqulateTotalPrice {
    
    CGFloat total = 0.0f;
    
    for (LIUCartGoodModel *model in self.orderList) {
        
        total = total+([model.TotalMoney floatValue]);
        
    }
    
    self.caquView.priceLabel.text = [NSString stringWithFormat:@"%.2f",total];
    
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
                ws.currentAddress = address;
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
    self.currentAddress = address;
    [self.addressView setAddRess:address];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    LIUQueRenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    //    LIUOrderModel *orderModel = self.orderList[indexPath.row];
    //    cell.mode = orderModel;
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    LIUGoodsCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsCartCell forIndexPath:indexPath];
    cell.cartGood = self.orderList[indexPath.row];
    //cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}
@end
