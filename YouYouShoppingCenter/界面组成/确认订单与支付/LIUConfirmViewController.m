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
#import "UIViewController+GetHTTPRequest.h"
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
    [self caqulateTotalPrice];
    //self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.orderModel.TotalAmount];
}


- (void)caqulateTotalPrice {
    
    CGFloat total = 0.0f;
//    NSMutableArray  *orderNum = @[].mutableCopy;
//    for (LIUOrderModel *model in self.self.orederModels) {
//        
//        total = total+model.Total;
//        [orderNum addObject:model.Code];
//    }
    
//    NSString *str = [orderNum componentsJoinedByString:@","];
    self.orderLabel.text = self.orderModel.Code;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",self.orderModel.Total];
    
}

- (IBAction)payButtonDidTap:(UIButton *)sender {
    LIUOrderModel *orderModel = self.orderModel;
    [self requestWithUrl:kPayOrder Parameters:@{@"userid":[self getUserId],
                                                @"orderid":orderModel.Id}
        Success:^(NSDictionary *result) {
            NSLog(@"%@",result);
            [self.navigationController popToRootViewControllerAnimated:YES];
    } Failue:^(NSDictionary *failueInfo) {
            [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
}

//返回按钮
- (void)goBackDidTap:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
