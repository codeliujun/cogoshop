//
//  LIUCategoryScrollerView.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/17.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUCategoryScrollerView.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUCategoryModel.h"
#import "Masonry.h"

#define BUTTON_HEIGH 50
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface LIUCategoryScrollerView ()

@property(nonatomic,strong)NSMutableArray *allButtons;

@end

@implementation LIUCategoryScrollerView

- (NSMutableArray *)allButtons {
    if(!_allButtons) {
        _allButtons = [NSMutableArray new];
    }
    return _allButtons;
}

+ (LIUCategoryScrollerView *)creatCategoryScrollerViewWithCategorys:(NSArray *)categorys {
    
    LIUCategoryScrollerView *scrollerView = [[LIUCategoryScrollerView alloc]initWithCategorys:categorys];
    return scrollerView;
}
- (instancetype)initWithCategorys:(NSArray *)categorys {
    
    if (self = [super init]) {
        self.categorys = categorys;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}

//初始化右边的
- (void)chuShiHuaSubScroller {
    [self didTapButton:self.allButtons[0]];
}

//重写category的set方法
- (void)setCategorys:(NSArray *)categorys {
    _categorys = categorys;
    [self updateScrollerwithCategorys:categorys];
}

- (void)updateScrollerwithCategorys:(NSArray *)categorys {
    
    WS(ws);
    UIView *container = [UIView new];
    [self addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
        make.width.equalTo(ws);
    }];

    UIView *lastView = nil;//用来记录上一个view的位置
    
    //2.创建子View
    for (int i = 0; i < categorys.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"search_label_normal_bg"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
       
        //[button setTitle:categorys[i] forState:UIControlStateNormal];
        [button setTitle:categorys[i][@"name"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"search_label_select_bg"] forState:UIControlStateSelected];
        
        //2.将buttonadd进scroller
        [container addSubview:button];
        [self.allButtons addObject:button];
        //3.创建约束
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.equalTo(container);
            make.height.equalTo(@(BUTTON_HEIGH));
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom);
            }else{
                make.top.equalTo(ws.mas_top);
            }
        }];
        lastView = button;
    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];
}

- (void)didTapButton:(UIButton *)sender {
    for (UIButton *button in self.allButtons) {
        button.selected = NO;
    }
    sender.selected = YES;
    CGPoint point = CGPointMake(sender.frame.origin.x, sender.frame.origin.y);

    //获取当前点击的button
    NSInteger index = [self.allButtons indexOfObject:sender];
    //获取当前的一级分类
    NSDictionary *firstCater = self.categorys[index];
    UIViewController *VC = [UIViewController new];
    /*
     topid={topid}&pageindex={pageindex}&pagesize={pagesize}&thumbwidth={thumbwidth}&thumbheight={thumbheight}
     */
    [VC requestWithUrl:kGetSecondCater Parameters:@{
        @"topid":firstCater[@"id"],
        @"pageindex":@1,
        @"pagesize":@20,
        @"thumbwidth":@20,
        @"thumbheight":@20,
    }Success:^(NSDictionary *result) {
        NSDictionary *dic = result[@"Data"];
        NSArray *dicModel = [LIUCategoryModel objectArrayWithKeyValuesArray:dic];
        NSDictionary *newDic = @{firstCater[@"name"]:dicModel};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"LIUDidTapCategoryButton" object:nil userInfo:@{@"Shopping":newDic}];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
#pragma --mark 点击button发送通知
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"LIUDidTapCategoryButton" object:nil userInfo:@{@"Shopping":modelDic}];
    WS(ws);
    //点击滑动
    if (point.y < self.contentSize.height-sender.bounds.size.height*11) {
        [UIView animateWithDuration:.5 animations:^{
            ws.contentOffset = CGPointMake(point.x, point.y);
        }];
    }else{
        [UIView animateWithDuration:.5 animations:^{
            ws.contentOffset = CGPointMake(point.x, self.contentSize.height-sender.bounds.size.height*11-3);
        }];
    }
    NSLog(@"%@===%lu",sender.titleLabel.text,[self.allButtons indexOfObject:sender]);
}

@end
