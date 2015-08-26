//
//  LIUHeaderCollectionReusableView.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/18.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUHeaderCollectionReusableView.h"

@implementation LIUHeaderCollectionReusableView
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, 200, 30)];
    }
    return _label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];
    }
    return self;
}

@end
