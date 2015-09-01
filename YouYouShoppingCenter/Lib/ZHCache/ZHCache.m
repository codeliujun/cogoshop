//
//  ZHCache.m
//  ZHTourist
//
//  Created by Michael Shan on 15/8/2.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ZHCache.h"

#define kDataPath   @"data"

@implementation ZHCache

+ (NSString *)fileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingPathComponent:kDataPath];

    BOOL dirExist = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory isDirectory:&dirExist];
    if (!dirExist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:nil];
    }

    return [documentsDirectory stringByAppendingPathComponent:fileName];
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

+ (void)writeData:(NSData *)cacheData fileName:(NSString *)fileName {
    
    NSString *filePath = [self fileName:fileName];
    BOOL fileExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (!fileExist){
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    BOOL success = [cacheData writeToFile:filePath atomically:YES];
    if (!success) {
        NSLog(@"写入失败");
    }else{
        NSLog(@"写入成功");
    }
    
}

+ (id)getCacheData:(NSString *)fileName {
    NSString *filePath = [self fileName:fileName];
    NSLog(@"%@",filePath);
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        id cacheData =  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (!cacheData) {
            NSLog(@"读取失败");
        }
        return cacheData;
    }
    return nil;
}

+ (NSData *)getCacheImageData:(NSString *)fileName {
    NSString *filePath = [self fileName:fileName];
    NSLog(@"%@",filePath);
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        id cacheData =  [NSData dataWithContentsOfFile:filePath];
        if (!cacheData) {
            NSLog(@"读取失败");
        }
        return cacheData;
    }
    return nil;
}

#pragma mark -
#pragma mark - save and load

+ (id)loadInfoWithKey:(NSString *)key {//读取
    NSData *data = [ZHCache getCacheData:key];
    if (!data) {
        return nil;
    }
    
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    id infoObject = [unArchiver decodeObjectForKey:key];
    return infoObject;
}

+ (void)saveInfo:(id)infoObject withKey:(NSString *)key {//保存
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:infoObject forKey:key];
    [archiver finishEncoding];
    
    [ZHCache saveData:data fileName:key];
}

+ (void)removeCache {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:kDataPath];
    [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
    
    return;
}

@end
