//
//  LIUCategoryCollectionViewCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/18.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUCategoryCollectionViewCell.h"
#import "ZHCache.h"
#import "UIImage+GetUrlImage.h"

@interface LIUCategoryCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *decLabel;

@end;

@implementation LIUCategoryCollectionViewCell

- (void)setCategory:(LIUCategoryModel *)category {
    _category = category;
    [self reloadCell];
}

- (void)reloadCell {
    self.decLabel.text = self.category.name;
    WS(ws);
    [UIImage getImageWithThumble:self.category.thumb Success:^(UIImage *image) {
        ws.iconImage.image = image;
    }];
    
    //self.iconImage.image = [UIImage imageNamed:self.category.imageName];
    //self.url = self.category.categoryId;
    [self setNeedsDisplay];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
