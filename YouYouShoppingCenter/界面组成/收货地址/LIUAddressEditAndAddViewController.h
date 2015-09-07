//
//  LIUAddressEditAndAddViewController.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIURecevingAderess.h"

@protocol LIUAddressEditAndAddViewControllerDelegate <NSObject>

- (void)addSuccessAddress:(LIURecevingAderess *)address;
- (void)reEditSuccessOldAddress:(LIURecevingAderess *)oldAddress NewAddress:(LIURecevingAderess *)newAddress;

@end

@interface LIUAddressEditAndAddViewController : UIViewController

@property(nonatomic,weak)id<LIUAddressEditAndAddViewControllerDelegate> delegate;

@property(nonatomic,strong)LIURecevingAderess *oldAddress;

@property(nonatomic,assign)BOOL isAdd;

@end
