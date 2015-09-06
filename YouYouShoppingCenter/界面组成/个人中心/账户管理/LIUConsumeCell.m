//
//  LIUConsumeCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/6.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUConsumeCell.h"
#import "UIColor+HexColor.h"

@interface LIUConsumeCell ()

@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation LIUConsumeCell

- (void)awakeFromNib {
   
}

- (void)setComsumer:(NSDictionary *)comsumer {
    _comsumer = comsumer;
    [self upDateConetnt];
}

- (void)upDateConetnt {
    
    UIColor *color = nil;
    NSString *symbol = @"";
    
    if ([self.comsumer[@"LiquidityName"] isEqualToString:@"充值"]) {
        color = [UIColor hexStringToColor:@"3FD825"];
        symbol = @"+";
    }else {
        color = [UIColor hexStringToColor:@"FF1200"];
        symbol = @"-";
    }
    
    self.cellTitleLabel.textColor = color;
    self.cellTitleLabel.text = self.comsumer[@"LiquidityName"];
    self.descriptionLabel.text = self.comsumer[@"Describe"];
    self.orderNoLabel.text = self.comsumer[@"No"];
    
    self.priceLabel.textColor = color;
    CGFloat price = [self.comsumer[@"Money"] floatValue];
    self.priceLabel.text = [NSString stringWithFormat:@"%@￥%.2f",symbol,price];
    
    self.timeLabel.text = [self getDateStr];
}

- (NSString *)getDateStr {
    
    NSString *time1 = self.comsumer[@"CompleteTime"];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
