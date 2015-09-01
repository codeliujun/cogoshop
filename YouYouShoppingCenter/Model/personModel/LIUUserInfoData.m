//
//  LIUUserInfoData.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/7/2.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUUserInfoData.h"

static LIUUserInfoData *_userData = nil;

@implementation LIUUserInfoData

+ (LIUUserInfoData *)defaultUserInfo {
    if (!_userData) {
        _userData = [[LIUUserInfoData alloc]init];
    }
    return _userData;
}

- (instancetype)init {
    if (self = [super init]) {
        _userData = self;
    }
    return self;
}

+ (void)logOut {
    _userData = nil;
}

@end
