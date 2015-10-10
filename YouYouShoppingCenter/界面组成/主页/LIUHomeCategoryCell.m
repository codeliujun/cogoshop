//
//  LIUHomeCategoryCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/7/27.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUHomeCategoryCell.h"
#import "UIImageView+WebCache.h"
@interface LIUHomeCategoryCell()

@property (weak, nonatomic) IBOutlet UIImageView *categoryIcon;
@property (weak, nonatomic) IBOutlet UILabel *catrgoryLabel;


@end

@implementation LIUHomeCategoryCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCaterInfo:(NSDictionary *)caterInfo {
    _caterInfo = caterInfo;
    
//    WS(ws);
//    [UIImage getImageWithThumble:caterInfo[@"thumb"] Success:^(UIImage *image) {
//        ws.categoryIcon.image = image;
//    }];
    [self.categoryIcon sd_setImageWithURL:caterInfo[@"thumb"] placeholderImage:[UIImage imageNamed:@"测试图片"]];
    
    self.catrgoryLabel.text = caterInfo[@"name"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
