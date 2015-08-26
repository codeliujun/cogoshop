//
//  LIUOrderModel.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/26.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIUOrderdetails.h"

@interface LIUOrderModel : NSObject


@property (nonatomic, copy) NSString *Code;

@property (nonatomic, copy) NSString *ShopId;

@property (nonatomic, strong) NSArray *OrderDetails;

@property (nonatomic, copy) NSString *UserAccount;

@property (nonatomic, copy) NSString *OrderStatusDes;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *PayTypeDes;

@property (nonatomic, copy) NSString *AddressId;

@property (nonatomic, copy) NSString *CompeletPayTime;

@property (nonatomic, assign) CGFloat TotalAmount;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *TranslateMode;

@property (nonatomic, copy) NSString *Remark;

@property (nonatomic, assign) NSInteger Expenses;

@property (nonatomic, copy) NSString *DeliveryTime;

@property (nonatomic, copy) NSString *UserId;

@property (nonatomic, copy) NSString *LatestTime;

@property (nonatomic, copy) NSString *PayType;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, copy) NSString *EarliestTime;

@property (nonatomic, copy) NSString *Datetime;

@end
