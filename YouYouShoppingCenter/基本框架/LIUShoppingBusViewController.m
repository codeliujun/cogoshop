//
//  LIUShoppingBusViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/17.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUShoppingBusViewController.h"
#import "LIUGouWuCheTableViewCell.h"
#import "LIUShoppingDetaileViewController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUGouWuCheModel.h"
#import "LIUCartGoodModel.h"
#import "LIUOrderModel.h"
#import "Masonry.h"
#import "LIUUserInfoData.h"
#import "LIULoginViewController.h"
#import "LIUPersonModel.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUShoppingBusViewController ()<UITableViewDataSource,UITableViewDelegate,LIUGouWuCheTableViewCellDelegate,LIULoginViewControllerDelegate>

@property (nonatomic,strong)LIULoginViewController *loginVC;

//结算页的属性
@property(nonatomic,strong)UIButton *settleButton;//结算的button
@property(nonatomic,strong)UILabel *freightLabel;//是否含运费
@property(nonatomic,strong)UILabel *totalLabel;//合计
@property(nonatomic,strong)UIButton *allSelect;//全选
@property (weak, nonatomic) IBOutlet UIView *settleView;

@property (weak, nonatomic) IBOutlet UITableView *willPayTableView;//tableView
@property (weak, nonatomic) IBOutlet UIView *noShoppingView;
@property (weak, nonatomic) IBOutlet UIView *haveShoppingView;
@property(nonatomic,strong)LIUPersonModel *personModel;
@property(nonatomic,strong)LIUUserInfoData *userInfo;
@property (weak, nonatomic) IBOutlet UIButton *goGuangGuangBUtton;

//编辑，完成按钮
@property(nonatomic,strong)UIBarButtonItem *editButton;
@property(nonatomic,strong)UIBarButtonItem *doneButton;
@property(nonatomic,assign)BOOL isEdit;

//购物车 数据
@property(nonatomic,strong)NSMutableArray *cartGoodData;

@end

@implementation LIUShoppingBusViewController

- (LIUUserInfoData *)userInfo {
    if (!_userInfo) {
        _userInfo = [LIUUserInfoData defaultUserInfo];
    }
    return _userInfo;
}

- (UIBarButtonItem *)editButton {
    if (!_editButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(editDidTap:) forControlEvents:UIControlEventTouchUpInside];
        _editButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    return _editButton;
}

- (UIBarButtonItem *)doneButton {
    if (!_doneButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(editDidTap:) forControlEvents:UIControlEventTouchUpInside];
        _doneButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    return _doneButton;
}

- (LIUPersonModel *)personModel {
    if (!_personModel) {
        _personModel = [LIUPersonModel defaultUser];
    }
    return _personModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.willPayTableView registerNib:[UINib nibWithNibName:@"LIUGouWuCheTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
    [self creatSettleView];
    self.cartGoodData = [NSMutableArray new];
    self.isEdit = NO;
    self.navigationItem.rightBarButtonItem = self.editButton;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //1.判断是否登录 ，登录了 才会请求
    if (![self userIsLogin]) {
        //没有登录
        self.noShoppingView.hidden = NO;
        self.haveShoppingView.hidden = YES;
        [self.goGuangGuangBUtton setTitle:@"登录" forState:UIControlStateNormal];
    }else {
        //登录，就要发送请求
        
        [self requestWithUrl:kGetCartGood Parameters:@{@"userid":[self getUserId]} Success:^(NSDictionary *result) {
            if ([result[@"ErrorCode"] integerValue] == 200) {
                NSArray *array = result[@"Data"];
                if (array.count <= 0) {
                    [self.goGuangGuangBUtton setTitle:@"去逛逛" forState:UIControlStateNormal];
                }else {
                    self.cartGoodData = [LIUCartGoodModel objectArrayWithKeyValuesArray:array];
                    [self.willPayTableView reloadData];
                }
            }
        } Failue:^(NSDictionary *failueInfo) {
            NSLog(@"%@",failueInfo);
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"dfghjkl;'");
}

#pragma --mark 创建结算页
- (void)creatSettleView {
    WS(ws);
    //1.创建结算的button，并添加进去
    self.settleButton = [[UIButton alloc]init];
    [self.settleView addSubview:self.settleButton];
    [self.settleButton setTitle:@"结算(0)" forState:UIControlStateNormal];
    self.settleButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.settleButton addTarget:self action:@selector(jiesuan:) forControlEvents:UIControlEventTouchUpInside];
    [self.settleButton setBackgroundColor:[UIColor redColor]];
    [self.settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.settleView);
        make.right.equalTo(ws.settleView);
        make.bottom.equalTo(ws.settleView);
        make.width.equalTo(@90);
    }];
    
    //2.创建不含邮费的label
    self.freightLabel = [[UILabel alloc]init];
    self.freightLabel.text = @"不含邮费";
    self.freightLabel.textAlignment = NSTextAlignmentCenter;
    self.freightLabel.font = [UIFont systemFontOfSize:9];
    CGRect rect = [self.freightLabel textRectForBounds:CGRectMake(0, 0, 100, 20) limitedToNumberOfLines:1];
    NSLog(@"%@",NSStringFromCGRect(rect));
    [self.settleView addSubview:self.freightLabel];
    [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.settleButton);
        make.right.equalTo(ws.settleButton.mas_left).with.offset(-10);
        make.width.equalTo(@(rect.size.width));
        make.height.equalTo(@(rect.size.height));
    }];
    
    //3.创建合计的label，因为这里总是要改，所以单独写一个方法
    [self creatTotalLabelWithStr:@"合计:￥100"];
    
    //4.创建全选的button
    self.allSelect = [[UIButton alloc]init];
    [self.allSelect setBackgroundImage:[UIImage imageNamed:@"icon_checkbox_unchecked"] forState:UIControlStateNormal];
    [self.allSelect setBackgroundImage:[UIImage imageNamed:@"icon_checkbox_checked"] forState:UIControlStateSelected];
    [self.allSelect addTarget:self action:@selector(selectAllShopping:) forControlEvents:UIControlEventTouchUpInside];
    [self.settleView addSubview:self.allSelect];
    
    [self.allSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.settleView.mas_left).offset(10);
        make.centerY.equalTo(ws.settleButton);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"全选";
    label.font = [UIFont systemFontOfSize:11];
    [self.settleView addSubview:label];
    rect = [label textRectForBounds:CGRectMake(0, 0, 100, 100) limitedToNumberOfLines:1];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.allSelect.mas_right).with.offset(10);
        make.centerY.equalTo(ws.allSelect);
        make.width.equalTo(@(rect.size.width));
        make.height.equalTo(@(rect.size.height));
    }];
    
}

