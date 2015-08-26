//
//  LIUHomeCategoryCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/7/27.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUHomeCategoryCell.h"

@interface LIUHomeCategoryCell()

@property (weak, nonatomic) IBOutlet UIImageView *categoryIcon;
@property (weak, nonatomic) IBOutlet UILabel *catrgoryLabel;


@end

@implementation LIUHomeCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
