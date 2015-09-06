//
//  LIUUserCenterViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/25.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUUserCenterViewController.h"
#import "LIUUserCenterTableViewCell.h"
#import "LIUPersonModel.h"
#import "LIUUserInfoData.h"
#import "LIUNewUserCenter.h"
#import "SVProgressHUD.h"
#import "Masonry.h"
#import "LIUShowQRCodeViewController.h"
#import "LIUZhangHuGuanLiViewController.h"
#import "LIUWillPayViewController.h"
#import "LIULoginViewController.h"
#import "UIButton+LIUBadgeButton.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUUserHeaderView.h"

#import "LIUOrderListController.h"
#import "LIUSettingController.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUUserCenterViewController ()<UITableViewDataSource,UITableViewDelegate,LIUUserHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *userCenterTableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;


//cell的内容和配置
@property(nonatomic,strong)NSArray *cellLabels;
@property(nonatomic,strong)NSArray *cellIcons;

@end

@implementation LIUUserCenterViewController

- (NSArray *)cellLabels {
    if (!_cellLabels) {
        _cellLabels = @[@"全部订单",@"会员中心",@"我的二维码"];
    }
    return _cellLabels;
}
- (NSArray *)cellIcons {
    if (!_cellIcons) {
        _cellIcons = @[@"icon_my_order",@"icon_account",@"icon_vip",@"wei_icon_view"];
    }
    return _cellIcons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.userCenterTableView.bounces = NO;
    [self.userCenterTableView registerNib:[UINib nibWithNibName:@"LIUUserCenterTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
    [self addRightButton];
    // Do any additional setup after loading the view.
    
}

- (void)addRightButton {
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [button setBackgroundImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tapSetting:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)tapSetting:(UIButton *)sender{
    LIUSettingController *controller = [[LIUSettingController alloc]init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self addHeaderView];
    [self.userCenterTableView reloadData];
}

//添加头视图
- (void)addHeaderView {
    
    LIUUserHeaderView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"LIUUserHeaderView" owner:nil options:nil] lastObject];
    [headerView updateHeaderView];
    headerView.delegate = self;
    headerView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 180);
    [self.view addSubview:headerView];
    
}

- (void)loginView {
    LIULoginViewController *loginVC = [LIULoginViewController shareLoginViewController];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [self presentViewController:navi animated:YES completion:nil];
}

#pragma --mark LIUUserHeaderViewDelegate
- (void)headerViewDidTapButton:(UIButton *)sender {
    
    if (sender.tag == 1005) {
        [self loginView];
    }else {
        //判断是否登陆
        if ([LIUUserInfoData defaultUserInfo].Id == nil) {
            [self loginView];
            return;
        }
        [sender setBadgeValue:0 TextColor:nil BackGroundColor:nil];
        switch (sender.tag) {
            case 1000:
            {
                LIUOrderListController *controller = [[LIUOrderListController alloc]init];
                controller.showTitle = @"待付款";
                controller.status = OrderStatussWillPay;
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
                break;
            }
                break;
                
            case 1001://没有了
                NSLog(@"待发货");
                [SVProgressHUD showErrorWithStatus:@"界面搭建需要根据api来" duration:1.0];
                break;
            case 1002://没有了
                NSLog(@"待收货");
                [SVProgressHUD showErrorWithStatus:@"界面搭建需要根据api来" duration:1.0];
                break;
            
            case 1003:
            {
                LIUOrderListController *controller = [[LIUOrderListController alloc]init];
                controller.showTitle = @"待评价";
                controller.status = OrderStatusEve;
                controller.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
                
            case 1004:{
                NSLog(@"个人设置");
                [SVProgressHUD showErrorWithStatus:@"界面搭建需要根据来" duration:1.0];
            }
                break;
        }
    }
}


#pragma --mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellLabels.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LIUUserCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.cellIcon.image = [UIImage imageNamed:self.cellIcons[indexPath.row]];
    cell.cellLabel.text = self.cellLabels[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = nil;
    if ([[self getUserId] isEqualToString:@""]) {
        view  = [UIView new];
        view.backgroundColor = [UIColor clearColor];
    }else {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
        view.backgroundColor = [UIColor whiteColor];
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"退出" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor redColor]];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view).insets(UIEdgeInsetsMake(30, 20, 0, 20));
        }];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 70.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        LIUShowQRCodeViewController *showVC = [LIUShowQRCodeViewController new];
        showVC.hidesBottomBarWhenPushed = YES;
        //UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:showVC];
        [self.navigationController pushViewController:showVC animated:YES];
    }else if(indexPath.row == 1) {
//        LIUZhangHuGuanLiViewController *zhanghaoVC = [[LIUZhangHuGuanLiViewController alloc]initWithNibName:@"LIUZhangHuGuanLiViewController" bundle:nil];
//        zhanghaoVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:zhanghaoVC animated:YES];
        LIUNewUserCenter *controller = [[LIUNewUserCenter alloc]init];
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else if(indexPath.row == 0) {
        LIUOrderListController *controller = [[LIUOrderListController alloc]init];
        controller.status = OrderStatusAll;
        controller.showTitle = @"全部订单";
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else {
        [SVProgressHUD showErrorWithStatus:@"界面搭建需要根据api来" duration:1.0];
    }
    
}

- (void)logOut:(UIButton *)sender {
        
        WS(ws);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认退出" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            [LIUUserInfoData logOut];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"userName"];
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"passWord"];
            [ws viewWillAppear:YES];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
}

@end
