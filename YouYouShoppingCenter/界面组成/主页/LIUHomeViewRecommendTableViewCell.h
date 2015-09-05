//
//  LIUHomeViewRecommendTableViewCell.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/7/2.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUGoodModel.h"

@protocol LIUHomeViewRecommendTableViewCellDelegate <NSObject>

- (void)didChooseGoodModel:(LIUGoodModel *)model;

@end

@interface LIUHomeViewRecommendTableViewCell : UITableViewCell

+ (LIUHomeViewRecommendTableViewCell *)cell;

@property(nonatomic,strong)NSArray *recommends;
@property(nonatomic,strong)void (^buttonTap) (void);

@property (nonatomic,weak)id<LIUHomeViewRecommendTableViewCellDelegate> delegate;

@end
