//
//  LIUCaquView.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIUCaquView : UIView

+ (LIUCaquView *)view;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic ,copy) void (^confirmButtonBlock) ();

@end
