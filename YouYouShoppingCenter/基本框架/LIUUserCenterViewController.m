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
#import "SVProgressHUD.h"
#import "LIUShowQRCodeViewController.h"
#import "LIUZhangHuGuanLiViewController.h"
#import "LIUWillPayViewController.h"
#import "LIULoginViewController.h"
#import "UIButton+LIUBadgeButton.h"
#import "LIUUserHeaderView.h"

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
        _cellLabels = @[@"全部订单",@"账户管理",@"会员中心"];
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
    // Do any additional setup after loading the view.
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self addHeaderView];

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
                NSLog(@"待付款");
                LIUWillPayViewController *willPayVC = [[LIUWillPayViewController alloc]initWithNibName:@"LIUWillPayViewController" bundle:nil];;
                [self.navigationController pushViewController:willPayVC animated:YES];
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
                NSLog(@"待评价");
                [SVProgressHUD showErrorWithStatus:@"界面搭建需要根据api来" duration:1.0];
                break;
                
            case 1004:{
                NSLog(@"个人设置");
                [SVProgressHUD showErrorWithStatus:@"界面搭建需要根据api来" duration:1.0];
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
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3) {
        LIUShowQRCodeViewController *showVC = [LIUShowQRCodeViewController new];
        //UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:showVC];
        [self.navigationController pushViewController:showVC animated:YES];
    }else if(indexPath.row == 1) {
        LIUZhangHuGuanLiViewController *zhanghaoVC = [[LIUZhangHuGuanLiViewController alloc]initWithNibName:@"LIUZhangHuGuanLiViewController" bundle:nil];
        [self.navigationController pushViewController:zhanghaoVC animated:YES];
    }else {
        [SVProgressHUD showErrorWithStatus:@"界面搭建需要根据api来" duration:1.0];
    }
    
}

@end
