//
//  LIUAddressTableViewCell.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIURecevingAderess.h"

@class LIUAddressTableViewCell;
@protocol LIUAddressTableViewCellDelegate <NSObject>

- (void)didTapButtonCell:(LIUAddressTableViewCell *)cell;

@end

@interface LIUAddressTableViewCell : UITableViewCell

@property(nonatomic,strong)LIURecevingAderess *address;
@property(nonatomic,assign)BOOL isEdit;
@property(nonatomic,weak)id<LIUAddressTableViewCellDelegate> delegate;

@end
