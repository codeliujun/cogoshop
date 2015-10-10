//
//  LIUDisplayTableViewCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/19.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUDisplayTableViewCell.h"
#import "Masonry.h"
#import "UIImage+GetUrlImage.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUDisplayTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *shoppingImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *decLabel;
@property (strong, nonatomic) UILabel *currentLabel;
@property (strong, nonatomic) UILabel *originalLabel;
@property(nonatomic,strong)UILabel *salesLabel;

@end

@implementation LIUDisplayTableViewCell

- (UILabel *)currentLabel {
    if (!_currentLabel) {
        _currentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    }
    return _currentLabel;
}
- (UILabel *)salesLabel {
    if (!_salesLabel) {
        _salesLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    }
    return _salesLabel;
}
- (UILabel *)originalLabel {
    if (!_originalLabel) {
        _originalLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    }
    return _originalLabel;
}

- (void)setShopping:(LIUGoodModel *)shopping {
    _shopping = shopping;
    [self updateCellContent];
}

- (void)updateCellContent {
    WS(ws);
    [self.currentLabel removeFromSuperview];
    self.currentLabel = nil;
    [self.salesLabel removeFromSuperview];
    self.salesLabel = nil;
    [self.originalLabel removeFromSuperview];
    self.originalLabel = nil;
    
    //1.计算当前价格和原价的的label大小
    self.currentLabel.font = [UIFont systemFontOfSize:17];
    self.currentLabel.textColor = [UIColor redColor];
    self.currentLabel.text = [NSString stringWithFormat:@"￥%.1f",[self.shopping.Member_Price floatValue]];
    CGRect currentPriceRect = [self.currentLabel textRectForBounds:CGRectMake(0, 0, 200, 20) limitedToNumberOfLines:1];
    //NSLog(@"currentPriceRect:%@",NSStringFromCGRect(currentPriceRect));
    [self addSubview:self.currentLabel];
    [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.decLabel.mas_bottom).with.offset(10);
        make.left.equalTo(ws.shoppingImageView.mas_right).with.offset(8);
        make.width.equalTo(@(currentPriceRect.size.width));
        make.height.equalTo(@(currentPriceRect.size.height));
    }];
    
    
    self.originalLabel.font = [UIFont systemFontOfSize:12];
    self.originalLabel.textColor = [UIColor lightGrayColor];
    self.originalLabel.text = [NSString stringWithFormat:@"￥%.1f",[self.shopping.Sell_Price floatValue]];
    CGRect originalPriceRect = [self.originalLabel textRectForBounds:CGRectMake(0, 0, 200, 17) limitedToNumberOfLines:1];
    [self addSubview:self.originalLabel];
    [self.originalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.currentLabel);
        make.left.equalTo(ws.currentLabel.mas_right).with.offset(5);
        make.width.equalTo(@(originalPriceRect.size.width));
        make.height.equalTo(@(originalPriceRect.size.height));
    }];
    // NSLog(@"originalPriceRect:%@",NSStringFromCGRect(originalPriceRect));
    
    self.salesLabel.font = [UIFont systemFontOfSize:9];
    self.salesLabel.textColor = [UIColor lightGrayColor];
    self.salesLabel.text = [NSString stringWithFormat:@"销量:%@",self.shopping.Sell_Number];
    //self.salesLabel.backgroundColor = [UIColor redColor];
    CGRect salesPriceRect = [self.salesLabel textRectForBounds:CGRectMake(0, 0, 200, 10) limitedToNumberOfLines:1];
    [self addSubview:self.salesLabel];
    
    [self.salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.currentLabel);
        make.right.equalTo(ws.mas_right).with.offset(-20);
        make.width.equalTo(@(salesPriceRect.size.width));
        make.height.equalTo(@(salesPriceRect.size.height));
    }];
    //NSLog(@"salesPriceRect:%@",NSStringFromCGRect(salesPriceRect));
    
    [UIImage getImageWithThumble:self.shopping.ThumbUrl Success:^(UIImage *image) {
        ws.shoppingImageView.image = image;
    }];
    
    self.titleLabel.text = self.shopping.SupplierName;
    self.decLabel.text = self.shopping.Name;
    
    [self setNeedsDisplay];
}


@end
