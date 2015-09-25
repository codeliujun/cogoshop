//
//  LIUGoodInfoCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/9/25.
//  Copyright © 2015年 刘俊. All rights reserved.
//

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

#import "LIUGoodInfoCell.h"
#import "UIImage+GetUrlImage.h"

@interface LIUGoodInfoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *googIcon;
@property (weak, nonatomic) IBOutlet UILabel *goodtitle;
@property (weak, nonatomic) IBOutlet UILabel *goodCount;
@property (weak, nonatomic) IBOutlet UILabel *googPrice;


@end

@implementation LIUGoodInfoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderDetails:(NSDictionary *)orderDetail {
    
    WS(ws);
    [UIImage getImageWithThumble:orderDetail[@"ProductThumbUrl"] Success:^(UIImage *image) {
        ws.googIcon.image = image;
    }];
    
    self.goodtitle.text = orderDetail[@"ProductJson"][@"Name"];
    self.goodCount.text = [NSString stringWithFormat:@"数量:%@",orderDetail[@"Number"]];
    self.googPrice.text = [NSString stringWithFormat:@"价格:￥%@",orderDetail[@"TotalMoney"]];
    
}

@end
