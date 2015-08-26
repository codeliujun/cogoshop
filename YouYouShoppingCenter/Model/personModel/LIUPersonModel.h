//
//  LIUPersonModel.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/21.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LIUPersonModel : NSObject

+ (LIUPersonModel *)defaultUser;

@property(nonatomic,assign)BOOL isLoad;//默认是no
@property(nonatomic,assign)BOOL isVIP;
@property(nonatomic,strong)NSString *icon;
@property(nonatomic,strong)NSNumber *balanceCash;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSNumber *discount;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *passWord;

@property(nonatomic,strong)NSMutableArray *recevingAddress;

@property(nonatomic,strong)NSMutableArray *gouWuCheGoods;

@property(nonatomic,strong)NSMutableArray *willJudgeOfOrders;//待评价
@property(nonatomic,strong)NSMutableArray *willDispathOrders;//待发货
@property(nonatomic,strong)NSMutableArray *willTakeDeliveryOrders;//待收货
@property(nonatomic,strong)NSMutableArray *willPayOrders;//待付款
@property(nonatomic,strong)NSMutableArray *historyOrders;//已经完成的订单

@property(nonatomic,strong)NSMutableArray *allOrders;//全部订单

@end
