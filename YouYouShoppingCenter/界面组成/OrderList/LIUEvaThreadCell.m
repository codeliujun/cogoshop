//
//  LIUEvaThreadCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/30.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUEvaThreadCell.h"
@interface LIUEvaThreadCell ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *desButtons;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *serButtons;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *speedButton;




@end



@implementation LIUEvaThreadCell

+ (LIUEvaThreadCell *)cell {
    LIUEvaThreadCell *cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
    return cell;
}

- (IBAction)desButton:(UIButton *)sender {
    NSInteger index = [self.desButtons indexOfObject:sender];
    
    [self lightButtonWithInde:index Buttons:self.desButtons];
    
    if (self.starBlock) {
        self.starBlock(EvaTypeDes,[NSString stringWithFormat:@"%d",index+1]);
    }
    
}

- (IBAction)serButton:(UIButton *)sender {
    NSInteger index = [self.serButtons indexOfObject:sender];
    
    [self lightButtonWithInde:index Buttons:self.serButtons];
    if (self.starBlock) {
        self.starBlock(EvaTypeSer,[NSString stringWithFormat:@"%d",index+1]);
    }
}
- (IBAction)speedButton:(UIButton *)sender {
    NSInteger index = [self.speedButton indexOfObject:sender];
    
    [self lightButtonWithInde:index Buttons:self.speedButton];
    if (self.starBlock) {
        self.starBlock(EvaTypeSpeed,[NSString stringWithFormat:@"%d",index+1]);
    }
}

- (void)lightButtonWithInde:(NSInteger)index Buttons:(NSArray *)Buttons {
    
    for (int i = 0; i < Buttons.count; i++) {
        
        UIButton *button = Buttons[i];
        
        if (i <= index) {
            button.selected = YES;
        }else {
            button.selected = NO;
        }
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
