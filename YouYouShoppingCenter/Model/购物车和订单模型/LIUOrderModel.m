//
//  LIUOrderModel.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/26.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUOrderModel.h"

@implementation LIUOrderModel


+ (NSDictionary *)objectClassInArray{
    return @{@"OrderDetails":[LIUOrderdetails class]};
}

@end
