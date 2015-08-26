//
//  XKYSearchVCRecommendTableHeaderView.m
//  智慧旅游
//
//  Created by 刘俊 on 15/7/6.
//  Copyright (c) 2015年 新开元. All rights reserved.
//

#import "XKYSearchVCRecommendTableHeaderView.h"

@interface XKYSearchVCRecommendTableHeaderView ()

@property(nonatomic,strong)void (^tapBlock) (NSInteger index);

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *recommendBuutons;


@end

@implementation XKYSearchVCRecommendTableHeaderView

- (void)setRecommendDataWithDataArray:(NSArray *)dataArray andDidTapBlock:(void (^) (NSInteger index))tapBlock {
    
    
    if (dataArray == nil) {
        return;
    }
    /**
     *  @author 刘俊, 15-07-07
     *
     *  防止传进来的值不匹配导致程序崩溃
     */
    NSInteger index = MIN(self.recommendBuutons.count, dataArray.count);
    for (int i = 0; i < index; i++) {
        UIButton *button = self.recommendBuutons[i];
        button.hidden  = NO;
        NSDictionary *dic = dataArray[i];
        [button  setTitle:dic[@"Key"] forState:UIControlStateNormal];
       
        /**
         *  @author 刘俊, 15-07-07
         *
         *  是否需要切圆角
         */
        button.layer.cornerRadius = 5.0;
        button.layer.masksToBounds = YES;
    }
    self.tapBlock = tapBlock;
}

/**
 *  @author 刘俊, 15-07-07
 *
 *  点击button
 */
- (IBAction)didTapButton:(UIButton *)sender {
    NSLog(@"%@",sender.titleLabel.text);
    
    NSInteger  index = [self.recommendBuutons indexOfObject:sender];
    
    if (self.tapBlock) {
        self.tapBlock(index);
    }
}


@end
