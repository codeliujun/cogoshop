//
//  LIUCategoryCollectionView.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/18.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LIUCategoryCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

+ (LIUCategoryCollectionView *)creatCategoryCollectionViewWithCategpry:(NSDictionary *)category;

@property(nonatomic,strong)NSDictionary *category;

@end
