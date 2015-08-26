//
//  LIUCategoryCollectionViewCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/18.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUCategoryCollectionViewCell.h"
#import "ZHCache.h"

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
    
    //1.读取缓存中又没有图片
    NSData *cacheImageData = [ZHCache getCacheData:self.category.thumb];
    if (cacheImageData) {
        self.iconImage.image = [UIImage  imageWithData:cacheImageData];
    }else {
        UIImage *image = nil;
        NSString *imageStr = [self.category.thumb stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
        if (data) {
            image = [UIImage imageWithData:data];
            NSData *imageData = UIImagePNGRepresentation(image);
            [ZHCache saveData:imageData fileName:self.category.thumb];
            self.iconImage.image = image;
        }else {
            self.iconImage.image = [UIImage imageNamed:@"测试图片"];
        }
    }
    
    
    
    
    //self.iconImage.image = [UIImage imageNamed:self.category.imageName];
    //self.url = self.category.categoryId;
    [self setNeedsDisplay];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
