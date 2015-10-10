//
//  LIUChangeNumberCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/10/10.
//  Copyright © 2015年 刘俊. All rights reserved.
//

#import "LIUChangeNumberCell.h"

@interface LIUChangeNumberCell ()

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@end

@implementation LIUChangeNumberCell

+ (LIUChangeNumberCell *)cell {
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
}

- (void)awakeFromNib {
    // Initialization code
    [self upDateLabel];
    [self.stepper addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)valueChange:(UIStepper *)sender {
    
    [self upDateLabel];
    
}

- (void)upDateLabel {
    
    self.numberLabel.text = [NSString stringWithFormat:@"%d",(int)self.stepper.value];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
