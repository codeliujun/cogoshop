//
//  LIURecomNewView.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/5.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIURecomNewView.h"
#import "LIURecommendSub.h"
#import "Masonry.h"

@interface LIURecomNewView ()<LIURecommendSubDelegate>


@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *recommendSupViews;

@property (nonatomic,strong)NSMutableArray *recommendSubViews;

@end

@implementation LIURecomNewView

- (NSMutableArray *)recommendSubViews {
    if (_recommendSubViews == nil) {
        _recommendSubViews = @[].mutableCopy;
    }
    return _recommendSubViews;
}

+ (LIURecomNewView *)view {
    
    LIURecomNewView *view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    [view initSubViews];
    
    
    return view;
    
}

- (void)initSubViews {

    for (UIView *supView in self.recommendSupViews) {
        
        LIURecommendSub *sub = [LIURecommendSub view];
        [supView addSubview:sub];
        [sub mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(supView).insets(UIEdgeInsetsZero);
        }];
        
        [self.recommendSubViews addObject:sub];
        
    }
    
}

- (void)setGoodList:(NSArray *)goodList {
    
    _goodList = goodList;
    [self updateContentView];
}

- (void)updateContentView {
    
    NSInteger count = MIN(self.goodList.count, self.recommendSubViews.count);
    
    for (int i = 0; i < count; i++) {
        LIUGoodModel *model = self.goodList[i];
        LIURecommendSub *sub = self.recommendSubViews[i];
        sub.delegate = self;
        sub.model = model;
    }
    
}

- (void)didChooseGoodeModel:(LIUGoodModel *)model {
    
    if (self.didChooseGoodBlock) {
        self.didChooseGoodBlock(model);
    }
    
}


@end
