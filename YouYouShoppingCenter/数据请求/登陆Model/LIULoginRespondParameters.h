//
//  LIULoginRespondParameters.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/7/2.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIUUserInfoData.h"
/*
success: true,
desc: "接口调用成功",
code: 200,
 */

@interface LIULoginRespondParameters : NSObject

@property(nonatomic,strong)NSString *Success;
@property(nonatomic,strong)NSString *Message;
@property(nonatomic,strong)NSNumber *ErrorCode;
@property(nonatomic,strong)LIUUserInfoData *Data;

@end
