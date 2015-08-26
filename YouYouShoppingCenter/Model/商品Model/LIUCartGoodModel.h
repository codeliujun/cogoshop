//
//  LIUCartGoodModel.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/7/30.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LIUCartGoodModel : NSObject


@property (nonatomic, copy) NSString *BarCode;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *ProductId;

@property (nonatomic, copy) NSString *MemberId;

@property (nonatomic, strong) NSNumber *Number;

@property (nonatomic, copy) NSString *ShopId;

@property (nonatomic, copy) NSString *OtherFeesRmk;

@property (nonatomic, copy) NSString *ThumbUrl;

@property (nonatomic, strong) NSNumber *TotalMoney;

@property (nonatomic, copy) NSString *ThumbFileId;

@property (nonatomic, strong) NSNumber *Price;

@property (nonatomic, strong) NSNumber *OtherFees;

@property (nonatomic, copy) NSString *Code;

@property (nonatomic, strong) NSNumber *InstoreNumber;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, assign) NSInteger count;

/*
 {
 "ThumbFileId" : null,
 "Id" : "03e6034f-470e-4bf8-8f92-a4e4015c98d8",
 "Name" : "康师傅 酸梅汤 450ml",
 "ProductId" : "0cc38ee1-291d-435b-9491-a4e2013a8a69",
 "MemberId" : "3ac8d1f3-448c-4ec6-9ee8-a4e2013a8a43",
 "Number" : 1,
 "ShopId" : null,
 "OtherFeesRmk" : null,
 "ThumbUrl" : "http:\/\/uugo.cnnst.com\/skins\/default\/images\/nophoto.png",
 "TotalMoney" : 0,
 "Price" : 12,
 "OtherFees" : 0,
 "Code" : "2123124563456342160",
 "BarCode" : null,
 "InstoreNumber" : 10
 }
 */

@end
