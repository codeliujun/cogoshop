//
//  UIButton+LIUBadgeButton.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/26.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "UIButton+LIUBadgeButton.h"
#import <objc/runtime.h>
#import "Masonry.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

const static NSString *badgeLabelKey = @"badgeLabel";
@implementation UIButton (LIUBadgeButton)

- (void)setBadgeLabel:(UILabel *)badgeLabel {
    objc_setAssociatedObject(self, &badgeLabelKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)badgeLabel {
    return objc_getAssociatedObject(self, &badgeLabelKey);
}

- (void)setBadgeValue:(NSInteger)value TextColor:(UIColor *)textColor BackGroundColor:(UIColor *)BgColor; {
    
    if (value == 0) {
        [self.badgeLabel removeFromSuperview];
        self.badgeLabel = nil;
        return;
    }
    
    if (self.badgeLabel == nil) {
        self.badgeLabel = [[UILabel alloc]init];
    }
    
    if (textColor == nil) {
        textColor = [UIColor whiteColor];
    }
    if (BgColor == nil) {
        BgColor = [UIColor redColor];
    }
    
    self.badgeLabel.text = [NSString stringWithFormat:@"%ld",(long)value];
    self.badgeLabel.textAlignment = NSTextAlignmentCenter;
    self.badgeLabel.textColor = textColor;
    self.badgeLabel.font = [UIFont systemFontOfSize:12];
    self.badgeLabel.backgroundColor = BgColor;
    CGRect rect = [self.badgeLabel textRectForBounds:CGRectMake(0, 0, 100, 100) limitedToNumberOfLines:1];
    
    [self addSubview:self.badgeLabel];
    
    [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(@(rect.size.width<rect.size.height?rect.size.height+4:rect.size.width+4));
        make.height.equalTo(@(rect.size.height));
    }];
    
    //将label切圆
    self.badgeLabel.layer.cornerRadius = rect.size.height*0.5;
    self.badgeLabel.layer.masksToBounds = YES;
    
}

@end
