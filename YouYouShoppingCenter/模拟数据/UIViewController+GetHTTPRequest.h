//
//  UIViewController+GetHTTPRequest.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/7/17.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#define kBaseUrl                    @"http://api.coolgou.com/api"
#define kGetRequestUrl(method)      [NSString stringWithFormat:@"%@/%@", kBaseUrl, method]

#define kLoginUrl                   kGetRequestUrl(@"User/login") //登录
#define kRegisterUrl                kGetRequestUrl(@"User/register") //注册
#define kAuthcodeUrl                kGetRequestUrl(@"User/authcode") //获取验证码
#define kGetShop                    kGetRequestUrl(@"User/shops")
#define kGetHotVocabulary           kGetRequestUrl(@"Product/hotkey")//获取热门词汇
#define kSearchGoods                kGetRequestUrl(@"Product/search")//搜索商品
#define kAddGood                    kGetRequestUrl(@"Cart/add")//添加到购物车
#define kGetCartGood                kGetRequestUrl(@"Cart/list")//获取购物车
#define kChangeGoodCOunt            kGetRequestUrl(@"Cart/updatecount")//更改数量
#define kDeletedGood                kGetRequestUrl(@"Cart/delete")//删除购物车
#define kGetGoodComment             kGetRequestUrl(@"Goods/comments")//获取商品评论
#define kCreatOrder                 kGetRequestUrl(@"Cart/settlement")//将商品转换为订单
#define kCreatNo                    kGetRequestUrl(@"Cart/BuildNo")
#define KGetOrderList               kGetRequestUrl(@"Order/list")//获取订单列表
#define kGetAddressList             kGetRequestUrl(@"Address/list")//获取地址列表
#define kGetFirstCater              kGetRequestUrl(@"Category/top")//获取一级分类
#define kGetSecondCater             kGetRequestUrl(@"Category/second")//获取二级分类
#define kGetInventor                kGetRequestUrl(@"Shop/inventory") //获取库存
#define kAddAddress                 kGetRequestUrl(@"Address/add")
#define kUpdataAddress              kGetRequestUrl(@"Address/update")
#define kSetDefault                 kGetRequestUrl(@"Address/setdefault")
#define kPayOrder                   kGetRequestUrl(@"Order/pay")
#define kAddComment                 kGetRequestUrl(@"Goods/addcomment")
#define kGetRecomment               kGetRequestUrl(@"Product/hotproducts")
#define kSearchAddres               kGetRequestUrl(@"Address/search")
#define kGetVersion                 kGetRequestUrl(@"APPVersion/info")
#define kUpdateUserInfo             kGetRequestUrl(@"kGetRequestUrl")
#define kCreatSaveCode              kGetRequestUrl(@"User/BuildRechargeCode")
#define kGetUserInfo                kGetRequestUrl(@"User/userinfo")
#define kGetAccountings             kGetRequestUrl(@"User/accountings")
#define kChangePassWord             kGetRequestUrl(@"User/changepwd")
#define kGetOrderDetail             kGetRequestUrl(@"Order/info")
#define kRemindDeliver              kGetRequestUrl(@"Order/reminddeliver")
#define kReciveCOnfirm              kGetRequestUrl(@"Order/receiptconfirm")
#define kFeedBack                   kGetRequestUrl(@"User/feedback")
#define kUpdateUserName             kGetRequestUrl(@"User/updatename")

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface UIViewController (GetHTTPRequest)

- (void)requestWithUrl:(NSString *)url Parameters:(NSDictionary *)parameters Success:(void (^) (NSDictionary *result))success Failue:(void (^) (NSDictionary *failueInfo))failue;
- (BOOL)userIsLogin;
- (void)showLoginView;
- (NSString *)getUserId;
- (void)upDateUserName:(NSString *)name;

@end
