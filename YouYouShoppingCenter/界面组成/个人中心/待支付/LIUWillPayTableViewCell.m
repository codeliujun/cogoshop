//
//  LIUWillPayTableViewCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/26.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUWillPayTableViewCell.h"
#import "Masonry.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUWillPayTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (nonatomic,strong)UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (nonatomic,strong)UILabel *orderTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPrice;
@property (nonatomic,strong)UILabel *orderPriceLabel;

@end


@implementation LIUWillPayTableViewCell

- (UILabel *)orderNumberLabel {
    if (_orderNumberLabel==nil) {
        _orderNumberLabel = [UILabel new];
    }
    return _orderNumberLabel;
}

- (UILabel *)orderPriceLabel {
    if (!_orderPriceLabel) {
        _orderPriceLabel = [UILabel new];
    }
    return _orderPriceLabel;
}

- (UILabel *)orderTimeLabel {
    if (!_orderTimeLabel) {
        _orderTimeLabel = [UILabel new];
    }
    return _orderTimeLabel;
}

- (void)setOrderModel:(LIUOrderModel *)orderModel {
    
    _orderModel = orderModel;
    
    [self updateCellContent];
}

- (void)updateCellContent {
    [self.orderNumberLabel removeFromSuperview];
    self.orderNumberLabel = nil;
    [self.orderPriceLabel removeFromSuperview];
    self.orderPriceLabel = nil;
    [self.orderTimeLabel removeFromSuperview];
    self.orderTimeLabel = nil;
    
    WS(ws);
    
    self.orderTimeLabel.text = self.orderModel.Id;
    self.orderNumberLabel.font = [UIFont systemFontOfSize:15.0];
    CGRect rect = [self.orderNumber textRectForBounds:CGRectMake(0, 0, 999, 999) limitedToNumberOfLines:1];
    [self addSubview:self.orderNumberLabel];
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.orderNumber);
        make.leading.equalTo(ws.orderNumber.mas_right).with.offset(5);
        make.width.equalTo(@(rect.size.width));
        make.height.equalTo(@(rect.size.height));
    }];
    
    self.orderPriceLabel.text = [NSString stringWithFormat:@"%.2f",self.orderModel.TotalAmount];
    self.orderPriceLabel.font = [UIFont systemFontOfSize:15.0];
    rect = [self.orderPriceLabel textRectForBounds:CGRectMake(0, 0, 999, 999) limitedToNumberOfLines:1];
    [self addSubview:self.orderPriceLabel];
    [self.orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.orderPrice);
        make.left.equalTo(ws.orderPrice.mas_right).with.offset(5);
        make.width.equalTo(@(rect.size.width));
        make.height.equalTo(@(rect.size.height));
    }];
    
    
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    fm.dateFormat = @"YYYY-MM-dd HH:mm";
    NSString *timeStr = [fm stringFromDate:[NSDate new]];
    self.orderTimeLabel.text = timeStr;
    self.orderTimeLabel.font = [UIFont systemFontOfSize:15.0];
    rect = [self.orderTimeLabel textRectForBounds:CGRectMake(0, 0, 999, 999) limitedToNumberOfLines:1];
    [self addSubview:self.orderTimeLabel];
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.orderTime);
        make.left.equalTo(ws.orderTime.mas_right).with.offset(5);
        make.width.equalTo(@(rect.size.width));
        make.height.equalTo(@(rect.size.height));
    }];

}

- (IBAction)goPay:(UIButton *)sender {
    [self.delegate cellDidTapPayButtonWithOrder:self.orderModel];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
