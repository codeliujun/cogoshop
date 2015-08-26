//
//  LIULoginViewController.h
//  Gongyinglian
//
//  Created by 刘俊 on 15/6/12.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LIULoginViewControllerDelegate <NSObject>

- (void)didLoging;

@end

@interface LIULoginViewController : UIViewController

@property (nonatomic,weak)id<LIULoginViewControllerDelegate> delegate;

+ (LIULoginViewController *)shareLoginViewController;

@end
