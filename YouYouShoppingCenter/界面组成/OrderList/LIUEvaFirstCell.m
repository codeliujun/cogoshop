//
//  LIUEvaFirstCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/30.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUEvaFirstCell.h"

@interface LIUEvaFirstCell ()

@property (weak, nonatomic) IBOutlet UILabel *order;
@property (weak, nonatomic) IBOutlet UILabel *time;


@end

@implementation LIUEvaFirstCell

+ (LIUEvaFirstCell *)cell {
    
    LIUEvaFirstCell *cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
    return cell;
}


- (void)setModel:(LIUOrderModel *)model {
    
    _model = model;
    self.order.text = [NSString stringWithFormat:@"订单号：%@",model.Code];
    self.time.text = [self getDateStr];
}

- (NSString *)getDateStr {
    
    NSString *time1 = self.model.Datetime;
    NSString *time2 = [time1 substringWithRange:NSMakeRange(6, time1.length-8)];
    NSLog(@"%@===%@",time1,time2);
    
    NSInteger timeInterval = [time2 integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"YYYY-MM-dd";
    return [df stringFromDate:date];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
