//
//  LIUNewUseCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/5.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUNewUseCell.h"

@interface LIUNewUseCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *statuLabel;
@property (weak, nonatomic) IBOutlet UILabel *cuTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellButton;


@end

@implementation LIUNewUseCell

+ (LIUNewUseCell *)cell {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    
    self.cellButton.layer.cornerRadius = 5.0;
    self.cellButton.layer.masksToBounds =YES;
    
}

- (void)setCellButtonTitle:(NSString *)title {
    [self.cellButton setTitle:title forState:UIControlStateNormal];
}

- (void)setCellTitle:(NSString *)title {
    
    self.cuTitleLabel.text = title;
    
}
- (void)setCellStatu:(NSString *)statu {
    self.iconImageView.hidden = YES;
    self.statuLabel.text = statu;
}
- (void)setStatuImage:(UIImage *)image {
    self.statuLabel.hidden = YES;
    self.iconImageView.image = image;
}
- (void)hiddenButton {
    self.cellButton.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapButton:(UIButton *)sender {
    
    if (self.didTapButtonBlock) {
        self.didTapButtonBlock(sender);
    }
    
    [self.delegate didTapButton:sender];
    
}

@end
