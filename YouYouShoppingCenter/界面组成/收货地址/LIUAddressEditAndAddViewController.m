//
//  LIUAddressEditAndAddViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#define TEXT_IS_NIL(string) ([string isEqualToString:@""] || [string isEqual:[NSNull null]] || string == nil)

#import "LIUAddressEditAndAddViewController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "SVProgressHUD.h"
#import "LIUChooseArea.h"

@interface LIUAddressEditAndAddViewController ()

@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UIView *downView;

@property (weak, nonatomic) IBOutlet UITextField *shouJianRenTextField;
@property (weak, nonatomic) IBOutlet UITextField *shouJiHaoTextField;
@property (weak, nonatomic) IBOutlet UITextField *xiangXiDiZhiTextField;
@property (weak, nonatomic) IBOutlet UITextField *youBianTextField;
@property(nonatomic,strong)LIURecevingAderess *oldAddress;

@property(nonatomic,assign)BOOL isAdd;
@property (nonatomic,assign)BOOL isDefault;
@property (weak, nonatomic) IBOutlet UIButton *defaultButton;


//属性
/*
 userid={userid}&fullname={fullname}&provinceid={provinceid}&cityid={cityid}&areaid={areaid}&address={address}&zipcode={zipcode}&telephone={telephone}&mobile={mobile}&email={email}&alias={alias}&isdefault={isdefault}
 */
@property(nonatomic,strong)NSString *fullname;
@property(nonatomic,strong)NSString *provinceid;
@property(nonatomic,strong)NSString *cityid;
@property(nonatomic,strong)NSString *areaid;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *zipcode;
@property(nonatomic,strong)NSString *telephone;
@property(nonatomic,strong)NSString *mobile;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *alias;
@property(nonatomic,strong)NSString *isdefault;



- (IBAction)chooseArea:(UIButton *)sender;

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
  
    if (self.oldAddress) {
        self.shouJianRenTextField.text = self.oldAddress.Name;
        self.shouJiHaoTextField.text = self.oldAddress.Phone;
        self.xiangXiDiZhiTextField.text = self.oldAddress.DetailAddress;
        self.youBianTextField.text = self.oldAddress.PostalCode;
        self.defaultButton.selected = self.oldAddress.IsDefault;
        self.areaLabel.text = [NSString stringWithFormat:@"%@,%@,%@",self.oldAddress.ProvinceName,self.oldAddress.CityName,self.oldAddress.AreaName];
        self.provinceid = self.oldAddress.ProvinceId;
        self.cityid = self.oldAddress.CityId;
        self.areaid = self.oldAddress.AreaId;
    }
    
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
    
    WS(ws);
    /*
     userid={userid}&fullname={fullname}&provinceid={provinceid}&cityid={cityid}&areaid={areaid}&address={address}&zipcode={zipcode}&telephone={telephone}&mobile={mobile}&email={email}&alias={alias}&isdefault={isdefault}
     */
    self.fullname = self.shouJianRenTextField.text;
    self.mobile = self.shouJiHaoTextField.text;
    self.address = self.xiangXiDiZhiTextField.text;
    self.zipcode = self.youBianTextField.text;
    self.telephone = self.shouJiHaoTextField.text;
    self.alias = @"";
    self.email = @"";
    self.isdefault = self.isDefault?@"1":@"0";
    
    if (TEXT_IS_NIL(self.fullname)) {
        [SVProgressHUD showErrorWithStatus:@"请输入收件人" duration:1.5f];
        return;
    }
    
    if (TEXT_IS_NIL(self.mobile)) {
        [SVProgressHUD showErrorWithStatus:@"请填写手机号码" duration:1.5f];
        return;
    }
    
    if (TEXT_IS_NIL(self.address)) {
        [SVProgressHUD showErrorWithStatus:@"请填写详细地址" duration:1.5f];
        return;
    }
    
    if (TEXT_IS_NIL(self.zipcode)) {
        [SVProgressHUD showErrorWithStatus:@"请填写邮编" duration:1.5f];
        return;
    }
    
    /*
     userid={userid}&fullname={fullname}&provinceid={provinceid}&cityid={cityid}&areaid={areaid}&address={address}&zipcode={zipcode}&telephone={telephone}&mobile={mobile}&email={email}&alias={alias}&isdefault={isdefault}
     */
    if (self.isAdd) {
        
        [self requestWithUrl:kAddAddress Parameters:@{
                    @"userid":[self getUserId],
                    @"fullname":self.fullname,
                    @"provinceid":self.provinceid,
                    @"cityid":self.cityid,
                    @"areaid":self.areaid,
                    @"address":self.address,
                    @"zipcode":self.zipcode,
                    @"telephone":self.telephone,
                    @"mobile":self.mobile,
                    @"email":self.email,
                    @"alias":self.alias,
                    @"isdefault":self.isdefault,
                    } Success:^(NSDictionary *result) {
                        NSLog(@"%@",result);
                        if (ws.navigationController == nil) {
                            [ws dismissViewControllerAnimated:YES completion:nil];
                        }else {
                            [ws.navigationController popViewControllerAnimated:YES];
                        }
        } Failue:^(NSDictionary *failueInfo) {
            
        }];
        
    }
    else {
        [self requestWithUrl:kUpdataAddress Parameters:@{
                    @"userid":[self getUserId],
                    @"fullname":self.fullname,
                    @"provinceid":self.provinceid,
                    @"cityid":self.cityid,
                    @"areaid":self.areaid,
                    @"address":self.address,
                    @"zipcode":self.zipcode,
                    @"telephone":self.telephone,
                    @"mobile":self.mobile,
                    @"email":self.email,
                    @"alias":self.alias,
                    @"isdefault":self.isdefault,
                } Success:^(NSDictionary *result) {
                    NSLog(@"%@",result);
                } Failue:^(NSDictionary *failueInfo) {
                    
                }];
        
    }
    
}
- (IBAction)IsDefault:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.isDefault = sender.isSelected;
}

- (IBAction)chooseArea:(UIButton *)sender {
    WS(ws);
    LIUChooseArea *chooseArea = [[LIUChooseArea alloc]init];
    chooseArea.currentArreaType = AreaTypeProvince;
    chooseArea.provinceid = @"";
    chooseArea.cityid = @"";
    chooseArea.areaTitle = @"城市选择";
    chooseArea.chooseAreaBlock = ^(NSDictionary *dic) {
        [ws updateAreaLabelwith:dic];
        NSLog(@"%@",dic);
    };
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:chooseArea];
//    [self.navigationController pushViewController:chooseArea animated:YES];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)updateAreaLabelwith:(NSDictionary *)dic {
    
    NSDictionary *dic1 = dic[@"province"];
    NSDictionary *dic2 = dic[@"city"];
    NSDictionary *dic3 = dic[@"area"];
    self.provinceid = dic1[@"Id"];
    self.cityid = dic2[@"Id"];
    self.areaid = dic3[@"Id"];

    
    NSString *areaStr = [NSString stringWithFormat:@"%@,%@,%@",dic1[@"Name"],dic2[@"Name"],dic3[@"Name"]];
    self.areaLabel.text = areaStr;
}

@end
