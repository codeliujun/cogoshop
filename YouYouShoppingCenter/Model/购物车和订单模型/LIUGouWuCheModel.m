//
//  LIUGouWuCheModel.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/26.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUGouWuCheModel.h"

@implementation LIUGouWuCheModel

- (NSMutableArray *)didInGouWuCheGoods {
    if (!_didInGouWuCheGoods) {
        _didInGouWuCheGoods = [NSMutableArray new];
    }
    return _didInGouWuCheGoods;
}

@end
