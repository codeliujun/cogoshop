//
//  LIUCreatQRCode.h
//  LIUQRCodeCreat
//
//  Created by 刘俊 on 15/6/25.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LIUCreatQRCode : NSObject

//返回二维码 string要生成的信息，size 要生成的大小
+ (UIImage *) qrImageForString:(NSString *)string imageSize:(CGFloat)size;

//返回二维码，中间有图片（avatarImage）
+ (UIImage *) twoDimensionCodeImage:(UIImage *)twoDimensionCode withAvatarImage:(UIImage *)avatarImage;

@end
