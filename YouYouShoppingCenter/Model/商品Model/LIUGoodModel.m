//
//  LIUShoppingModel.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/19.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUGoodModel.h"

@implementation LIUGoodModel

- (float)totalPrice {
    return [self.currentPrice floatValue]*self.count*1.0;
}

@end
