//
//  ZHCache.h
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHCache : NSObject

//持久化数据对象 ,数据对象要实现NSCoding 协议

+ (void)saveData:(id)cacheData fileName:(NSString *)fileName;
+ (id)getCacheData:(NSString *)fileName;

/**
 *  Object 的存储和加载
 */
+ (id)loadInfoWithKey:(NSString *)key;
+ (void)saveInfo:(id)infoObject withKey:(NSString *)key;
+ (void)writeData:(NSData *)cacheData fileName:(NSString *)fileName;
+ (NSData *)getCacheImageData:(NSString *)fileName;

+ (void)removeCache;

@end
