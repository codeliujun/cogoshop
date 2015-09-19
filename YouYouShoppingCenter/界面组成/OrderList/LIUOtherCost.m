//
//  LIUOtherCost.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/9/16.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUOtherCost.h"

@interface LIUOtherCost ()

@property (weak, nonatomic) IBOutlet UILabel *deliverGoods;
@property (weak, nonatomic) IBOutlet UILabel *dicount;
@property (weak, nonatomic) IBOutlet UILabel *fullhalf;
@property (weak, nonatomic) IBOutlet UILabel *integerCover;

@end

@implementation LIUOtherCost

+ (LIUOtherCost *)view {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
