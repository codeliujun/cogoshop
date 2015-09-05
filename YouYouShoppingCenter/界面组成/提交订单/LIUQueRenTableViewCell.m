//
//  LIUQueRenTableViewCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/24.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUQueRenTableViewCell.h"
#import "ZHCache.h"
#import "Masonry.h"
#import "UIImage+GetUrlImage.h"
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUQueRenTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *shopIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *priceLabel;

@end

@implementation LIUQueRenTableViewCell

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
    }
    return _countLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
    }
    return _priceLabel;
}

- (void)awakeFromNib {
    // Initialization code
}


- (void)setMode:(LIUOrderModel *)mode {
    _mode = mode;
    [self.priceLabel removeFromSuperview];
    self.priceLabel = nil;
    [self.countLabel removeFromSuperview];
    self.countLabel = nil;
    
    self.desLabel.text = mode.ProductName;
    
    WS(ws);
    [UIImage getImageWithThumble:mode.ProductThumbUrl Success:^(UIImage *image) {
        ws.shopIconImageView.image = image;
    }];
    
    self.countLabel.font = [UIFont systemFontOfSize:10];
    self.countLabel.text = [NSString stringWithFormat:@"×%ld",mode.ProductCount];
    CGRect rect = [self.countLabel textRectForBounds:CGRectMake(0, 0, 200, 200) limitedToNumberOfLines:0];
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-8);
        make.centerY.equalTo(ws);
        make.width.equalTo(@(rect.size.width));
        make.height.equalTo(@(rect.size.height));
    }];
    
    self.priceLabel.font = [UIFont systemFontOfSize:13];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",mode.ProductPrice];
    rect = [self.priceLabel textRectForBounds:CGRectMake(0, 0, 200, 200) limitedToNumberOfLines:0];
    [self addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-8);
        make.top.equalTo(ws).with.offset(10);
        make.width.equalTo(@(rect.size.width));
        make.height.equalTo(@(rect.size.height));
    }];
    
    self.orderNumber.text = [NSString stringWithFormat:@"订单编号：%@",mode.Code];
}

@end
