//
//  LIUUserInfoData.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/7/2.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"


@interface LIUUserInfoData : NSObject

+ (LIUUserInfoData *)defaultUserInfo;

@property (nonatomic, copy) NSString *loginid;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *ThumbUrl;

@property (nonatomic, copy) NSString *lastname;

@property (nonatomic, copy) NSString *Code;

@property (nonatomic, copy) NSString *Balance;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *IntegralNumber;

@property (nonatomic, copy) NSString *Level;

@property (nonatomic, copy) NSString *ThumbFileId;



/*
@property(nonatomic,strong)NSString *account;//account: "13341189799",
@property(nonatomic,strong)NSString *address;//address: "",
@property(nonatomic,strong)NSString *birthday;//birthday: "",
@property(nonatomic,strong)NSString *companyid;//companyid: "",
@property(nonatomic,strong)NSString *ebankid;//ebankid: "",
@property(nonatomic,strong)NSString *ecashaccount;//ecashaccount: "",
@property(nonatomic,strong)NSNumber *flag;//flag: "1",
@property(nonatomic,strong)NSNumber *isverify;//isverify: 1,
@property(nonatomic,strong)NSNumber *gender;//gender: 0,
@property(nonatomic,strong)NSNumber *logintimes;//logintimes: "2",
@property(nonatomic,strong)NSString *memberid;//memberid: "20131123095806092523",
@property(nonatomic,strong)NSNumber *membertype;//membertype: "2",
@property(nonatomic,strong)NSString *nickname;//nickname: "13341189799",
@property(nonatomic,strong)NSString *token;//token: "159e553c-322b-4e38-b921-4cbc4de0ddf9",
logintype: "",
mobile: "",
mobilecode: "",
newPwd: "",
oldpwd: "",
organization: "",
otheremail: "",
othermobile: "",
phone: "",
postcode: "",
pwd: "",
regip: "",
regsource: "",
regtime: "",
status: "",
truename: "",
type: "",
url: "",
vericode: ""
education: "",
email: "",
emailcode: "",
hobby: "",
idcode: "",
idtype: "",
institutionid: "",
*/


@end
