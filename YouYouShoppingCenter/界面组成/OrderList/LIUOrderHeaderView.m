//
//  LIUOrderHeaderView.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/7.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUOrderHeaderView.h"

@interface LIUOrderHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *statuImageViews;

@end

@implementation LIUOrderHeaderView


+ (LIUOrderHeaderView *)view {
    LIUOrderHeaderView *view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    [view setStatusViewHighlighted:3];
    return view;
}

- (void)setStatusViewHighlighted:(NSInteger)index {//1~4
    
    for (int i = 0; i < self.statuImageViews.count; i++) {
        
        UIImageView *image = self.statuImageViews[i];
        
        if (index-1 >= i) {
            image.highlighted = YES;
        }else {
            image.highlighted = NO;
        }
        
    }
    
    NSString *str = nil;
    switch (index) {
        case 1:
            str = @"待付款";
            break;
        case 2:
            str = @"已发货";
            break;
        case 3:
            str = @"确认收货";
            break;
        case 4:
            str = @"已完成";
            break;
            
        default:
            break;
    }
    
    self.statusLabel.text = str;
    
   // [self setNeedsDisplay];
    
}


@end
