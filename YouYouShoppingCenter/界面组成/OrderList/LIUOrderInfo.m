//
//  LIUOrderInfo.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/9/16.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUOrderInfo.h"

@interface LIUOrderInfo()

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

@property (weak, nonatomic) IBOutlet UILabel *orderTime;

@end

@implementation LIUOrderInfo

+ (LIUOrderInfo *)view {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
}

- (void)setOrderDetail:(NSDictionary *)orderDetail {
    self.orderNumber.text = [NSString stringWithFormat:@"订单编号:%@",orderDetail[@"Code"]];
    self.orderTime.text = [NSString stringWithFormat:@"下单时间:%@",[self getDateStrWithOrderDetail:orderDetail]];
}

- (NSString *)getDateStrWithOrderDetail:(NSDictionary *)orderDetail {
    
    NSString *time1 = orderDetail[@"Datetime"];
    if ([time1 isEqual:[NSNull null]]) {
        return @"时间没有";
    }
    NSString *time2 = [time1 substringWithRange:NSMakeRange(6, time1.length-8)];
    NSLog(@"%@===%@",time1,time2);
    
    NSInteger timeInterval = [time2 integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"YYYY-MM-dd";
    return [df stringFromDate:date];
}

@end
