//
//  LIUGouWuCheModel.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/26.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LIUGouWuCheModel : NSObject

@property(nonatomic,strong)NSString *storeName;
@property(nonatomic,strong)NSString *storeUrl;//后期可能用到
@property(nonatomic,strong)NSMutableArray *didInGouWuCheGoods;//加入购物车的商品  LIUGoodsModel

@end
