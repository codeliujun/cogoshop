//
//  LIUCache.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/7/24.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUCache.h"

@implementation LIUCache

+ (NSString *)fileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

+ (void)saveImageData:(NSData *)data AndImageName:(NSString *)imagename {
    NSString *path = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"CacheImages"] stringByAppendingPathComponent:[NSString  stringWithFormat:@"%@.jpg",imagename]];
    NSLog(@"path===%@",path);
    
    if ([data writeToFile:path atomically:YES]) {
        NSLog(@"写入成功");
    }else {
        NSLog(@"写入失败");
    }
    
}
+ (UIImage *)getCacheDataWithImagename:(NSString *)imageName {
    NSString *path = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"CacheImages"] stringByAppendingPathComponent:[NSString  stringWithFormat:@"%@.jpg",imageName]];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [[UIImage alloc]initWithData:data];
}

+ (void)saveData:(id)cacheData fileName:(NSString *)fileName {
    NSString *filePath = [self fileName:fileName];
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (!fileExist){
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    BOOL success = [NSKeyedArchiver archiveRootObject:cacheData toFile:filePath];
    if (!success) {
        NSLog(@"写入失败");
    }else{
        NSLog(@"写入成功");
    }
}

+ (id)getCacheData:(NSString *)fileName {
    NSString *filePath = [self fileName:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        id cacheData =  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (!cacheData) {
            NSLog(@"读取失败");
        }
        return cacheData;
    }
    return nil;
}

#pragma mark -
#pragma mark - save and load

+ (id)loadInfoWithKey:(NSString *)key {
    NSData *data = [LIUCache getCacheData:key];
    if (!data) {
        return nil;
    }
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id infoObject = [unArchiver decodeObjectForKey:key];
    return infoObject;
}

+ (void)saveInfo:(id)infoObject withKey:(NSString *)key {
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:infoObject forKey:key];
    [archiver finishEncoding];
    
    [LIUCache saveData:data fileName:key];
}

+ (void)removeCache {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:kOftenAddressKey];
    [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
    
    return;
}


@end
