//
//  LIUEvaFirstCell.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/30.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUOrderModel.h"

@interface LIUEvaFirstCell : UITableViewCell

+ (LIUEvaFirstCell *)cell;
@property (nonatomic ,strong)LIUOrderModel *model;

@end
