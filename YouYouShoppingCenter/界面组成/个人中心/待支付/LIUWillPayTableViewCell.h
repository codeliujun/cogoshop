//
//  LIUWillPayTableViewCell.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/26.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUOrderModel.h"

@protocol LIUWillPayTableViewCellDelegate <NSObject>

- (void)cellDidTapPayButtonWithOrder:(LIUOrderModel *)order;

@end

@interface LIUWillPayTableViewCell : UITableViewCell

@property(nonatomic,strong)LIUOrderModel *orderModel;
@property(nonatomic,weak)id<LIUWillPayTableViewCellDelegate> delegate;
@end
