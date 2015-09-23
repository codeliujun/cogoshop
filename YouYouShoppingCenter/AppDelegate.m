//
//  AppDelegate.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/17.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIULoginRespondParameters.h"
#import "MJExtension.h"
#import "LIUUserInfoData.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    //[UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:105/256.0 green:34/256.0 blue:56/256.0 alpha:1];
    [[UITabBar appearance]setSelectedImageTintColor:[UIColor redColor]];
    //检测网络
    [self checkNetWork];
    [self autoLogin];
    return YES;
}

- (void)autoLogin {
    
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"passWord"];
    
    UIViewController *vc = [UIViewController new];
    
    if (userName && passWord) {
        [SVProgressHUD show];
        [vc requestWithUrl:kLoginUrl Parameters:@{@"username":userName,@"pwd":passWord,@"logintype":@"1"} Success:^(NSDictionary *result) {
            LIULoginRespondParameters *parameters = [LIULoginRespondParameters objectWithKeyValues:result];
            LIUUserInfoData *data = parameters.Data;
            NSLog(@"%@",data);
            [SVProgressHUD dismiss];
        } Failue:^(NSDictionary *failueInfo) {
            [SVProgressHUD dismiss];
        }];
    }
    
    
    
}

- (void)checkNetWork {
    
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    
     // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];//开始监测
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus statue) {
        switch (statue) {
            case AFNetworkReachabilityStatusUnknown:
                [SVProgressHUD showErrorWithStatus:@"未知连接" duration:2.0];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [SVProgressHUD showErrorWithStatus:@"无网络连接" duration:2.0];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [SVProgressHUD showSuccessWithStatus:@"手机数据连接" duration:2.0];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [SVProgressHUD showSuccessWithStatus:@"WiFi连接" duration:2.0];
                break;
        }
    }];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        if (resultDic) {
        [SVProgressHUD showErrorWithStatus:resultDic[@"memo"]];
        }
    }];
    
    return YES;
}

@end
