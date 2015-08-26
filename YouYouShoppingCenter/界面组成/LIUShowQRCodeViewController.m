//
//  LIUShowQRCodeViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/25.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUShowQRCodeViewController.h"
#import "LIUCreatQRCode.h"
#import "Masonry.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUShowQRCodeViewController ()

@property(nonatomic,strong)UIImageView *userInfo;

@end

@implementation LIUShowQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.userInfo = [UIImageView new];
    [self.view addSubview:self.userInfo];
    
    WS(ws);
    
    [self.userInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(ws.view);
        make.width.equalTo(@(ws.view.bounds.size.width*3.0/5));
        make.height.equalTo(@(ws.view.bounds.size.width*3.0/5));
    }];
    
    UIImage *image = [LIUCreatQRCode qrImageForString:@"用户的信息" imageSize:self.view.bounds.size.width*3.0/5];
    self.userInfo.image = [LIUCreatQRCode twoDimensionCodeImage:image withAvatarImage:[UIImage imageNamed:[LIUPersonModel defaultUser].icon]];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
