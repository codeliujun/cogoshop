//
//  LIUGoodCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/10/10.
//  Copyright © 2015年 刘俊. All rights reserved.
//

#import "LIUGoodCell.h"
#import "UIImageView+WebCache.h"

@interface LIUGoodCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pricLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@end

@implementation LIUGoodCell

+ (LIUGoodCell *)cell {
    
   return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setGood:(LIUGoodModel *)good {
    _good = good;
    
    self.titleLabel.text = good.NameSpecification;
    self.pricLabel.text = [NSString stringWithFormat:@"￥%.2f",[good.Member_Price floatValue]];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:good.ThumbUrl] placeholderImage:[UIImage imageNamed:@"测试图片"]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
