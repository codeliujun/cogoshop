//
//  LIUAdressManagerViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

#import "LIUAdressManagerViewController.h"
#import "LIUAddressTableViewCell.h"
#import "LIUAddressEditAndAddViewController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUPersonModel.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"

@interface LIUAdressManagerViewController ()<UITableViewDataSource,UITableViewDelegate,LIUAddressTableViewCellDelegate,LIUAddressEditAndAddViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *addressTableView;
@property(nonatomic,strong)LIUPersonModel *personModel;
@property(nonatomic,assign)BOOL isEdit;
@property (weak, nonatomic) IBOutlet UIButton *addAddressButton;

@end

@implementation LIUAdressManagerViewController

- (LIUPersonModel *)personModel {
    if (!_personModel) {
        _personModel = [LIUPersonModel defaultUser];
    }
    return _personModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isEdit = NO;
    self.addAddressButton.layer.cornerRadius = 5;
    self.addAddressButton.layer.masksToBounds = YES;
    [self.addressTableView registerNib:[UINib nibWithNibName:@"LIUAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getData];
}

- (void)getData {
    WS(ws);
    [self requestWithUrl:kGetAddressList Parameters:@{@"pageindex":@1,@"userid":[self getUserId],@"pagesize":@20} Success:^(NSDictionary *result) {
        NSArray *arr = result[@"Data"];
        if (arr.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"地址获取失败" duration:1.5f];
            return ;
        }
        ws.addressArray = [LIURecevingAderess objectArrayWithKeyValuesArray:arr];
        [ws.addressTableView reloadData];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LIUAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    cell.isEdit = self.isEdit;
    cell.address = self.addressArray[indexPath.row];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LIURecevingAderess *address = self.addressArray[indexPath.row];
    [self.delegate didSelectAddress:address];
    [self backButton:nil];
    
   // self.currentAddress(address);
}

#pragma -mark celldelegate
- (void)didTapButtonCell:(LIUAddressTableViewCell *)cell {
   NSIndexPath *indexPath = [self.addressTableView indexPathForCell:cell];
    LIUAddressEditAndAddViewController *reEdit = [LIUAddressEditAndAddViewController new];
    //[reEdit reEditAddress:self.addressArray[indexPath.row]];
    reEdit.isAdd = NO;
    reEdit.oldAddress = self.addressArray[indexPath.row];
    reEdit.delegate = self;
    [self presentViewController:reEdit animated:YES completion:nil];
    
}

#pragma --mark addOrEditDelegate
- (void)addSuccessAddress:(LIURecevingAderess *)address {
    [self.personModel.recevingAddress addObject:address];
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:self.personModel.recevingAddress.count-1 inSection:0];
    [self.addressTableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationBottom];
}
- (void)reEditSuccessOldAddress:(LIURecevingAderess *)oldAddress NewAddress:(LIURecevingAderess *)newAddress{
    NSInteger index = [self.personModel.recevingAddress indexOfObject:oldAddress];
    [self.personModel.recevingAddress replaceObjectAtIndex:index withObject:newAddress];
    [self.addressTableView reloadData];
}

- (IBAction)editButton:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    self.isEdit = !self.isEdit;
    [self.addressTableView reloadData];
}

- (IBAction)backButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addNewAddress:(UIButton *)sender {
    LIUAddressEditAndAddViewController *add = [LIUAddressEditAndAddViewController new];
    add.delegate = self;
    add.isAdd = YES;
    [self presentViewController:add animated:YES completion:nil];
}

@end
