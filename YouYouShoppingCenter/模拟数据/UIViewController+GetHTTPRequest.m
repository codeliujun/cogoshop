//
//  UIViewController+GetHTTPRequest.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/7/17.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "UIViewController+GetHTTPRequest.h"
#import "LIULoginViewController.h"
#import "LIUUserInfoData.h"
#import "SVProgressHUD.h"

@implementation UIViewController (GetHTTPRequest)

- (void)requestWithUrl:(NSString *)url Parameters:(NSDictionary *)parameters Success:(void (^) (NSDictionary *result))success Failue:(void (^) (NSDictionary *failueInfo))failue {
    /*
     AFNetworkReachabilityStatusUnknown          = -1,
     AFNetworkReachabilityStatusNotReachable     = 0,
     AFNetworkReachabilityStatusReachableViaWWAN = 1,
     AFNetworkReachabilityStatusReachableViaWiFi = 2,
     */
    
    [SVProgressHUD show];
    
    //1.判断网络是否连接
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (status == AFNetworkReachabilityStatusNotReachable) {
        failue(@{@"failue":@"当前没有网络连接"});
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:2];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismissWithError:@"网络连接错误"];
            });
        });
        
        return;
    }
    
    //2.当有网络连接的时候，发送网络请求，好像都是get请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"ErrorCode"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            if (success) {
                success(responseObject);
                NSLog(@"JSON: =====%@", responseObject);
            }
        }else {
            [SVProgressHUD dismissWithError:responseObject[@"Message"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failue) {
            failue(@{@"failue":error});
        }
        [SVProgressHUD dismissWithError:@"网络连接错误"];
        NSLog(@"Error: %@", error);
    }];
}


- (BOOL)userIsLogin {
    
    LIUUserInfoData *user = [LIUUserInfoData defaultUserInfo];
    if (user.Id.length == 0 || user.Id == nil) {
        
        return NO;
        
    }else {
        return YES;
    }
}

- (void)showLoginView {
    
    LIULoginViewController *loginVC = [[LIULoginViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [self presentViewController:navi animated:YES completion:nil];
    
}

- (NSString *)getUserId {
    
    LIUUserInfoData *data = [LIUUserInfoData defaultUserInfo];
    
    NSString *userId = data.Id;
    if (!userId) {
        userId = @"";
    }
    
    return userId;
}

- (void)upDateUserName:(NSString *)name {
    
    LIUUserInfoData *data = [LIUUserInfoData defaultUserInfo];
    data.lastname = name;
    
}

@end
