//
//  LIUPaySaveController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/5.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUPaySaveController.h"

@interface LIUPaySaveController ()

@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end

@implementation LIUPaySaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付宝充值";
    self.orderLabel.text = self.orderNo;
    self.priceLabel.text = self.Price;
    // Do any additional setup after loading the view from its nib.
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
