//
//  LIUPersonModel.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/21.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUPersonModel.h"
#import "LIUDemoData.h"

@implementation LIUPersonModel

+ (LIUPersonModel *)defaultUser {
    static LIUPersonModel *_default = nil;
    if (!_default) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _default = [[LIUPersonModel alloc]init];
        });
    }
    return _default;
}

- (NSMutableArray *)allOrders {
    if (!_allOrders) {
        _allOrders = [NSMutableArray new];
    }
    
    [_allOrders addObjectsFromArray:self.willDispathOrders];//待发货
    [_allOrders addObjectsFromArray:self.willTakeDeliveryOrders];//待收货
    [_allOrders addObjectsFromArray:self.willJudgeOfOrders];//待评价
    [_allOrders addObjectsFromArray:self.historyOrders];//已经完成
    
    return _allOrders;
}

- (instancetype)init {
    if (self = [super init]) {
        self.isLoad = NO;
        self.isVIP = YES;
        self.discount = @0.8;
        self.userName = @"dashen";
        self.passWord = @"123";
        self.willPayOrders = [NSMutableArray new];
        self.willJudgeOfOrders = [NSMutableArray new];
        self.willTakeDeliveryOrders = [NSMutableArray new];
        self.gouWuCheGoods = [NSMutableArray new];
        self.willDispathOrders = [NSMutableArray new];
        self.balanceCash = @10000.00;
        self.state = @"正常";
        self.icon = @"default_head_pic";
        self.recevingAddress = [[LIUDemoData adresses] mutableCopy];
    }
    return self;
}


@end
