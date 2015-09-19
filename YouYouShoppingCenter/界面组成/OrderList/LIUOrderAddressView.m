//
//  LIUOrderAddressView.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/7.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUOrderAddressView.h"

@interface LIUOrderAddressView ()

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation LIUOrderAddressView

+ (LIUOrderAddressView *)view {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
}

- (void)setOrderData:(NSDictionary *)data {
    
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",data[@"ProvinceName"],data[@"CityName" ],data[@"AreaName"],data[@"DetailAddress"]];
    self.phoneLabel.text = data[@"Phone"];
    self.nameLabel.text = data[@"ContactName"];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
