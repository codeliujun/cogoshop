//
//  LIUAddressChooseView.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/23.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUAddressChooseView.h"

@interface LIUAddressChooseView ()

@property (nonatomic,strong)LIURecevingAderess *address;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *fullAddress;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end

@implementation LIUAddressChooseView

+ (LIUAddressChooseView *)view {
    LIUAddressChooseView *view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
    return view;
}

- (void)setAddRess:(LIURecevingAderess *)address {
    
    _address = address;
    [self updateContent];
}

- (void)updateContent {
    
    self.name.text = [NSString stringWithFormat:@"收货人：%@",self.address.Name];
    self.fullAddress.text = self.address.FullAddress;
    self.phone.text = self.address.Phone;
    
    
}
- (IBAction)didTap:(UIButton *)sender {
    
    if (self.didTapButtonBlock) {
        self.didTapButtonBlock();
    }
}

@end
