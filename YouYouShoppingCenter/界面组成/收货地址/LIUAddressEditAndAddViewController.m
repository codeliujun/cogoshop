//
//  LIUAddressEditAndAddViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUAddressEditAndAddViewController.h"

@interface LIUAddressEditAndAddViewController ()

@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UIView *downView;

@property (weak, nonatomic) IBOutlet UITextField *shouJianRenTextField;
@property (weak, nonatomic) IBOutlet UITextField *shouJiHaoTextField;
@property (weak, nonatomic) IBOutlet UITextField *xiangXiDiZhiTextField;
@property (weak, nonatomic) IBOutlet UITextField *youBianTextField;
@property(nonatomic,strong)LIURecevingAderess *oldAddress;

@property(nonatomic,assign)BOOL isAdd;

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
}

- (void)addAddress {
    self.isAdd = YES;
}
- (void)reEditAddress:(LIURecevingAderess *)address {
    self.isAdd = NO;
    self.oldAddress = address;
    self.shouJianRenTextField.text = address.Name;
    self.shouJiHaoTextField.text = address.Phone;
    self.xiangXiDiZhiTextField.text = address.FullAddress;
}

- (IBAction)quXiao:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    LIURecevingAderess *address = [LIURecevingAderess new];
    address.FullAddress = self.xiangXiDiZhiTextField.text;
    address.Name = self.shouJianRenTextField.text;
    address.Phone = self.shouJiHaoTextField.text;
    if (self.isAdd) {
        [self.delegate addSuccessAddress:address];
    }else {
        [self.delegate reEditSuccessOldAddress:self.oldAddress NewAddress:address];
    }
    [self quXiao:nil];
}


@end
