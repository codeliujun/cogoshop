//
//  LIUEvaThreadCell.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/30.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EvaType) {
    EvaTypeDes,
    EvaTypeSer,
    EvaTypeSpeed,
};

@interface LIUEvaThreadCell : UITableViewCell

@property (nonatomic,copy)void (^starBlock) (EvaType , NSString *);
+ (LIUEvaThreadCell *)cell;

@end
