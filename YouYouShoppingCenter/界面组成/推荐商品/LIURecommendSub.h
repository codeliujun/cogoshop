//
//  LIURecommendSub.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/5.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUGoodModel.h"
@class LIURecommendSub;

@protocol LIURecommendSubDelegate <NSObject>

- (void)didChooseGoodeModel:(LIUGoodModel *)model;

@end

typedef void (^DidChooseGoodsBlock) (LIUGoodModel *);

@interface LIURecommendSub : UIView

+ (LIURecommendSub *)view;

@property (nonatomic,strong)DidChooseGoodsBlock didChooseBlock;

@property (nonatomic,strong)LIUGoodModel *model;

@property (nonatomic,weak)id<LIURecommendSubDelegate> delegate;

@end
