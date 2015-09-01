//
//  LIUAddressEditAndAddViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUAddressEditAndAddViewController.h"
#import "UIViewController+GetHTTPRequest.h"

@interface LIUAddressEditAndAddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *areaTextField;
@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UIView *downView;

@property (weak, nonatomic) IBOutlet UITextField *shouJianRenTextField;
@property (weak, nonatomic) IBOutlet UITextField *shouJiHaoTextField;
@property (weak, nonatomic) IBOutlet UITextField *xiangXiDiZhiTextField;
@property (weak, nonatomic) IBOutlet UITextField *youBianTextField;
@property(nonatomic,strong)LIURecevingAderess *oldAddress;

@property(nonatomic,assign)BOOL isAdd;

@property (nonatomic,assign)BOOL isDefault;

@end

@implementation LIUAddressEditAndAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.upView.layer.cornerRadius = 5;
    self.upView.layer.masksToBounds = YES;
    self.upView.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.upView.layer.borderWidth = 1.0;
    
    self.downView.layer.cornerRadius = 5;
    self.downView.layer.masksToBounds = YES;
    self.downView.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.downView.layer.borderWidth = 1.0;
    
    self.shouJianRenTextField.text = self.oldAddress.Name;
    self.shouJiHaoTextField.text = self.oldAddress.Phone;
    self.xiangXiDiZhiTextField.text = self.oldAddress.FullAddress;
    
}

- (void)addAddress {
    self.isAdd = YES;
}

- (void)reEditAddress:(LIURecevingAderess *)address {
    self.isAdd = NO;
    self.oldAddress = address;
}

- (IBAction)quXiao:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    
    /*
     userid={userid}&fullname={fullname}&provinceid={provinceid}&cityid={cityid}&areaid={areaid}&address={address}&zipcode={zipcode}&telephone={telephone}&mobile={mobile}&email={email}&alias={alias}&isdefault={isdefault}
     */
    if (self.isAdd) {
        
        [self requestWithUrl:kAddAddress Parameters:@{
                    @"userid":[self getUserId],
                    @"fullname":self.xiangXiDiZhiTextField.text,
                    @"provinceid":@"",
                    @"provinceid":@"",
                    @"cityid":@"",
                    @"areaid":@"",
                    @"address":@"",
                    @"zipcode":@"",
                    @"telephone":self.shouJiHaoTextField.text,
                    @"mobile":self.shouJiHaoTextField.text,
                    @"email":@"",
                    @"alias":@"",
                    @"isdefault":self.isDefault?@"1":@"0",
                    } Success:^(NSDictionary *result) {
                        NSLog(@"%@",result);
        } Failue:^(NSDictionary *failueInfo) {
            
        }];
        
    }
    else {
        [self requestWithUrl:kUpdataAddress Parameters:@{
                    @"userid":[self getUserId],
                    @"fullname":self.xiangXiDiZhiTextField.text,
                    @"provinceid":@"",
                    @"provinceid":@"",
                    @"cityid":@"",
                    @"areaid":@"",
                    @"address":@"",
                    @"zipcode":@"",
                    @"telephone":self.shouJiHaoTextField.text,
                    @"mobile":self.shouJiHaoTextField.text,
                    @"email":@"",
                    @"alias":@"",
                    @"isdefault":self.isDefault?@"1":@"0",
                } Success:^(NSDictionary *result) {
                    NSLog(@"%@",result);
                } Failue:^(NSDictionary *failueInfo) {
                    
                }];
        
    }
    
}
- (IBAction)default:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.isDefault = sender.isSelected;
}


@end
