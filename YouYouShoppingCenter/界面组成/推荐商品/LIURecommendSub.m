//
//  LIURecommendSub.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/5.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

#import "LIURecommendSub.h"
#import "UIImage+GetUrlImage.h"


@interface LIURecommendSub  ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation LIURecommendSub

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (LIURecommendSub *)view {
    LIURecommendSub *view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    return view;
}


- (void)setModel:(LIUGoodModel *)model {
    _model = model;
    [self updateContent];
}

- (void)updateContent {
    WS(ws);
    self.titleLabel.text = self.model.Name;
    [UIImage getImageWithThumble:self.model.ThumbUrl Success:^(UIImage *image) {
        ws.iconImageView.image = image;
    }];
    
}

- (IBAction)DidTapButton:(UIButton *)sender {
    if (self.didChooseBlock) {
        self.didChooseBlock(self.model);
    }
    [self.delegate didChooseGoodeModel:self.model];
}

@end
