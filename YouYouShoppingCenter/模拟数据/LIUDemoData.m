//
//  LIUDemoData.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/18.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUDemoData.h"
#import "LIUCategoryModel.h"
#import "LIUGoodModel.h"

@implementation LIUDemoData

//+ (NSDictionary *)getCategoryData {
//    LIUCategoryModel *model = [LIUCategoryModel new];
//    model.url = [NSURL URLWithString:@"http://www.baidu.com"];
//    model.imageName = @"测试图片";
//    model.name = @"测试数据";
//    return @{@"模拟数据1":@[model,model,model,model],@"模拟数据2":@[model,model,model,model,model,model,model]};
//}

+ (NSArray *)getShoppingData {
    LIUGoodModel *good = [LIUGoodModel new];
    good.imageName = @"测试图片";
    good.storeName = @"DD拉屎";
    good.originalPrice = @2000;
    good.currentPrice = @1999;
    good.title = @"这是一条测试语句";
    good.dec = @"测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀";
    good.imageNames = @[@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片"];
    good.sales = @9999999;
    
    LIUGoodModel *good2 = [LIUGoodModel new];
    good2.imageName = @"测试图片";
    good2.storeName = @"DD拉屎";
    good2.originalPrice = @2000;
    good2.currentPrice = @1000;
    good2.title = @"这是一条测试语句";
    good2.dec = @"测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀";
    good2.imageNames = @[@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片"];
    good2.sales = @9999999;
    
    LIUGoodModel *good1 = [LIUGoodModel new];
    good1.imageName = @"测试图片";
    good1.storeName = @"QQ拉屎";
    good1.originalPrice = @2000;
    good1.currentPrice = @1888;
    good1.title = @"这是一条测试语句";
    good1.imageNames = @[@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片"];
    good1.dec = @"测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀";
    good1.sales = @26;
    
    LIUGoodModel *good3 = [LIUGoodModel new];
    good3.imageName = @"测试图片";
    good3.storeName = @"YY拉屎";
    good3.originalPrice = @2000;
    good3.currentPrice = @1129;
    good3.title = @"这是一条测试语句";
    good3.dec = @"测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀";
    good3.imageNames = @[@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片"];
    good3.sales = @9999999;
    
    LIUGoodModel *good4 = [LIUGoodModel new];
    good4.imageName = @"测试图片";
    good4.storeName = @"DD拉屎";
    good4.originalPrice = @2000;
    good4.currentPrice = @1999;
    good4.title = @"这是一条测试语句";
    good4.dec = @"测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀";
    good4.imageNames = @[@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片"];
    good4.sales = @9999999;

    LIUGoodModel *good5 = [LIUGoodModel new];
    good5.imageName = @"测试图片";
    good5.storeName = @"DD拉屎";
    good5.originalPrice = @2000;
    good5.currentPrice = @1999;
    good5.title = @"这是一条测试语句";
    good5.dec = @"测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀";
    good5.imageNames = @[@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片"];
    good5.sales = @9999999;

    LIUGoodModel *good6 = [LIUGoodModel new];
    good6.imageName = @"测试图片";
    good6.storeName = @"DD拉屎";
    good6.originalPrice = @2000;
    good6.currentPrice = @1999;
    good6.title = @"这是一条测试语句";
    good6.dec = @"测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀";
    good6.imageNames = @[@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片"];
    good6.sales = @9999999;

    
    
    return @[good,good1,good2,good3,good4,good5,good6];
}

+ (LIUGoodModel *)getSingleShopping {
    LIUGoodModel *good = [LIUGoodModel new];
    good.imageName = @"测试图片";
    good.originalPrice = @2000;
    good.currentPrice = @1999;
    good.storeName = @"QQ拉屎";
    good.title = @"这是一条测试语句";
    good.dec = @"测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀测试呀";
    good.sales = @9999999;
    good.imageNames = @[@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片"];
    return good;
}

//+ (LIURecevingAderess *)getAdress {
//    LIURecevingAderess *adress = [LIURecevingAderess new];
//    adress.recevingName = @"刘俊";
//    adress.recevingNumber = @"13790646251";
//    adress.recevingAdress = @"湖南省湘乡市东山学校304班";
//    adress.isDefault = YES;
//    return adress;
//}
//
//+ (NSArray *)adresses {
//    LIURecevingAderess *adress = [LIURecevingAderess new];
//    adress.recevingName = @"刘俊";
//    adress.recevingNumber = @"13790646251";
//    adress.recevingAdress = @"湖南省湘乡市东山学校304班";
//    adress.isDefault = YES;
//    
//    LIURecevingAderess *adress1 = [LIURecevingAderess new];
//    adress1.recevingName = @"刘俊1";
//    adress1.recevingNumber = @"13790646251";
//    adress1.recevingAdress = @"湖南省湘乡市东山学校304班";
//    adress1.isDefault = NO;
//
//    LIURecevingAderess *adress2 = [LIURecevingAderess new];
//    adress2.recevingName = @"刘俊2";
//    adress2.recevingNumber = @"13790646251";
//    adress2.recevingAdress = @"湖南省湘乡市东山学校304班";
//    adress2.isDefault = NO;
//
//    
//    return @[adress,adress1,adress2];
//}

@end
