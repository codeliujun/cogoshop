//
//  LIUOrderTableViewCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUOrderTableViewCell.h"
#import "UIImage+GetUrlImage.h"

@interface  LIUOrderTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;


@end


@implementation LIUOrderTableViewCell

- (void)awakeFromNib {
    self.button.layer.cornerRadius = 3.0f;
    self.button.layer.masksToBounds = YES;
}

- (void)setOrder:(LIUOrderModel *)order{
    
    _order = order;
    [self updateContent];
    
}

- (void)updateContent {
    
    self.countLabel.text = [NSString stringWithFormat:@"合计：%@件",self.order.ProductNumber];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.order.Total];
    self.titleLabel.text = self.order.ProductName;
    self.countPriceLabel.text = [NSString stringWithFormat:@"数量：%@   价格：%.2f",self.order.ProductNumber,self.order.Total];
    self.orderStatusLabel.text = self.order.OrderStatusDes;
    
    
    WS(ws);
    [UIImage getImageWithThumble:self.order.ProductThumbUrl Success:^(UIImage *image) {
        ws.goodIconImageView.image = image;
    }];
    
    /*
     typedef NS_ENUM(NSInteger, OrderStatus) {
     OrderStatusAll = 0,
     OrderStatussWillPay = 1,  生成订单了
     OrderStatusDidPay = 2,   //待发货 等于3的适合才是发货
     OrderStatusHaveSender = 4, //已经发货，也就是确认收货了
     OrderStatusEve = 8, //订单已经完成了
     };
     */
    NSInteger status = self.order.Status;
    NSString *title = @"详情";
    switch (status) {
        case 1:
            title = @"付款";//@"付款";
            break;
        case 2:
            title = @"提醒发货";
            break;
        case 4:
            title = @"确认收货";
            break;
        case 8:
            title = @"待评价";
            break;
        default:
            title = @"详情";
            break;
    }
    [self.button setTitle:title forState:UIControlStateNormal];
    
    NSString *dateStr = [self getDateStr];
    self.titleLabel.text = dateStr;
}

- (NSString *)getDateStr {
    
    NSString *time1 = self.order.Datetime;
    NSString *time2 = [time1 substringWithRange:NSMakeRange(6, 10)];
    NSLog(@"%@===%@",time1,time2);
    
    NSInteger timeInterval = [time2 integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.dateFormat = @"YYYY-MM-dd mm:HH:ss";
    return [df stringFromDate:date];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)tapButton:(id)sender {
    [self.delegate cellDidTapButton:self];
}

@end
