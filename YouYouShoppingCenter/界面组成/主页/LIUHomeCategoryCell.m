//
//  LIUHomeCategoryCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/7/27.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUHomeCategoryCell.h"
#import "ZHCache.h"

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
    
    //1.读取缓存中又没有图片
    NSData *cacheImageData = [ZHCache getCacheImageData:caterInfo[@"name"]];
    if (cacheImageData) {
        self.categoryIcon.image = [UIImage  imageWithData:cacheImageData];
    }else {
        __block UIImage *image = nil;
        NSString *imageStr = [caterInfo[@"thumb"] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    image = [UIImage imageWithData:data];
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSData *imageData = UIImagePNGRepresentation(image);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [ZHCache writeData:imageData fileName:caterInfo[@"name"]];
                            self.categoryIcon.image = image;
                        });
                    });
                }else {
                    self.categoryIcon.image = [UIImage imageNamed:@"测试图片"];
                }

            });
        });
        
           }
    
    self.catrgoryLabel.text = caterInfo[@"name"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
