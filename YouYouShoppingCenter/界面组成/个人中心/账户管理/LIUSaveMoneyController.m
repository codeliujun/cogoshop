//
//  LIUSaveMoneyController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/5.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUSaveMoneyController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUPaySaveController.h"
#import "LIUUserInfoData.h"

@interface LIUSaveMoneyController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@property (nonatomic,strong)LIUUserInfoData *userData;

@end

@implementation LIUSaveMoneyController

- (LIUUserInfoData *)userData {
    if (!_userData) {
        _userData = [LIUUserInfoData defaultUserInfo];
    }
    return _userData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户充值";
    
    self.phoneLabel.text = self.userData.mobile;
    self.priceTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.priceTextField.returnKeyType = UIReturnKeyNext;
    self.priceTextField.delegate = self;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 35)];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)nextStep:(UIButton*)sender {
    WS(ws);
    [self requestWithUrl:kCreatSaveCode Parameters:@{@"userid":[self getUserId],@"money":self.priceTextField.text} Success:^(NSDictionary *result) {
        NSLog(@"%@",result);
        LIUPaySaveController *controller = [[LIUPaySaveController alloc]init];
        controller.Price = ws.priceTextField.text;
        controller.orderNo = result[@"Message"];
        [ws.navigationController pushViewController:controller animated:YES];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    [self nextStep:nil];
    return YES;
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
