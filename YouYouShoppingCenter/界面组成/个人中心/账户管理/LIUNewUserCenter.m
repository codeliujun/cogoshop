//
//  LIUNewUserCenter.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/5.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUNewUserCenter.h"
#import "LIUSaveMoneyController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUNewUseCell.h"
#import "LIUUserInfoData.h"

@interface LIUNewUserCenter ()<UITableViewDelegate,UITableViewDataSource,LIUNewUseCellDelegate> {
    LIUNewUseCell   *_cell1;
    LIUNewUseCell   *_cell2;
    LIUNewUseCell   *_cell3;
    LIUNewUseCell   *_cell4;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)LIUUserInfoData *infoData;

@end

@implementation LIUNewUserCenter

- (LIUUserInfoData *)infoData {
    if (!_infoData) {
        _infoData = [LIUUserInfoData defaultUserInfo];
    }
    return _infoData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //更新用户数据
    
    [self initCell];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)getData {
    WS(ws);
    [self requestWithUrl:kUpdateUserInfo Parameters:@{@"userid":[self getUserId],@"name":self.infoData.lastname} Success:^(NSDictionary *result) {
        ws.infoData.Balance = result[@"Data"][@"Balance"];
        [ws upDateCell];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
}

- (void)initCell {
    
    _cell1 = [LIUNewUseCell cell];
    
    _cell2 = [LIUNewUseCell cell];
    
    
    _cell3 = [LIUNewUseCell cell];
   
    
    _cell4 = [LIUNewUseCell cell];
    
    [self upDateCell];
}

- (void)upDateCell {
  
    [_cell1 setCellTitle:@"账户余额："];
    [_cell1 setCellButtonTitle:@"充值"];
    _cell1.delegate = self;
    [_cell1 setCellStatu:self.infoData.Balance];
    
    [_cell2 setCellTitle:@"会员积分："];
    _cell2.delegate = self;
    [_cell2 setCellStatu:self.infoData.Code];
    [_cell2 setCellButtonTitle:@"消费记录"];
    
    [_cell3 hiddenButton];
    [_cell3 setCellTitle:@"会员状态："];
    [_cell3 setCellStatu:@"正常"];
    
    [_cell4 hiddenButton];
    [_cell4 setCellTitle:@"会员级别："];
    UIImage *image = nil;
    NSInteger leave = [self.infoData.Level integerValue];
    switch (leave) {
        case 0:
            image = [UIImage imageNamed:@"cust_level_normal"];
            break;
        case 1:
            image = [UIImage imageNamed:@"cust_level_silver"];
            break;
        case 2:
            image = [UIImage imageNamed:@"cust_level_platinum"];
            break;
        case 3:
            image = [UIImage imageNamed:@"cust_level_gold"];
            break;
        default:
            break;
    }
    [_cell4 setStatuImage:image];
    
}

- (void)didTapButton:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"充值"]) {
        LIUSaveMoneyController *controller = [[LIUSaveMoneyController alloc]init];
        
        [self.navigationController pushViewController:controller animated:YES];
    }else {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (0 == indexPath.row) {
        cell = _cell1;
    }
    
    if (1 == indexPath.row) {
        cell = _cell2;
    }
    
    if (2 == indexPath.row) {
        cell = _cell3;
    }
    
    if (3 == indexPath.row) {
        cell = _cell4;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

@end
