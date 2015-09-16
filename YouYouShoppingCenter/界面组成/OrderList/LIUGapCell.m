//
//  LIUGapCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/9/16.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUGapCell.h"
#import "Masonry.h"

@implementation LIUGapCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellCustomView:(UIView *)view {
    WS(ws);
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView).insets(UIEdgeInsetsZero);
    }];
    
}

@end
