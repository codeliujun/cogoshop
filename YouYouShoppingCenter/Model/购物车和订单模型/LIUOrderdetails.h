//
//  LIUOrderdetails.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/22.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIUProductjson.h"

@interface LIUOrderdetails : NSObject

@property (nonatomic, copy) NSString *ProductThumbUrl;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *ProductId;

@property (nonatomic, copy) NSString *ProductName;

@property (nonatomic, assign) NSInteger Number;

@property (nonatomic, copy) NSString *OtherFeesRmk;

@property (nonatomic, assign) CGFloat TotalMoney;

@property (nonatomic, strong) LIUProductjson *ProductJson;

@property (nonatomic, copy) NSString *OrderId;

@property (nonatomic, assign) NSInteger ProductPrice;

@property (nonatomic, assign) CGFloat Price;

@property (nonatomic, assign) NSInteger OtherFees;

@property (nonatomic, assign) NSInteger ProductNumber;

@property (nonatomic, copy) NSString *ProductThumbUrls;

@end
