//
//  LIUNewUseCell.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/5.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LIUNewUseCellDelegate <NSObject>

- (void)didTapButton:(UIButton *)sender;

@end

@interface LIUNewUseCell : UITableViewCell

+ (LIUNewUseCell *)cell;

@property (nonatomic,strong)void (^didTapButtonBlock) (UIButton *);

@property (nonatomic,weak)id<LIUNewUseCellDelegate> delegate;

- (void)setCellTitle:(NSString *)title;
- (void)setCellStatu:(NSString *)statu;
- (void)setStatuImage:(UIImage *)image;
- (void)hiddenButton;
- (void)setCellButtonTitle:(NSString *)title;


@end
