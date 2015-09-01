//
//  LIUOrderTableViewCell.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUOrderModel.h"

typedef NS_ENUM(NSInteger, OrderStatus) {
    OrderStatusAll = 0,
    OrderStatussWillPay = 1,
    OrderStatusHaveSender = 4,
    OrderStatusEve = 8,
};

@class LIUOrderTableViewCell;
@protocol LIUOrderTableViewCellDelegate

- (void)cellDidTapButton:(LIUOrderTableViewCell *)cell;

@end

@interface LIUOrderTableViewCell : UITableViewCell


@property (nonatomic,strong)LIUOrderModel *order;

@property (nonatomic,assign) OrderStatus status;

@property (nonatomic,weak)id<LIUOrderTableViewCellDelegate> delegate;

@end
