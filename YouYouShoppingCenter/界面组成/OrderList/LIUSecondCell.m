//
//  LIUSecondCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/30.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUSecondCell.h"

@interface LIUSecondCell ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;


@end

@implementation LIUSecondCell

+ (LIUSecondCell *)cell {
    LIUSecondCell *cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
    return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)tapButton:(UIButton *)sender {
    
    for (UIButton *button in self.buttons) {
        if (sender == button) {
            button.layer.cornerRadius = 3.0f;
            button.layer.borderColor = sender.titleLabel.textColor.CGColor;
            button.layer.borderWidth = 1.f;
            button.layer.masksToBounds = YES;
        }else {
            button.layer.cornerRadius = 0.0f;
            button.layer.borderColor = [UIColor clearColor].CGColor;
            button.layer.borderWidth = 1.f;
            button.layer.masksToBounds = YES;
        }
    }
    
    
    
}

@end
