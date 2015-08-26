//
//  XKYSearchVCRecommendTableHeaderView.h
//  智慧旅游
//
//  Created by 刘俊 on 15/7/6.
//  Copyright (c) 2015年 新开元. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKYSearchVCRecommendTableHeaderView : UIView


- (void)setRecommendDataWithDataArray:(NSArray *)dataArray andDidTapBlock:(void (^) (NSInteger index))tapBlock;

@end
