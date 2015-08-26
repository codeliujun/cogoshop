//
//  LIULoginRequestParameters.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/7/2.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LIULoginRequestParameters : NSObject

@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)NSString *pwd;
@property(nonatomic,strong)NSNumber *logintype;//0主账户 1子账户

@end
