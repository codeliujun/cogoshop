//
//  LIULoginViewController.m
//  Gongyinglian
//
//  Created by 刘俊 on 15/6/12.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#define LOGIN_COLOR [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0]

#import "LIULoginViewController.h"
#import "LIURegistViewController.h"
#import "LIULoginRequestParameters.h"
#import "LIULoginRespondParameters.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUPersonModel.h"
#import "LIUCustomSwitch.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIULoginViewController ()<LIUCustomSwitchDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *useNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *rememberButton;
@property (weak, nonatomic) IBOutlet UIView *loginView;

@property(nonatomic,strong)LIUCustomSwitch *customSwitch;

//模拟人的登陆
@property(nonatomic,strong)LIUPersonModel *userInfo;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LIULoginViewController

#pragma --mark 单利
+ (LIULoginViewController *)shareLoginViewController {
    static LIULoginViewController *_shareVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareVC = [[LIULoginViewController alloc]initWithNibName:@"LIULoginViewController" bundle:nil];
    });
    return _shareVC;
}

- (LIUPersonModel *)userInfo {
    if (!_userInfo) {
        _userInfo = [LIUPersonModel defaultUser];
    }
    return _userInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.customSwitch = [[LIUCustomSwitch alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 220, 50, 25)];
    [self.view addSubview:self.customSwitch];
    self.customSwitch.delegate = self;
    
    self.loginButton.layer.cornerRadius = 5.0f;
    self.loginButton.layer.masksToBounds = YES;
    
    //为自己的navigation添加button
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    //根据是否记住密码来判断是否自动填入数据
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"remember"] boolValue] == YES) {
        self.rememberButton.selected = YES;
        //如果取出来的数据是有的，那么自动填入
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]) {
            self.useNameTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"]) {
            self.passWordTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
        }
    }
    
    
    //右边是注册按钮，在此功能中可以不要
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(regist:)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark 布局代码
- (void)viewWillLayoutSubviews {
    //显示圆角的布局
    self.loginView.layer.borderWidth = 1.0;
    self.loginView.layer.borderColor = LOGIN_COLOR.CGColor;
    self.loginView.layer.cornerRadius = 5.0;
    self.loginView.layer.masksToBounds = YES;
}

#pragma --mark 是否记住密码
- (IBAction)isRememberPassWord:(UIButton *)sender {
    self.rememberButton.selected = !self.rememberButton.selected;
}

#pragma --mark textField
- (IBAction)enterPassword:(UITextField *)sender {
    [self.passWordTextField becomeFirstResponder];
}
- (IBAction)enterLogin:(UITextField *)sender {
    [self login:nil];
}





#pragma --mark 忘记密码
- (IBAction)lostPassword:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passWord"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"remember"];
}

#pragma --mark 登陆
- (IBAction)login:(id)sender {
    
    WS(ws);
    
    //1.判断密码是否为空
    if ([self.passWordTextField.text isEqualToString:@""]) {
        //弹出警告框，要求输入密码
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"输入的密码不能为空，请重新" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    //2.是否保存密码,如果是保存密码的话，那么就需要用NSUserDefaults来将用户输入的账号密码保存起来
    if (self.rememberButton.isSelected) {
        //此时就应该要将密码保存
        [[NSUserDefaults standardUserDefaults] setObject:self.useNameTextField.text forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setObject:self.passWordTextField.text forKey:@"passWord"];
        //记住密码按钮的状态
        [[NSUserDefaults standardUserDefaults] setObject:@(self.rememberButton.isSelected) forKey:@"remember"];
        [[NSUserDefaults standardUserDefaults] synchronize];//永久化保存,认为只要用一次就够了，因为单例嘛
    }
    
    //登陆发送请求
    //1.创建参数对象
    LIULoginRequestParameters *request = [[LIULoginRequestParameters alloc]init];
    request.username = self.useNameTextField.text;
    request.pwd = self.passWordTextField.text;
    request.logintype = @1;
    //2.发送请求
    [self requestWithUrl:kLoginUrl Parameters:[[request keyValues] copy] Success:^(NSDictionary *result) {
        LIULoginRespondParameters *parameters = [LIULoginRespondParameters objectWithKeyValues:result];
        LIUUserInfoData *data = parameters.Data;
        NSLog(@"%@",data);
        [ws.delegate didLoging];
        //跳转回去
        [self dismissViewControllerAnimated:YES completion:nil];
    } Failue:^(NSDictionary *failueInfo) {
    }];
    
}

#pragma --mark 注册
- (void)regist:(UIBarButtonItem *)sender{
    
    //跳转到注册界面
    LIURegistViewController *regist = [[LIURegistViewController alloc]initWithNibName:@"LIURegistViewController" bundle:nil];
    [self.navigationController pushViewController:regist animated:YES];
    
}


#pragma --mark 界面消失
- (void)dismiss:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma --mark 代理方法,在这里面判断textfield是否显示密码
- (void)switchDidTapWithStatue:(BOOL)statue {
    NSLog(@"%d",statue);
    if (statue == YES) {
        self.passWordTextField.secureTextEntry = NO;
    }else {
        self.passWordTextField.secureTextEntry = YES;
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)strin个{
    
    if (textField == self.useNameTextField) {
        if (textField.text.length >= 11) {
            return NO;
        }
    }
    
    if (textField == self.passWordTextField) {
        if (textField.text.length >= 6) {
            return NO;
        }
    }
    return YES;
}

@end
