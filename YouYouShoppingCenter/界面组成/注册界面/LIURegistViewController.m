//
//  LIURegistViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/25.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIURegistViewController.h"
#import "SVProgressHUD.h"
#import "UIViewController+GetHTTPRequest.h"

@interface LIURegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *shoujiHaoMa;
@property (weak, nonatomic) IBOutlet UITextField *diyiciMima;
@property (weak, nonatomic) IBOutlet UITextField *dierciMima;
@property (weak, nonatomic) IBOutlet UITextField *yanZhengMa;
@property (weak, nonatomic) IBOutlet UIButton *getYanZhengMaButton;

@property(nonatomic,strong)UILabel *caculateTimeLabel;//下一次发送验证码的时间

@end

@implementation LIURegistViewController

- (UILabel *)caculateTimeLabel {
    if (!_caculateTimeLabel) {
        _caculateTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.getYanZhengMaButton.frame.size.width, self.getYanZhengMaButton.frame.size.height)];
        _caculateTimeLabel.backgroundColor = [UIColor lightGrayColor];
        _caculateTimeLabel.textColor = [UIColor grayColor];
        _caculateTimeLabel.textAlignment = NSTextAlignmentCenter;
        _caculateTimeLabel.font = [UIFont systemFontOfSize:13];
        [self.getYanZhengMaButton addSubview:_caculateTimeLabel];
    }
    return _caculateTimeLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机快速注册";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)zhuCe:(UIButton *)sender {
    //1.判断2此输入的密码是否一致
    if (![self.diyiciMima.text isEqualToString:self.dierciMima.text]) {
        [SVProgressHUD showErrorWithStatus:@"密码输入不一致,请重新输入" duration:1];
        return;
    }
    
    //发送请求http://o2oapi.cnnst.com/api/User?mobile={mobile}&pwd={pwd}&authcode={authcode}
    NSDictionary *dic = @{@"mobile":self.shoujiHaoMa.text,@"pwd":self.diyiciMima.text,@"authcode":self.yanZhengMa.text,@"shopId":@"1"};
    
    [self requestWithUrl:kRegisterUrl Parameters:dic Success:^(NSDictionary *result) {
        [SVProgressHUD showSuccessWithStatus:@"恭喜您注册成功" duration:2.0];
    } Failue:^(NSDictionary *failueInfo) {
        [SVProgressHUD showErrorWithStatus:@"注册失败，请检查您的网络" duration:2.0];
    }];
    
}

- (IBAction)getYanZhengMa:(UIButton *)sender {
    if (self.shoujiHaoMa.text.length < 11) {
        [SVProgressHUD showErrorWithStatus:@"手机号码格式不对" duration:2];
        return;
    }
    //发送验证码
    // http://o2oapi.cnnst.com/api/User?mobile={mobile}&type={type}
    NSDictionary *dic = @{@"mobile":self.shoujiHaoMa.text,@"type":@1};
    
    [self requestWithUrl:kAuthcodeUrl Parameters:dic Success:^(NSDictionary *result) {
        [SVProgressHUD showSuccessWithStatus:@"验证码发送成功" duration:1];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(yanZhengMaFaSong:) userInfo:nil repeats:YES];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
}

- (void)yanZhengMaFaSong:(NSTimer *)timer {
    static NSInteger time = 30;
    if (time > 0) {
        //[self.getYanZhengMaButton setTitle:[NSString stringWithFormat:@"%ldS",(long)time] forState:UIControlStateNormal];
        self.caculateTimeLabel.text = [NSString stringWithFormat:@"%ldS",(long)time];
        time--;
    }else{
        //[self.getYanZhengMaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//        self.getYanZhengMaButton.enabled = YES;
//        self.getYanZhengMaButton.backgroundColor = [UIColor redColor];
        [self.caculateTimeLabel removeFromSuperview];
        self.caculateTimeLabel = nil;
        time = 30;
        [timer invalidate];
    }
}

@end
