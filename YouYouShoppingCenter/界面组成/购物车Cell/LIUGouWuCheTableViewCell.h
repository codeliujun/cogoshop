//
//  LIUGouWuCheTableViewCell.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/23.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUCartGoodModel.h"

@class LIUGouWuCheTableViewCell;

@protocol LIUGouWuCheTableViewCellDelegate <NSObject>

- (void)didTapSelectButtonWithIsSelect:(BOOL)isSelect AndCell:(LIUGouWuCheTableViewCell *)cell;
- (void)countDidChange;
- (void)didTapDeleteButtonWithCell:(LIUGouWuCheTableViewCell *)cell;

@end

@interface LIUGouWuCheTableViewCell : UITableViewCell

@property(nonatomic,strong)LIUCartGoodModel *goodModel;
@property(nonatomic,assign)BOOL isEdit;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property(nonatomic,weak)id<LIUGouWuCheTableViewCellDelegate> delegate;

@end
