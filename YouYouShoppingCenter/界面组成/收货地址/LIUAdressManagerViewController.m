//
//  LIUAdressManagerViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/29.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUAdressManagerViewController.h"
#import "LIUAddressTableViewCell.h"
#import "LIUAddressEditAndAddViewController.h"
#import "LIUPersonModel.h"

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
    LIURecevingAderess *address = self.personModel.recevingAddress[indexPath.row];
    [self.delegate didSelectAddress:address];
    [self backButton:nil];
    
   // self.currentAddress(address);
}

#pragma -mark celldelegate
- (void)didTapButtonCell:(LIUAddressTableViewCell *)cell {
   NSIndexPath *indexPath = [self.addressTableView indexPathForCell:cell];
    LIUAddressEditAndAddViewController *reEdit = [LIUAddressEditAndAddViewController new];
    reEdit.delegate = self;
    [self presentViewController:reEdit animated:YES completion:nil];
     [reEdit reEditAddress:self.personModel.recevingAddress[indexPath.row]];
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
    [add addAddress];
    [self presentViewController:add animated:YES completion:nil];
}

@end
