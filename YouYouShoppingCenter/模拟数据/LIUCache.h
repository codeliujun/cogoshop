//
//  LIUCache.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/7/24.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define kOftenAddressKey    @"ofent_address"

@interface LIUCache : NSObject

//持久化数据对象 ,数据对象要实现NSCoding 协议

+ (void)saveImageData:(NSData *)data AndImageName:(NSString *)imagename;
+ (UIImage *)getCacheDataWithImagename:(NSString *)imageName;

+ (void)saveData:(id)cacheData fileName:(NSString *)fileName;
+ (id)getCacheData:(NSString *)fileName;

/**
 *  BCFlightInfo, BCUserInfo 存储和加载
 */
+ (id)loadInfoWithKey:(NSString *)key;
+ (void)saveInfo:(id)infoObject withKey:(NSString *)key;

+ (void)removeCache;

@end
