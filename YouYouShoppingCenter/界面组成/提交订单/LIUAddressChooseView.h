//
//  LIUAddressChooseView.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/23.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIURecevingAderess.h"

@interface LIUAddressChooseView : UIView

@property (nonatomic, strong)void (^didTapButtonBlock)();

+ (LIUAddressChooseView *)view;
- (void)setAddRess:(LIURecevingAderess *)address;

@end
