//
//  LIUCaquView.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUCaquView.h"

@implementation LIUCaquView

+ (LIUCaquView *)view  {
    
    LIUCaquView *view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
    view.backgroundColor = [UIColor lightGrayColor];
    
    return view;
    
}

- (IBAction)comfirmButtonDidTap:(UIButton *)sender {
    
    
    if (self.confirmButtonBlock) {
        self.confirmButtonBlock();
    }
    
}

@end
