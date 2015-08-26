//
//  LIUShoppingModel.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/19.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LIUGoodModel : NSObject

@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *imageName;//模拟数据用
@property(nonatomic,strong)NSNumber *originalPrice;
@property(nonatomic,strong)NSNumber *currentPrice;
@property(nonatomic,strong)NSString *shoppingUrl;
@property(nonatomic,strong)NSString *dec;//描述
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSNumber *sales;
@property(nonatomic,strong)NSArray *imageNames;
@property(nonatomic,strong)NSString *storeName;//是哪个店铺的
@property(nonatomic,strong)NSString *storeUrl;//后期可能用到

////自己加的，有一个属性是是否支付 好像可以不要的
//@property(nonatomic,assign)BOOL isPay;
@property(nonatomic,assign)NSInteger count;//选了多少个，默认是1;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,assign,readonly)float totalPrice;
/*
 {
 "IndexId" : 8292,
 "BrandName" : "优优酷购",
 "BrandId" : "7aa86eac-4a93-43d1-b348-a4eb000094e2",
 "StatusName" : "审核中",
 "Resell_Price" : 1.85,
 "PackNum" : 0,
 "Supplier2Id" : null,
 "Join_Price" : 1.85,
 "Unit" : "7a38ade2-0300-46b4-8497-a4f001181699",
 "DisplayOrder" : 0,
 "MinimumPurchaseAmount" : 0,
 "TotalNum" : 0,
 "InRoadNum" : 0,
 "Id" : "fd00bc28-7a79-481e-b969-bd02875679f0",
 "BarCode" : "6948960101563",
 "Warehouses" : null,
 "RealTimePrice" : 0,
 "Code" : "P00325",
 "NameSpecification" : "哈尔滨9度冰爽啤酒(罐装)330ml\/1*24",
 "Supplier3Id" : null,
 "Model" : null,
 "Content" : null,
 "Status" : 0,
 "Specification" : "1*24",
 "ThumbUrl" : "http:\/\/o2o.coolgou.com\/skins\/default\/images\/nophoto.png",
 "SafetyStock" : 0,
 "SupplierName" : "中山市嘉鸿商贸",
 "Hits" : 0,
 "Intro" : null,
 "Sell_Number" : 0,
 "CreateTime" : "\/Date(1439911331503)\/",
 "UnitStr" : "罐",
 "InstoreNumber" : 0,
 "RealTimeNum" : 0,
 "IsHot" : false,
 "ValidDate" : null,
 "IsRecommend" : false,
 "ThumbFileId" : null,
 "IsComment" : false,
 "CategoryName" : "啤酒",
 "SubName" : null,
 "SEODescription" : null,
 "Member_Price" : 2.31,
 "SEOName" : null,
 "CategoryId" : "5d835ec7-c81e-4c81-a96f-a4f0011318d1",
 "MSource" : null,
 "Sell_Price" : 3,
 "ProcurementCycle" : "0",
 "Name" : "哈尔滨9度冰爽啤酒(罐装)330ml",
 "Price" : 1.75,
 "Supplier1Id" : "8497c8d3-6108-4a9a-a0db-a4f801455330",
 "SEOKeyword" : null,
 "ImageUrls" : [
 
 ]
 }
 */


@property (nonatomic, copy) NSString * IndexId;

@property (nonatomic, copy) NSString *BrandName;

@property (nonatomic, copy) NSString *BrandId;

@property (nonatomic, copy) NSString *StatusName;

@property (nonatomic, copy) NSString *Resell_Price;

@property (nonatomic, copy) NSString * PackNum;

@property (nonatomic, copy) NSString *Supplier2Id;

@property (nonatomic, copy) NSString *Join_Price;

@property (nonatomic, copy) NSString *Unit;

@property (nonatomic, copy) NSString * DisplayOrder;

@property (nonatomic, copy) NSString * MinimumPurchaseAmount;

@property (nonatomic, copy) NSString * TotalNum;

@property (nonatomic, copy) NSString * InRoadNum;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *BarCode;

@property (nonatomic, copy) NSString *Warehouses;

@property (nonatomic, assign) NSString * RealTimePrice;

@property (nonatomic, copy) NSString *Code;

@property (nonatomic, copy) NSString *NameSpecification;

@property (nonatomic, copy) NSString *Supplier3Id;

@property (nonatomic, copy) NSString *Model;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString * Status;

@property (nonatomic, copy) NSString *Specification;

@property (nonatomic, copy) NSString *ThumbUrl;

@property (nonatomic, copy) NSString * SafetyStock;

@property (nonatomic, copy) NSString *SupplierName;

@property (nonatomic, copy) NSString * Hits;

@property (nonatomic, copy) NSString *Intro;

@property (nonatomic, copy) NSString * Sell_Number;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, copy) NSString *UnitStr;

@property (nonatomic, copy) NSString * InstoreNumber;

@property (nonatomic, copy) NSString * RealTimeNum;

@property (nonatomic, assign) BOOL IsHot;

@property (nonatomic, copy) NSString *ValidDate;

@property (nonatomic, assign) BOOL IsRecommend;

@property (nonatomic, copy) NSString *ThumbFileId;

@property (nonatomic, assign) BOOL IsComment;

@property (nonatomic, copy) NSString *CategoryName;

@property (nonatomic, copy) NSString *SubName;

@property (nonatomic, copy) NSString *SEODescription;

@property (nonatomic, copy) NSString * Member_Price;

@property (nonatomic, copy) NSString *SEOName;

@property (nonatomic, copy) NSString *CategoryId;

@property (nonatomic, copy) NSString *MSource;

@property (nonatomic, copy) NSString * Sell_Price;

@property (nonatomic, copy) NSString *ProcurementCycle;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString * Price;

@property (nonatomic, copy) NSString *Supplier1Id;

@property (nonatomic, copy) NSString *SEOKeyword;

@property (nonatomic, strong) NSArray *ImageUrls;

@end
