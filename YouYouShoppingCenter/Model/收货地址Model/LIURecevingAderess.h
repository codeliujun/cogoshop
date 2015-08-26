//
//  LIURecevingAderess.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/24.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LIURecevingAderess : NSObject


@property (nonatomic, copy) NSString *FullAddress;

@property (nonatomic, copy) NSString *CityName;

@property (nonatomic, copy) NSString *Aliase;

@property (nonatomic, copy) NSString *ProvinceName;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *Email;

@property (nonatomic, copy) NSString *UserId;

@property (nonatomic, copy) NSString *Phone;

@property (nonatomic, copy) NSString *AreaName;

@property (nonatomic, copy) NSString *CityId;

@property (nonatomic, copy) NSString *ContactPhone;

@property (nonatomic, assign) BOOL IsDefault;

@property (nonatomic, copy) NSString *DetailAddress;

@property (nonatomic, copy) NSString *PostalCode;

@property (nonatomic, copy) NSString *AreaId;

@property (nonatomic, copy) NSString *ProvinceId;
/*
 {
 "FullAddress" : "广东省深圳市宝安区深圳市宝安区西乡大道与宝源路交汇处(华源商务中心)415室",
 "CityName" : "深圳市",
 "Aliase" : "nst",
 "ProvinceName" : "广东省",
 "Id" : "61380098-1a82-4322-abfa-a4fa00b41786",
 "Name" : "式节约12磊工3",
 "Email" : "xxx",
 "UserId" : "0186fe42-9663-47a3-8334-a4eb000094cd",
 "Phone" : "15013500090",
 "AreaName" : "宝安区",
 "CityId" : "1913f31d-8f65-4a8e-b1df-1b9883b42c2b",
 "ContactPhone" : "27652193",
 "IsDefault" : true,
 "DetailAddress" : "深圳市宝安区西乡大道与宝源路交汇处(华源商务中心)415室",
 "PostalCode" : "518000",
 "AreaId" : "89a13076-15d8-4325-81b0-0e5536091c49",
 "ProvinceId" : "5148fb8b-5e85-4dc8-8723-810a366db730"
 }
 */



@end
