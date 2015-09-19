//
//  LIUSettingController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/5.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUSettingController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "UIColor+HexColor.h"
#import "LIUSuggestController.h"

@interface LIUSettingController ()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *editionLabel;
- (IBAction)edition:(UIButton *)sender;
@property (nonatomic,strong)NSDictionary *versionData;
- (IBAction)sendSuggest:(UIButton *)sender;
@end

@implementation LIUSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.backView.layer.cornerRadius = 5.0f;
    self.backView.layer.borderWidth =1.0f;
    self.backView.layer.borderColor = [UIColor hexStringToColor:@"909090"].CGColor;
    self.backView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)edition:(UIButton *)sender {
    WS(ws);
    [self requestWithUrl:kGetVersion Parameters:@{@"type":@2} Success:^(NSDictionary *result) {
        ws.versionData = result[@"Data"];
        [ws version];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
    
}

- (void)version {
    WS(ws);
    if ([self.versionData[@"Version"] isEqualToString:self.editionLabel.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"版本jianc" message:@"当前版本为最新版本" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alert show];
    }
    else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"版本检测" message:@"检测到新版本，立即下载" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *a1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSURL *url = [NSURL URLWithString:ws.versionData[@"UpdateUrl"]];
            [[UIApplication sharedApplication]openURL:url];
        }];
        [alert addAction:a1];
        [alert addAction:a2];
        [ws presentViewController:alert animated:YES completion:nil];
    }
    
}

- (IBAction)sendSuggest:(UIButton *)sender {
    
    LIUSuggestController *suggest = [[LIUSuggestController alloc]init];
    [self.navigationController pushViewController:suggest animated:YES];
    
    
}
@end
