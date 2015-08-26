//
//  LIUConfirmBookingViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/24.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

typedef enum {
    YIN_LIAN,
    ZHI_FU_BAO
} Paystyle;

#import "LIUConfirmViewController.h"
#import "LIUPersonModel.h"

@interface LIUConfirmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *choosePayButtons;

@end

@implementation LIUConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认订单";
    
    //添加返回按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"取消支付" style:UIBarButtonItemStylePlain target:self action:@selector(goBackDidTap:)];
    self.navigationItem.leftBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.orderModel.TotalAmount];
}

- (IBAction)payButtonDidTap:(UIButton *)sender {
    NSLog(@"支付完成之后，就要将模型商品转移到DidPay");
    //模拟数据在这里已经支付完成
    LIUPersonModel *person = [LIUPersonModel defaultUser];
    [person.willPayOrders removeObject:self.orderModel];//删除即将付款
    [person.willDispathOrders addObject:self.orderModel];//添加到即将发货
}

//返回按钮
- (void)goBackDidTap:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//选择支付方式
- (IBAction)payButton:(UIButton *)sender {
    
    NSInteger index = [self.choosePayButtons indexOfObject:sender];
    for (UIButton *button in self.choosePayButtons) {
        button.selected = NO;
    }
    
    sender.selected = YES;
    
    switch (index) {
        case YIN_LIAN:
            NSLog(@"选择银联支付");
            break;
            
        case ZHI_FU_BAO:
            NSLog(@"选择支付宝支付");
            break;
    }
    
}



@end
