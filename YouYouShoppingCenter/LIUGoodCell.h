//
//  LIUGoodCell.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/10/10.
//  Copyright © 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUGoodModel.h"

@interface LIUGoodCell : UITableViewCell
+ (LIUGoodCell *)cell;
@property (nonatomic,strong)LIUGoodModel *good;

@end