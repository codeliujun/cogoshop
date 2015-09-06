//
//  LIUChangePassWordController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/6.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#define kTextFieldIsNill(hah) [hah isEqual:[NSNull null]] || hah == nil || [hah isEqualToString:@""]

#import "LIUChangePassWordController.h"
#import "SVProgressHUD.h"
#import "UIViewController+GetHTTPRequest.h"

@interface LIUChangePassWordController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldTextFoeld;

@property (weak, nonatomic) IBOutlet UITextField *pass1;
@property (weak, nonatomic) IBOutlet UITextField *pass2;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation LIUChangePassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.confirmButton.layer.cornerRadius = 3.0f;
    self.confirmButton.layer.masksToBounds = YES;
    self.oldTextFoeld.returnKeyType = UIReturnKeyNext;
    self.oldTextFoeld.delegate = self;
    self.pass1.returnKeyType = UIReturnKeyNext;
    self.pass1.delegate = self;
    self.pass2.returnKeyType = UIReturnKeyDone;
    self.pass2.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.oldTextFoeld) {
        [self.pass1 becomeFirstResponder];
    }
    if (textField == self.pass1) {
        [self.pass2 becomeFirstResponder];
    }
    
    if (textField == self.pass2) {
        [self.pass2 resignFirstResponder];
        [self comfirmButton:nil];
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)comfirmButton:(UIButton *)sender {
    
    if (kTextFieldIsNill(self.oldTextFoeld.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入原密码" duration:1.5f];
        return;
    }
    
    if (kTextFieldIsNill(self.pass1.text)) {
        [SVProgressHUD showErrorWithStatus:@"请输入新密码" duration:1.5f];
        return;
    }
    
    if (kTextFieldIsNill(self.pass2.text)) {
        [SVProgressHUD showErrorWithStatus:@"请再次输入密码" duration:1.5f];
        return;
    }
    
    if (![self.pass1.text isEqualToString:self.pass2.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入的密码不一致" duration:1.5f];
        return;
    }
    WS(ws);
    [self requestWithUrl:kChangePassWord Parameters:@{@"userid":[self getUserId],
                                                      @"oldpwd":self.oldTextFoeld.text,
                                                      @"newpwd":self.pass1.text,
    } Success:^(NSDictionary *result) {
        [ws.navigationController popViewControllerAnimated:YES];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
}

@end
