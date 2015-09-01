//
//  LIUOrderTableViewCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUOrderTableViewCell.h"
#import "ZHCache.h"
@interface  LIUOrderTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;

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
    
    //1.读取缓存中又没有图片
    NSData *cacheImageData = [ZHCache getCacheImageData:self.order.ProductName];
    if (cacheImageData) {
        self.goodIconImageView.image = [UIImage  imageWithData:cacheImageData];
    }else {
       __block UIImage *image = nil;
        NSString *imageStr = [self.order.ProductThumbUrl stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    image = [UIImage imageWithData:data];
                    NSData *imageData = UIImagePNGRepresentation(image);
                    [ZHCache writeData:imageData fileName:self.order.ProductName];
                    self.goodIconImageView.image = image;
                }else {
                    self.goodIconImageView.image = [UIImage imageNamed:@"测试图片"];
                }

            });
        });
        
           }
    
    NSString *title = @"";
    switch (self.status) {
        case OrderStatusAll:
            title = @"详情";
            break;
        case OrderStatussWillPay:
            title = @"付款";
            break;
        case OrderStatusHaveSender:
            title = @"确认收货";
            break;
        case OrderStatusEve:
            title = @"评价";
            break;
        default:
            break;
    }
    [self.button setTitle:title forState:UIControlStateNormal];
    
    NSString *dateStr = [self getDateStr];
    self.titleLabel.text = dateStr;
}

- (NSString *)getDateStr {
    
    NSString *time1 = self.order.Datetime;
    NSString *time2 = [time1 substringWithRange:NSMakeRange(6, time1.length-8)];
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
