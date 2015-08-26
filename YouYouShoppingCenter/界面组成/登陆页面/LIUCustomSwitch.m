//
//  LIUCustomSwitch.m
//  CustomSwitch
//
//  Created by 刘俊 on 15/6/13.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUCustomSwitch.h"

@interface LIUCustomSwitch ()

@property(nonatomic,strong)UIImageView *left_rightView;
@property(nonatomic,strong)UIImageView *thumbView;

@end

@implementation LIUCustomSwitch

- (instancetype)initWithFrame:(CGRect)frame {
    if (frame.size.width == 0 && frame.size.height == 0 && frame.origin.y == 0 && frame.origin.x == 0) {
        frame = CGRectMake(0, 0, 50, 30);
    }
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    //初始化view和thumbView
    self.left_rightView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.leftImage = [UIImage imageNamed:@"uiswitch_btn_bg_red.9"];
    self.rightImage = [UIImage imageNamed:@"uiswitch_button_abc.9"];
    self.left_rightView.image = self.leftImage;
    self.thumbView = [[UIImageView alloc]initWithFrame:CGRectMake(1, 0, self.frame.size.height, self.frame.size.height)];
    self.thumbView.frame = CGRectMake(self.bounds.size.width-self.thumbView.bounds.size.width-1, 0, self.thumbView.bounds.size.width, self.thumbView.bounds.size.height);
    self.thumbImage = [UIImage imageNamed:@"switch_btn_normal"];
    self.thumbView.image = self.thumbImage;
    self.on = NO;
    
//    self.layer.borderWidth = 1.0;
//    self.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.left_rightView];
    [self addSubview:self.thumbView];
    //添加一个手势，tap就行的
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
    [self addGestureRecognizer:tap];
}

//shoushi
- (void)didTap:(UITapGestureRecognizer *)tap {
    
    NSLog(@"beganTap");
    self.on = !self.on;
    //动画
    [self animateWithStatue:self.on];
    [self.delegate switchDidTapWithStatue:self.on];
    NSLog(@"endTap");
}

- (void)animateWithStatue:(BOOL)statue {
    
    //如果statue是yes，那么图片就应该在左边，是no就在右边
    CGRect leftFrame = CGRectMake(1, 0, self.thumbView.bounds.size.width, self.thumbView.bounds.size.height);
    CGRect rightFrame = CGRectMake(self.bounds.size.width-self.thumbView.bounds.size.width-1, 0, self.thumbView.bounds.size.width, self.thumbView.bounds.size.height);
    
    if (statue == YES) {
        [UIView animateWithDuration:0.25 animations:^{
            self.thumbView.frame = leftFrame;
            self.left_rightView.image = self.rightImage;
        }];
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            self.thumbView.frame = rightFrame;
            self.left_rightView.image = self.leftImage;
        }];
    }
    
}

@end
