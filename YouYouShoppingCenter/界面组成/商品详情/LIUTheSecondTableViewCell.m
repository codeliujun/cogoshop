//
//  LIUTheSecondTableViewCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/21.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUTheSecondTableViewCell.h"
#import "SVProgressHUD.h"

@interface LIUTheSecondTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;


@end

@implementation LIUTheSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma --mark 打电话
- (IBAction)telephone:(UIButton *)sender {
    [SVProgressHUD showSuccessWithStatus:@"打电话" duration:1];
    NSString *str = [self.telephoneLabel.text substringFromIndex:5];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (void)setGoods:(LIUGoodModel *)goods {
    _goods = goods;
    [self updateContent];
}

- (void)updateContent {
    
    self.titleLabel.text = self.goods.SupplierName;
    self.telephoneLabel.text = [NSString stringWithFormat:@"电话号码:%@",@"13790646251"];
    
}


@end
