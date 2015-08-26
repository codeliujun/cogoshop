//
//  LIUDemoData.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/18.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIUGoodModel.h"
#import "LIURecevingAderess.h"

@interface LIUDemoData : NSObject

+ (NSDictionary *)getCategoryData;
+ (NSArray *)getShoppingData;
+ (LIUGoodModel *)getSingleShopping;
+ (LIURecevingAderess *)getAdress;
+ (NSArray *)adresses;

@end
