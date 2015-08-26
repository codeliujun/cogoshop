//
//  LIUScanTwoDimensionalCode.h
//  YouYouShoppingCenter
//
//  Created by liujun on 15/7/28.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void (^SuccessBlock) (NSString *str);

@class LIUScanTwoDimensionalCode;

@protocol LIUScanTwoDimensionalCodeDelegate <NSObject>

- (void)scanSuccess:(NSString *)str AndScanObj:(LIUScanTwoDimensionalCode *)obj;

@end

@interface LIUScanTwoDimensionalCode : UIView

- (void)startScanSuccess:(SuccessBlock)successBlock;
- (void)start;
- (void)dismiss;

@property (nonatomic,weak)id<LIUScanTwoDimensionalCodeDelegate> delegate;

@end
