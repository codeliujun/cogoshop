//
//  LIUDetailHeaderImageScrollerView.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/19.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUDetailHeaderImageScrollerView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUDetailHeaderImageScrollerView ()<UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *allButtons;

@end

@implementation LIUDetailHeaderImageScrollerView

+ (LIUDetailHeaderImageScrollerView *)creatScrollerWithShopping:(LIUGoodModel *)shopping {
    
    LIUDetailHeaderImageScrollerView *scrollerView = [[LIUDetailHeaderImageScrollerView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    scrollerView.bounces = NO;
    scrollerView.pagingEnabled = YES;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.delegate = scrollerView;
    scrollerView.backgroundColor = [UIColor whiteColor];
    [scrollerView addContentViewWithShoppings:shopping];
    
    return scrollerView;
}

- (void)addContentViewWithShoppings:(LIUGoodModel *)shopping {
    WS(ws);
    
    self.allButtons = [NSMutableArray new];
    UIView *contrain = [UIView new];
    [self addSubview:contrain];
    [contrain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
        make.height.equalTo(ws.mas_height);
    }];
    
    //判断imageUrls是否有
    BOOL hasUrl= NO;
    if (shopping.ImageUrls.count != 0) {
        hasUrl = YES;
    }
    UIImageView *lastButton = nil;
    
    for (int i = 0; i < MAX(shopping.ImageUrls.count, 2) ; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [button setBackgroundImage:[UIImage imageNamed:shopping.imageNames[i]] forState:UIControlStateNormal];
        if (hasUrl) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:shopping.ImageUrls[i]] placeholderImage:[UIImage imageNamed:@"测试图片"]];
        }else {
            [imageView sd_setImageWithURL:[NSURL URLWithString:shopping.ThumbUrl] placeholderImage:[UIImage imageNamed:@"测试图片"]];
        }
        
//        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [contrain addSubview:imageView];
        [self.allButtons addObject:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(ws.mas_width);
            make.height.equalTo(ws.mas_height);
            if (lastButton) {
                make.left.equalTo(lastButton.mas_right);
            }else{
                make.left.equalTo(contrain.mas_left);
            }
        }];
        lastButton = imageView;
    }
    
    [contrain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastButton.mas_right);
    }];
    
}

//scroller的点击
//- (void)tapButton:(UIButton *)sender {
//    NSLog(@"嘎嘎 终于点我了");
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //总得宽度是
    //CGFloat length = self.bounds.size.width*self.allButtons.count;
    NSInteger index = scrollView.contentOffset.x / self.bounds.size.width + 1;
    [self.indexDelegate currentImageIndex:index];
}

@end
