//
//  LIUUserInfoController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/6.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//we

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUUserInfoController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "SVProgressHUD.h"
#import "LIURecevingAderess.h"
#import "MJExtension.h"
#import "LIUAdressManagerViewController.h"
#import "LIUChangePassWordController.h"

@interface LIUUserInfoController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *addressArray;

@end

@implementation LIUUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息修改";
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *index = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:index animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (0 == indexPath.section) {
        cell.textLabel.text = @"收货地址";
        cell.detailTextLabel.text = @"编辑，修改";
    }
    
    if (1 == indexPath.section) {
        cell.textLabel.text = @"修改密码";
        //cell.detailTextLabel.text = @"编辑，修改";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        [self getAddressData];
    }else {
        LIUChangePassWordController *controller = [[LIUChangePassWordController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)getAddressData {
    WS(ws);
    //获取收货地址 //pageindex={pageindex}&pagesize={pagesize}
    [self requestWithUrl:kGetAddressList Parameters:@{@"pageindex":@1,@"userid":[self getUserId],@"pagesize":@20} Success:^(NSDictionary *result) {
        NSArray *arr = result[@"Data"];
        if (arr.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"地址获取失败" duration:1.5f];
            return ;
        }
        
        ws.addressArray = [LIURecevingAderess objectArrayWithKeyValuesArray:result[@"Data"]];
        [ws changeRecevingAdress];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
}

- (void)changeRecevingAdress {
    LIUAdressManagerViewController *addressVC = [LIUAdressManagerViewController new];
    addressVC.addressArray = self.addressArray;
    //addressVC.delegate = self;
    [self presentViewController:addressVC animated:YES completion:nil];
}


@end
