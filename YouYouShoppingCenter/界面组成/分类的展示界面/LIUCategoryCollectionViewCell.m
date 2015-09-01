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
    NSData *cacheImageData = [ZHCache getCacheImageData:self.category.name];
    if (cacheImageData) {
        self.iconImage.image = [UIImage  imageWithData:cacheImageData];
    }else {
       __block UIImage *image = nil;
        NSString *imageStr = [self.category.thumb stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    image = [UIImage imageWithData:data];
                    NSData *imageData = UIImagePNGRepresentation(image);
                    [ZHCache writeData:imageData fileName:self.category.name];
                    self.iconImage.image = image;
                }else {
                    self.iconImage.image = [UIImage imageNamed:@"测试图片"];
                }
            });
        });
        
        
    }
    
    
    
    
    //self.iconImage.image = [UIImage imageNamed:self.category.imageName];
    //self.url = self.category.categoryId;
    [self setNeedsDisplay];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
