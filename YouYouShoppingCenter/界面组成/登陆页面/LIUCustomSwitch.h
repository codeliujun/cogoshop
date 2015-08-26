//
//  LIUCustomSwitch.h
//  CustomSwitch
//
//  Created by 刘俊 on 15/6/13.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LIUCustomSwitchDelegate <NSObject>

- (void)switchDidTapWithStatue:(BOOL)statue;

@end


@interface LIUCustomSwitch : UIView

@property(nonatomic,strong)UIImage *leftImage;
@property(nonatomic,strong)UIImage *rightImage;
@property(nonatomic,strong)UIImage *thumbImage;
@property(nonatomic,assign)BOOL on;

@property(nonatomic,weak)id<LIUCustomSwitchDelegate> delegate;

@end