#pragma --mark 更新有货的View
- (void)updateHaveShoppingView{
    
}

#pragma --mark 选择所有的商品
- (void)selectAllShopping:(UIButton *)sender {
    sender.selected = !sender.selected;
    for (LIUGouWuCheModel *gouwuModel in self.personModel.gouWuCheGoods) {
        for (LIUGoodModel *model in gouwuModel.didInGouWuCheGoods) {
            model.isSelect = sender.selected;
        }
    }
    [self.willPayTableView reloadData];
    [self updateTotalLabel];
}

#pragma --mark 创建结算的label
- (void)creatTotalLabelWithStr:(NSString *)str {
    WS(ws);
    [self.totalLabel removeFromSuperview];
    //self.totalLabel = nil;
    self.totalLabel = [[UILabel alloc]init];
    
    NSMutableAttributedString *attributeString = [[[NSAttributedString alloc]initWithString:str] mutableCopy];
    NSRange range = NSMakeRange(0, 3);
    [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:11]} range:range];
    self.totalLabel.textColor = [UIColor redColor];
    self.totalLabel.font = [UIFont systemFontOfSize:9];
    [self.settleView addSubview:self.totalLabel];
    self.totalLabel.attributedText = attributeString;
    CGRect rect = [self.totalLabel textRectForBounds:CGRectMake(0, 0, 100, 20) limitedToNumberOfLines:1];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.freightLabel.mas_left).with.offset(-10);
        make.centerY.equalTo(ws.settleButton);
        make.width.equalTo(@(rect.size.width));
        make.height.equalTo(@(rect.size.height));
    }];
    
}

#pragma --mark 结算按钮
- (void)jiesuan:(UIButton*)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"结算(0)"]) {
        NSLog(@"您还没有选择货物");
    }else{
//        //结算的时候生成订单
//        LIUOrderModel *orderModel = [self creatOrder];
//        if (orderModel == nil) {
//            NSLog(@"生成订单失败");
//            return;
//        }
//        
//        //将订单添加到用户的将要支付的订单中
//        [self.personModel.willPayOrders addObject:orderModel];
//        
//        self.allSelect.selected = NO;
////        NSLog(@"去结算了了");
//        LIUConfirmBookingViewController *confirmBookingVC = [LIUConfirmBookingViewController new];
//        //confirmBookingVC.orderModel = orderModel;
//        [self presentViewController:confirmBookingVC animated:YES completion:nil];
    }
}

