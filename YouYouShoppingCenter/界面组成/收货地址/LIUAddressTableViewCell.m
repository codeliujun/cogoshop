//
//  LIUAddressTableViewCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUAddressTableViewCell.h"
#import "Masonry.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUAddressTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *morenLabel;
@property (nonatomic,strong) UILabel *addressLabel;

@end;

@implementation LIUAddressTableViewCell

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.font = [UIFont systemFontOfSize:12.0];
        _addressLabel.numberOfLines = 2;
    }
    return _addressLabel;
}

- (void)setAddress:(LIURecevingAderess *)address {
    _address = address;
    [self updateCellContent];
}

- (void)updateCellContent {
    [self.addressLabel removeFromSuperview];
    self.addressLabel = nil;
    self.nameLabel.text = self.address.Name;
    self.numberLabel.text = self.address.Phone;
    
    self.addressLabel.text = self.address.FullAddress;
    CGRect rect = [self.addressLabel textRectForBounds:CGRectMake(0, 0, 999, 30) limitedToNumberOfLines:2];
    WS(ws);
    [self addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (ws.address.IsDefault) {
            ws.morenLabel.hidden = NO;
            make.left.equalTo(ws.morenLabel.mas_right).with.offset(5);
        }else {
            ws.morenLabel.hidden = YES;
            make.left.equalTo(ws.mas_left).with.offset(10);
        }
        make.top.equalTo(ws.nameLabel.mas_bottom).with.offset(5);
        make.right.equalTo(ws.mas_right).with.offset(-60);
        make.height.equalTo(@(rect.size.height));
    }];
    
    self.editButton.hidden = !self.isEdit;
    self.editButton.layer.cornerRadius = self.editButton.bounds.size.width*0.5;
    self.editButton.layer.masksToBounds = YES;
}

- (IBAction)goToEdit:(id)sender {
    [self.delegate didTapButtonCell:self];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
