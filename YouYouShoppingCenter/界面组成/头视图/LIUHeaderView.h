//
//  LIUHeaderView.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/19.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

//根据传进来的数组，创建等宽的button
#import <UIKit/UIKit.h>

@protocol LIUHeaderViewDelegate <NSObject>

- (void)headerViewDidSelectButtonInfo:(NSDictionary *)Info;

@end

@interface LIUHeaderView : UIView

@property(nonatomic,strong)UIColor *nomalColor;
@property(nonatomic,strong)UIColor *selectColor;
@property(nonatomic,weak)id<LIUHeaderViewDelegate> delegate;

//初始化，传进来一个数组（头部按钮名字的数组）
+ (LIUHeaderView *)creatHeaderViewWithItems:(NSArray *)items;
//Block传值
+ (LIUHeaderView *)creatHeaderViewWithItems:(NSArray *)items DidSelectButtonInfo:(void (^) (NSDictionary *info))info;
@end
