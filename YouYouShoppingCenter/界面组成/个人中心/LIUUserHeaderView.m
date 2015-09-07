//
//  LIUUserHeaderView.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/24.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUUserHeaderView.h"
#import "LIUPersonModel.h"
#import "UIButton+LIUBadgeButton.h"
#import "Masonry.h"
#import "LIUUserInfoData.h"
#import "LIUCache.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUUserHeaderView()

//登陆之后的界面
@property (weak, nonatomic) IBOutlet UIButton *userIconButton;//1004
@property (nonatomic,strong)UIButton *changeUserNameButton;
@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UIView *didLogingView;

//没有登陆的界面
@property (weak, nonatomic) IBOutlet UIView *unLoginView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;//1005

@property(nonatomic,strong)LIUUserInfoData *userData;//网络请求的数据
//下面的bubutton
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;//1000~1003

@end

@implementation LIUUserHeaderView

- (LIUUserInfoData *)userData {
    if (!_userData) {
        _userData = [LIUUserInfoData defaultUserInfo];
    }
    return _userData;
}


- (void)updateHeaderView {
    if (self.userData.Id.length <= 0) {
        //没有登陆
        self.didLogingView.hidden = YES;
        self.unLoginView.hidden = NO;
        //配置未登陆的button
        [self updateUnLoginView];
    }else{
        //已经登陆
        self.didLogingView.hidden = NO;
        self.unLoginView.hidden = YES;
        //已经登陆就配置文件
        [self updateDidLoginView];
    }
    [self setNeedsDisplay];
}

//配置没有登陆的界面
- (void)updateUnLoginView {
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"icon_login"] forState:UIControlStateNormal];
    self.loginButton.layer.cornerRadius = self.loginButton.bounds.size.width*0.5;
    self.loginButton.layer.masksToBounds = YES;
}

//配置已经登陆的界面
- (void)updateDidLoginView {
    
    WS(ws);
    
    [self.didLogingView bringSubviewToFront:self.levelImageView];
    
    NSInteger leave = [self.userData.Level integerValue];
    switch (leave) {
        case 0:
            self.levelImageView.image = [UIImage imageNamed:@"cust_level_normal"];
            break;
        case 1:
            self.levelImageView.image = [UIImage imageNamed:@"cust_level_silver"];
            break;
        case 2:
            self.levelImageView.image = [UIImage imageNamed:@"cust_level_platinum"];
            break;
        case 3:
            self.levelImageView.image = [UIImage imageNamed:@"cust_level_gold"];
            break;
        default:
            break;
    }
    
    
    //1.将button切圆
    self.userIconButton.layer.cornerRadius = self.userIconButton.bounds.size.width*0.5;
    self.userIconButton.layer.masksToBounds = YES;
    //所有的图片都保存起来的
    
    //1.看看能否取出图片
    UIImage *iconImage = [LIUCache getCacheDataWithImagename:[NSString stringWithFormat:@"%@",self.userData.mobile]];
    
    if (iconImage) {
        
    }else {
        NSString *imageStr = [self.userData.ThumbUrl stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http:/%@",imageStr]];
        NSData *data = [NSData dataWithContentsOfURL:imageUrl];
        
        [LIUCache saveImageData:data AndImageName:self.userData.mobile];
        iconImage = [UIImage imageWithData:data];
    }
    //[self.userIconButton setBackgroundImage:iconImage forState:UIControlStateNormal];
    
    
    //2.用户名
    UILabel *userNameLabel = [[UILabel alloc]init];
    userNameLabel.text = self.userData.lastname;
    userNameLabel.font = [UIFont systemFontOfSize:15];
    CGRect frame = [userNameLabel textRectForBounds:CGRectMake(0, 0, 999, 999) limitedToNumberOfLines:1];
    [self.didLogingView addSubview:userNameLabel];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.levelImageView.mas_right).with.offset(8);
        make.bottom.equalTo(ws.balanceLabel.mas_top).with.offset(-5);
        make.width.equalTo(@(frame.size.width));
        make.height.equalTo(@(frame.size.height));
    }];
    
    //3.状态
    UILabel *stateLabel = [UILabel new];
    stateLabel.text = @"正常";
    stateLabel.textColor = [UIColor redColor];
    stateLabel.font = [UIFont systemFontOfSize:15];
    frame = [stateLabel textRectForBounds:CGRectMake(0, 0, 999, 999) limitedToNumberOfLines:1];
    [self.didLogingView addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userNameLabel);
        make.left.equalTo(userNameLabel.mas_right).with.offset(5);
        make.width.equalTo(@(frame.size.width));
        make.height.equalTo(@(frame.size.height));
    }];
    
#warning ToDo...
    //修改名字的button
    self.changeUserNameButton = [[UIButton alloc]init];
    [self.didLogingView addSubview:self.changeUserNameButton];
    self.changeUserNameButton.tag = 1006;
    [self.changeUserNameButton addTarget:self action:@selector(changeUserName:) forControlEvents:UIControlEventTouchUpInside];
    [self.changeUserNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameLabel.mas_leading).with.offset(0);
        make.top.equalTo(userNameLabel.mas_top).with.offset(0);
        make.right.equalTo(ws.balanceLabel.mas_right).with.offset(0);
        make.bottom.equalTo(ws.balanceLabel.mas_bottom).with.offset(0);
    }];
    
    //4.余额
    self.balanceLabel.text = [NSString stringWithFormat:@"%@",self.userData.Balance];
    
    //看看哪些有徽章
    
    for (UIButton *button in self.allButtons) {
        switch (button.tag) {
            case 1000://待付款
                //[button setBadgeValue:self.person.willPayOrders.count TextColor:nil BackGroundColor:nil];
                break;
                
            case 1001://待发货 没有了
                //[button setBadgeValue:self.person.willDispathOrders.count TextColor:nil BackGroundColor:nil];
                break;
                
            case 1002://待收货  没有了
                //[button setBadgeValue:self.person.willTakeDeliveryOrders.count TextColor:nil BackGroundColor:nil];
                break;
                
            case 1003://待评价
                //[button setBadgeValue:self.person.willJudgeOfOrders.count TextColor:nil BackGroundColor:nil];
                break;
        }
    }
    
}
- (IBAction)touch:(UIButton *)sender {
    [self.delegate headerViewDidTapButton:sender];
}

- (void)changeUserName:(UIButton *)sender {
    [self touch:sender];
}


@end
