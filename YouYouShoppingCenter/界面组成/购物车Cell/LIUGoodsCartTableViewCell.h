//
//  LIUGoodsCartTableViewCell.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/2.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUCartGoodModel.h"

@class LIUGoodsCartTableViewCell;

@protocol LIUGoodsCartTableViewCellDelegate

/**
 *  @author 刘俊, 15-08-03
 *
 *  返回count代理
 */
- (void)cell:(LIUGoodsCartTableViewCell *)cell GoodCountDidChangeWithAndCurrentCount:(NSInteger)count;
/**
 *  @author 刘俊, 15-08-03
 *
 *  删除按钮的点击
 */
- (void)cell:(LIUGoodsCartTableViewCell *)cell DidTapDeletedButton:(UIButton *)sender;

/**
 *  @author 刘俊, 15-08-03
 *
 *  选择按钮的点击
 */
- (void)cell:(LIUGoodsCartTableViewCell *)cell DidTapSelectButton:(UIButton *)sender;


@end

@interface LIUGoodsCartTableViewCell : UITableViewCell

@property (nonatomic ,assign) BOOL isEdit;
@property (nonatomic, strong) LIUCartGoodModel *cartGood;

@property (nonatomic, weak)id<LIUGoodsCartTableViewCellDelegate> delegate;

@end
