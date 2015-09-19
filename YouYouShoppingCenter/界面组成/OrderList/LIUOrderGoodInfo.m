//
//  LIUOrderGoodInfo.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/9/16.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUOrderGoodInfo.h"
#import "UIImage+GetUrlImage.h"

@interface LIUOrderGoodInfo ()

@property (weak, nonatomic) IBOutlet UIImageView *goodIcon;
@property (weak, nonatomic) IBOutlet UILabel *goodTitle;

@property (weak, nonatomic) IBOutlet UILabel *goodCount;

@property (weak, nonatomic) IBOutlet UILabel *goodPrice;
@end

@implementation LIUOrderGoodInfo

+ (LIUOrderGoodInfo *)view {
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]firstObject];
}

- (void)setOrderDetails:(NSDictionary *)orderDetail {
    
    WS(ws);
    [UIImage getImageWithThumble:orderDetail[@"ProductThumbUrl"] Success:^(UIImage *image) {
        ws.goodIcon.image = image;
    }];
    
    self.goodTitle.text = orderDetail[@"ProductJson"][@"Name"];
    self.goodCount.text = [NSString stringWithFormat:@"数量:%@",orderDetail[@"Number"]];
    self.goodPrice.text = [NSString stringWithFormat:@"价格:￥%@",orderDetail[@"TotalMoney"]];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
