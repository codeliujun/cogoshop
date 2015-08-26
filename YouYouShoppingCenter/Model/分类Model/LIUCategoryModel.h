//
//  LIUCategoryModel.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/18.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface LIUCategoryModel : NSObject

//@property(nonatomic,strong)NSURL *url;//分类的链接地址
//@property(nonatomic,strong)NSURL *imageUrl;//图片的url
//@property(nonatomic,strong)NSString *imageName;//测试使用
//@property(nonatomic,strong)NSString *name;//分类的名字
//
//
//
//@property (nonatomic, copy) NSString *categoryId;
//
//@property (nonatomic, copy) NSString *thumb;
//
////@property (nonatomic, copy) NSString *name;
//
//@property (nonatomic, assign) BOOL haschild;
//
//@property (nonatomic, assign) NSInteger displayorder;


@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) BOOL haschild;

@property (nonatomic, assign) NSInteger displayorder;



@end
