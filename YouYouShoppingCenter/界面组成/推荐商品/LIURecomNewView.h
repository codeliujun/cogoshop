//
//  LIURecomNewView.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/5.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUGoodModel.h"


typedef void (^DidChooseGoodsBlock) (LIUGoodModel *);

@interface LIURecomNewView : UIView

+ (LIURecomNewView *)view;

//传进来一个数组，是包含商品的一个数组，然后就在button上面显示
@property(nonatomic,strong)NSArray *goodList;//只能显示4张

@property (nonatomic,strong)DidChooseGoodsBlock didChooseGoodBlock;

@end
