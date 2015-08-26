//
//  LIUHeaderView.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/19.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUHeaderView.h"
#import "Masonry.h"
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface LIUHeaderView()

@property(nonatomic,strong)NSMutableArray *allButtons;

@property(nonatomic,assign)void (^buttonInfo) (NSDictionary *info);

@end

@implementation LIUHeaderView

+ (LIUHeaderView *)creatHeaderViewWithItems:(NSArray *)items {
    
    LIUHeaderView *headerView = [LIUHeaderView new];
    [headerView creatButtonWithItems:items];
   
    return headerView;
}

+ (LIUHeaderView *)creatHeaderViewWithItems:(NSArray *)items DidSelectButtonInfo:(void (^) (NSDictionary *info))info {
    LIUHeaderView *headerView = [LIUHeaderView new];
    [headerView creatButtonWithItems:items];
    headerView.buttonInfo = info;
    return headerView;
}

- (void)creatButtonWithItems:(NSArray *)items {
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    self.nomalColor = [UIColor blackColor];
    self.selectColor = [UIColor redColor];
    self.allButtons = [NSMutableArray new];
    UIButton *lastButton = nil;
    
    WS(ws);
    for (int i = 0; i < items.count; i++) {
        
        UIButton *currentButton = [[UIButton alloc]init];
        [currentButton setTitle:items[i] forState:UIControlStateNormal];
        [currentButton setTitleColor:self.nomalColor forState:UIControlStateNormal];
        [currentButton setTitleColor:self.selectColor forState:UIControlStateSelected];
        [currentButton addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        currentButton.backgroundColor = [UIColor whiteColor];
        [self addSubview:currentButton];
        [self.allButtons addObject:currentButton];
        
        if (lastButton) {
            [currentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastButton.mas_right);
                make.top.equalTo(ws.mas_top);
                make.bottom.equalTo(ws.mas_bottom).with.offset(-1);
                make.width.equalTo(lastButton.mas_width);
            }];
        }else{
            [currentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.mas_left);
                make.top.equalTo(ws.mas_top);
                make.bottom.equalTo(ws.mas_bottom).with.offset(-1);
            }];
        }
        lastButton = currentButton;
    }
    
    [lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right);
    }];
}

- (void)didTapButton:(UIButton*)sender {
    for (UIButton *button in self.allButtons) {
        button.selected = NO;
    }
    sender.selected = YES;
    NSLog(@"%@",sender.titleLabel.text);
   
    //向一个空的对象发消息是不会报错的 代理传值
    [self.delegate headerViewDidSelectButtonInfo:@{@"title":sender.titleLabel.text}];
    
    if (self.buttonInfo) {
        //如果block存在
        self.buttonInfo(@{@"title":sender.titleLabel.text});
    }
    
}

- (void)setNomalColor:(UIColor *)nomalColor {
    _nomalColor = nomalColor;
    for (UIButton *button in self.allButtons) {
        [button setTitleColor:nomalColor forState:UIControlStateNormal];
    }
}

- (void)setSelectColor:(UIColor *)selectColor {
    _selectColor = selectColor;
    for (UIButton *button in self.allButtons) {
        [button setTitleColor:selectColor forState:UIControlStateSelected];
    }
}

@end
