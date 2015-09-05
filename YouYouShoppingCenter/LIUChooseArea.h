//
//  LIUChooseArea.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/3.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AreaType) {
    AreaTypeProvince,
    AreaTypeCityid,
    AreaTypeArea,
};
typedef void (^DidChooseAreaBlock) (NSDictionary *);

@interface LIUChooseArea : UIViewController

@property (nonatomic,copy)DidChooseAreaBlock chooseAreaBlock;

@property (nonatomic,assign)AreaType currentArreaType;

@property (nonatomic,strong)NSString *provinceid;

@property (nonatomic,strong)NSString *cityid;

@property (nonatomic,strong)NSString *areaTitle;

@end
