//
//  LIUCategoryScrollerView.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/17.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIUCategoryScrollerView : UIScrollView

+ (LIUCategoryScrollerView *)creatCategoryScrollerViewWithCategorys:(NSArray *)categorys;
- (void)chuShiHuaSubScroller;
@property(nonatomic,strong)NSArray *categorys;

@end
