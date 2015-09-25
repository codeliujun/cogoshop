//
//  LIUPaySaveController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/5.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUPaySaveController.h"
#import "SVProgressHUD.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@interface LIUPaySaveController ()

@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end

@implementation LIUPaySaveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付宝充值";
    self.orderLabel.text = self.orderNo;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",[self.Price floatValue]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pay:(UIButton *)sender {
    [self Alixpay];
}

//在这个里面集成
- (void)Alixpay {
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088911313595311";
    NSString *seller = @"youyoukugou@163.com";
    //NSString *privateKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDACkfeJd4mTEwpyREayE2MOqp7o6yk8J0CRc0z yYVY1GLon5dGgQutNEZ/ZhyT9sfj/skmPaXThOw8XSKB17JZ99yqLIPwhvDN09rQL0TuWljqF6vj 3foKwlj9hfRO+Vu2CoBc8LjT49V+rgiLvbsfLxoCnOOVcnJMqjWvjG3qtwIDAQAB";
    //NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKrSV06LmcFan1BjYr/vFeglR2kdj9RwoS9QJGQwvfZUTMFQeEfIcR4eTZ8XgQIcUr0Gfi3QXAviXtTOo80EO8zzk05saRAC0te3CtYtH7aTyx71mzRKMiSunoSE5/GDY0vTKBE1tZV0KeDv1ZEw0j7DbYecBCDx34lHzUfNyCr3AgMBAAECgYA4AMna2G3KNFmy00KWxl2aRE6LKcPz1BEkH9QufMRqs+yOHEGy1wYu56RvGheTh5GgozZO8taaltacUjrlhhPMblyPr/J6H+lvvXP8dQIZjRGof7YPm3+jMMrDPZ1nbZNtsoN6kE2uSAk6zkEuAt9sLDt0WGyqtqiPbbjHjD6b4QJBAN2viFZ0upyYET3Ot3iA6b6bWe7O+AiW7fUAo/le54X20N+5b9FC9Pqz3sTm47o/GKD2yemLADPKBsRg9aVZUXkCQQDFQ0gd+6X8aHv+8fzO5cgNjX7/zyB58rswHwhP289nyc4dz45OvHeob0dNmrkjlWBgwi2gKPnQLeLmdLe0+jPvAkEAz2QK+U7k0eDVqGv+aoa3pjDx1p7bnjWM0jtSK9YkZMh9qf9yY2PviabCjpSukSu8H8IhLRJ0Ev86i3dl99VyiQJAfyrNrg6RxfNxpDxKNvMpEZubOLxFenhBtlb7G8hfn9AYIV2xpw6WsS3zsJLDMa5VsGrd0Pc5fLxoHxs1ZuU5XwJAZVMg5VnyEpJ2PRQx9qO9FsqSPNDI30Orw3u1/+8E0bxq/VFaSPqK955I5lNSb8QNK5HvjbZNkGsh+7wWeMWNfw==";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOuIo46b22jmICfrpMWzsTVR6GwfR7bSjAwl3Cfx7R7BUNqLH+x9M4u2+e6P7SfsStzFwUbxDriQO05YVcA8PGFOubeUz1KSLBnXwgO6HdFJ/OenDVU7cy1iw2WUx5EvpWdnRIMmblay8D7ipQY+ILMZbiB7K/ETwRcDfjMAkh1VAgMBAAECgYBeo2d8nLlbe+P9xlxNp/cTQpcOIr9xAUaOdwPv9PBfBDQVrAMmxePZRqtEJQaYnQQzky4m8CMHG8UIpMvH0yw687Sh6/rdv/bSuICD0Bee+Mi5tZcBbvIqytRma+tMpY2G8O9qs61V85aRrlu9JK2M92R3N29pECtnx/d99hFpgQJBAP2hDlRS451h9dqgYANhsHzdMC946dsjA1S5D67rB5mUlRa4ohqKsS5bXPPhzX2IZERgmgkw+yr/I7uQxTUML2ECQQDtvEet9qqPrdCVayvDJSt7Pc9hGKwkbAdvpM9bY505sGDH4sPSgITBt0ZtDWcU5O/4EOSFxHnElquIGOyZQjZ1AkEA7AVDa28TR7MQcdoKXzs6XIgNPjAcF4P2ppHsqU8n7GCbeOBqYZ6tEUGON5nqeyZAgG0RCvqc0T9KxlILYrkrIQJAbUZZ/FChXaGbetLkLrLrJZ7nr83TcnplgJ/U4EENh/LWyYomUJ/aZeCEcqPyedwxoWjCYepJvl8zQT+ToW6Z8QJBANAM7bk2hkIlPZ2Oh0FC4YMpSbpWiNwzJZ7jaN+GvuYif9vkQ6clDGrfopFIp8xgMrRHfHkgvIW6eEgB4D69PHI=";
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = self.orderNo; //订单ID（由商家自行制定）
    order.productName = @"账户充值"; //商品标题

    order.productDescription = @"会员账户充值"; //商品描述
    order.amount = [NSString stringWithFormat:@"%.2f",0.01/*[self.Price floatValue]*/]; //商品价格 测试价格
    order.notifyURL =  @"http://o2o.coolgou.com/default/alipayNotify"; //回调URL

    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"YouYouShoppingCenter";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSString *str = resultDic[@"memo"];
            if ([str isEqualToString:@""]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                 [SVProgressHUD showErrorWithStatus:resultDic[@"memo"] duration:1.5f];
            }
        }];
    }

}



@end