//#pragma --mark 生成订单
//- (LIUOrderModel *)creatOrder{
//    
//    LIUOrderModel *orderModel = [LIUOrderModel new];
//    orderModel.orderTime = [[NSDate alloc]init];
//    orderModel.orderNumber = @"1234567890";
//    
//    NSMutableArray *array = [NSMutableArray new];
//    NSMutableIndexSet *waiIndexSet = [NSMutableIndexSet new];//保存下标来删除
//    for (int i = 0; i < self.personModel.gouWuCheGoods.count; i++){
//        LIUGouWuCheModel *oldModel = self.personModel.gouWuCheGoods[i];
//        LIUGouWuCheModel *newGouWuModel = [LIUGouWuCheModel new];
//        newGouWuModel.storeName = oldModel.storeName;
//        
//        //记录需要删除的下标
//        NSMutableIndexSet *delectIndexSet = [NSMutableIndexSet new];
//        for (int j = 0; j < oldModel.didInGouWuCheGoods.count; j++){
//            LIUGoodModel *good = oldModel.didInGouWuCheGoods[j];
//            if (good.isSelect == YES) {
//                [newGouWuModel.didInGouWuCheGoods addObject:good];
//                [delectIndexSet addIndex:j];
//            }
//        }
//        
//        //循环完了之后，删除不要的
//        [oldModel.didInGouWuCheGoods removeObjectsAtIndexes:delectIndexSet];
//        
//        if (newGouWuModel.didInGouWuCheGoods.count != 0) {
//            [array addObject:newGouWuModel];
//        }
//        
//        if (oldModel.didInGouWuCheGoods.count == 0) {
//            [waiIndexSet addIndex:i];
//        }
//    }
//    
//    //循环完了之后，删除不要的
//    [self.personModel.gouWuCheGoods removeObjectsAtIndexes:waiIndexSet];
//    
//    orderModel.willPayGoods = [array copy];
//    
//    return orderModel;
//}


#pragma --mark 点击编辑
- (void)editDidTap:(UIButton *)sender {
    self.isEdit = !self.isEdit;
    self.navigationItem.rightBarButtonItem = self.isEdit?self.doneButton:self.editButton;
    [self.willPayTableView reloadData];
}

#pragma --mark 去逛逛
- (IBAction)goGuangGuang:(id)sender {
    WS(ws);
    if (![self userIsLogin]) {
        self.loginVC = [[LIULoginViewController alloc]init];;
        //UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:self.loginVC];
        self.loginVC.delegate = self;
        [self presentViewController:self.loginVC animated:YES completion:nil];
        return;
    }
    
    [self.tabBarController setSelectedIndex:0];
}

#pragma --mark TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cartGoodData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LIUGouWuCheTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.isEdit = self.isEdit;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.goodModel = self.cartGoodData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LIUShoppingDetaileViewController *detailVC = [LIUShoppingDetaileViewController new];
    LIUGouWuCheModel *gouwu = self.personModel.gouWuCheGoods[indexPath.section];
    detailVC.good = gouwu.didInGouWuCheGoods[indexPath.row];
    [self presentViewController:detailVC animated:YES completion:nil];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    LIUGouWuCheModel *gouwuModel = self.personModel.gouWuCheGoods[section];
//    return gouwuModel.storeName;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

#pragma --mark LIUGouWuCheTableViewCellDelegate
- (void)didTapSelectButtonWithIsSelect:(BOOL)isSelect AndCell:(LIUGouWuCheTableViewCell *)cell {
    
    NSIndexPath *indexPath = [self.willPayTableView indexPathForCell:cell];
    LIUGouWuCheModel *gouWu = self.personModel.gouWuCheGoods[indexPath.section];
    LIUGoodModel *shopModel = gouWu.didInGouWuCheGoods[indexPath.row];
    shopModel.isSelect = isSelect;
    [self updateTotalLabel];
}

- (void)countDidChange {
    [self updateTotalLabel];
}

- (void)didTapDeleteButtonWithCell:(LIUGouWuCheTableViewCell *)cell {
    NSIndexPath *indexPath = [self.willPayTableView indexPathForCell:cell];
    
    LIUGouWuCheModel *gouWu = self.personModel.gouWuCheGoods[indexPath.section];
    [gouWu.didInGouWuCheGoods removeObjectAtIndex:indexPath.row];
    if (gouWu.didInGouWuCheGoods.count == 0) {
        [self.personModel.gouWuCheGoods removeObject:gouWu];
    }
    [self updateTotalLabel];
    [self.willPayTableView reloadData];
}

//更新价格
- (void)updateTotalLabel {
    CGFloat total = 0.0;
    NSInteger integer = 0;
    for (LIUGouWuCheModel *gouwuModel in self.personModel.gouWuCheGoods) {
        for (LIUGoodModel *model in gouwuModel.didInGouWuCheGoods) {
            if (model.isSelect == YES) {
                //NSLog(@"%@",model.currentPrice);
                total = total + model.totalPrice;
                integer++;
            }
        }
    }
    [self creatTotalLabelWithStr:[NSString stringWithFormat:@"合计:￥%.1f",total]];
    [self.settleButton setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)integer] forState:UIControlStateNormal];
}

- (void)didLoging {
    [self viewWillAppear:YES];
}


@end
