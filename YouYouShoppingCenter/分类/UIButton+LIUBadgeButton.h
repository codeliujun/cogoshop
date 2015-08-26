//
//  UIButton+LIUBadgeButton.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/26.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LIUBadgeButton)

@property(nonatomic,strong)UILabel *badgeLabel;

- (void)setBadgeValue:(NSInteger)value TextColor:(UIColor *)textColor BackGroundColor:(UIColor *)BgColor;

@end
