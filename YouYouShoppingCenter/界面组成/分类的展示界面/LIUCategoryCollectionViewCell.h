//
//  LIUCategoryCollectionViewCell.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/18.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUCategoryModel.h"

@interface LIUCategoryCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)LIUCategoryModel *category;
@property(nonatomic,strong)NSURL *url;
@end
