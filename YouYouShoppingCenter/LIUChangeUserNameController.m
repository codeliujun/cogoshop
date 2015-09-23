//
//  LIUChangeUserNameController.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/9/19.
//  Copyright © 2015年 刘俊. All rights reserved.
//

#import "LIUChangeUserNameController.h"
#import "SVProgressHUD.h"
#import "UIViewController+GetHTTPRequest.h"

@interface LIUChangeUserNameController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

@end

@implementation LIUChangeUserNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)creatUI {
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    self.changeButton.layer.cornerRadius = 5.0;
    self.changeButton.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeUserName:(UIButton *)sender {
    
    NSString *str = self.textField.text;
    if ([str isEqual:[NSNull null]] || str == nil || [str isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"名字格式不对" duration:1.5];
        return;
    }
    [self requestWithUrl:kUpdateUserName Parameters:@{@"userid":[self getUserId],@"name":str} Success:^(NSDictionary *result) {
        [self upDateUserName:str];
        [self.navigationController popViewControllerAnimated:YES];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    [self changeUserName:nil];
    return YES;
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
