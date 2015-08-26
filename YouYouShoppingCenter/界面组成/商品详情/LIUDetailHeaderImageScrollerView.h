//
//  LIUDetailHeaderImageScrollerView.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/19.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUGoodModel.h"

@protocol LIUDetailHeaderImageScrollerViewDelegate <NSObject>

- (void)currentImageIndex:(NSInteger)index;

@end

@interface LIUDetailHeaderImageScrollerView : UIScrollView

+ (LIUDetailHeaderImageScrollerView *)creatScrollerWithShopping:(LIUGoodModel *)shopping;
@property(nonatomic,weak)id<LIUDetailHeaderImageScrollerViewDelegate> indexDelegate;

@end
