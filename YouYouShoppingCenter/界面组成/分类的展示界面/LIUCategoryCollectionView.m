//
//  LIUCategoryCollectionView.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/18.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#define kScreenBounds       [UIScreen mainScreen].bounds

#import "LIUCategoryCollectionView.h"
#import "LIUHeaderCollectionReusableView.h"
#import "LIUCategoryCollectionViewCell.h"
@interface LIUCategoryCollectionView()

@property(nonatomic,strong)NSArray *allKeys;

@end;

@implementation LIUCategoryCollectionView

- (NSArray *)allKeys {
    if (!_allKeys) {
        _allKeys = [self.category allKeys];
    }
    return _allKeys;
}

+ (LIUCategoryCollectionView *)creatCategoryCollectionViewWithCategpry:(NSDictionary *)category {
    //配置scrollerView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //layout.itemSize = CGSizeMake((kScreenBounds.size.width-80-40)/3.0, (kScreenBounds.size.width-80-40)/3.0);
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 10;
    LIUCategoryCollectionView *categoryView = [[LIUCategoryCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    categoryView.category = category;
    return categoryView;
}

- (void)setCategory:(NSDictionary *)category {
    _category = category;
    self.dataSource = self;
    self.delegate = self;
    self.backgroundColor = [UIColor clearColor];
    [self registerNib:[UINib nibWithNibName:@"LIUCategoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"mycell"];
    //注册headerView
    [self registerClass:[LIUHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self registerClass:[LIUHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];

    [self reloadData];
}

#pragma --mark UICollectionViewDelegate和UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
     return self.allKeys.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *items = self.category[self.allKeys[section]];
    return items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
#warning 模拟数据
    LIUCategoryCollectionViewCell *cell = (LIUCategoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
    NSArray *array = self.category[self.allKeys[indexPath.section]];
    cell.category = array[indexPath.item];
    //cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma --mark 点击单元格触发的事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = self.category[self.allKeys[indexPath.section]];
    LIUCategoryModel *model = array[indexPath.item];
#warning 这里需要跳转分类的界面
    NSLog(@"%@要跳转,发通知",model.name);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LIUDidTapCategoryItem" object:nil userInfo:@{@"category":model}];
}

#pragma --添加表头的视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseIdentifier;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter]){
        reuseIdentifier = @"foot";
    }else{
        reuseIdentifier = @"header";
    }
    
    LIUHeaderCollectionReusableView *view =  (LIUHeaderCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind :kind   withReuseIdentifier:reuseIdentifier   forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        //view.backgroundColor = [UIColor greenColor];
        //1.拿到section对应的字典
        NSString *text = self.allKeys[indexPath.section];
    view.label.text = text;
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        view.backgroundColor = [UIColor lightGrayColor];
        view.label.text = [NSString stringWithFormat:@"这是footer:%ld",(long)indexPath.section];
    }
    return view;

}

#pragma --mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenBounds.size.width-80-40)/3.0, (kScreenBounds.size.width-80-40)/2.0);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 30, 20, 30);
}
//foot不要
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(self.bounds.size.width, 30);
//}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.bounds.size.width, 30);
}


@end
