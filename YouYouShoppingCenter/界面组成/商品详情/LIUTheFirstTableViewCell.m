//
//  LIUTheFirstTableViewCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/21.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUTheFirstTableViewCell.h"
@interface LIUTheFirstTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *memberPrice;
@property (weak, nonatomic) IBOutlet UILabel *sellPrice;
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;


@end

@implementation LIUTheFirstTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setGoods:(LIUGoodModel *)goods {
    _goods = goods;
    [self updateContent];
}

- (void)updateContent {
    
    self.memberPrice.text = [NSString stringWithFormat:@"￥%@",self.goods.Join_Price];
    self.sellPrice.text = [NSString stringWithFormat:@"￥%@",self.goods.Sell_Price];
    self.salesLabel.text = [NSString stringWithFormat:@"%@",self.goods.Sell_Number];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
