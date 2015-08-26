//
//  LIUAdressManagerViewController.h
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LIURecevingAderess.h"

@protocol LIUAdressManagerViewControllerDelegate <NSObject>

- (void)didSelectAddress:(LIURecevingAderess *)address;

@end

@interface LIUAdressManagerViewController : UIViewController

@property(nonatomic,weak)id<LIUAdressManagerViewControllerDelegate> delegate;
@property (nonatomic,strong)NSArray *addressArray;


@end
