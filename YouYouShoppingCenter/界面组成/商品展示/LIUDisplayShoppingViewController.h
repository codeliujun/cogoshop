//
//  LIUDisplayShoppingViewController.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/19.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIUCategoryModel.h"


@interface LIUDisplayShoppingViewController : UIViewController

@property(nonatomic,strong)NSString *keywords;//关键字
@property(nonatomic,strong)NSString *categoryid;
@property (nonatomic,strong)LIUCategoryModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
