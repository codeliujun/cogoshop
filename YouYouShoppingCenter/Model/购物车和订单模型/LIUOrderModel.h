//
//  LIUOrderModel.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/26.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LIUOrderModel : NSObject

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, assign) CGFloat Total;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *Code;

@property (nonatomic, copy) NSString *OrderStatusDes;

@property (nonatomic, copy) NSString *ProductCount;

@property (nonatomic, copy) NSString *ProductNumber;

@property (nonatomic, copy) NSString *ProductName;

@property (nonatomic, copy) NSString *ProductThumbUrl;

@property (nonatomic, copy) NSString *Datetime;

@property (nonatomic, assign) CGFloat ProductPrice;


@end
