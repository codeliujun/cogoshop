//
//  LIUHomeViewRecommendTableViewCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/7/2.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUHomeViewRecommendTableViewCell.h"
#import "SVProgressHUD.h"
#import "LIURecomNewView.h"
#import "Masonry.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUHomeViewRecommendTableViewCell()

@property(nonatomic,strong)LIURecomNewView *recommendView;

@end

@implementation LIUHomeViewRecommendTableViewCell

+ (LIUHomeViewRecommendTableViewCell *)cell {
    LIUHomeViewRecommendTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
    [cell addRecommendView];
    return cell;
}

//初始化推荐界面，以后可以在需要的的时候传值,安装创建之后直接添加到了推荐的界面

- (LIURecomNewView *)recommendView {
    if (!_recommendView) {
        WS(ws);
        _recommendView = [LIURecomNewView view];
        _recommendView.didChooseGoodBlock = ^(LIUGoodModel *model) {
            [ws.delegate didChooseGoodModel:model];
        };
        [self addSubview:_recommendView];
        //masonry约束 先要add进去
        [_recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws).insets(UIEdgeInsetsMake(40, 0, 0, 0));
        }];
    }
    return _recommendView;
}

- (void)addRecommendView {
    WS(ws);
    _recommendView = [LIURecomNewView view];
    _recommendView.didChooseGoodBlock = ^(LIUGoodModel *model) {
        [ws.delegate didChooseGoodModel:model];
    };
    [self addSubview:_recommendView];
    //masonry约束 先要add进去
    [_recommendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws).insets(UIEdgeInsetsMake(40, 0, 0, 0));
    }];
}


- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)moreInfo:(UIButton *)sender {
    
    if (self.buttonTap) {
        self.buttonTap();
    }
}

- (void)setRecommends:(NSArray *)recommends {
    if (recommends == nil) {
        return;
    }
    _recommends = [recommends copy];
    self.recommendView.goodList = recommends;
    [self setNeedsDisplay];
}

@end
