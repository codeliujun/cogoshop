//
//  LIUViewController.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/10/10.
//  Copyright © 2015年 刘俊. All rights reserved.
//

#import "LIUChageNumberController.h"
#import "LIUGoodCell.h"
#import "LIUChangeNumberCell.h"

@interface LIUChageNumberController () <UITableViewDataSource,UITableViewDelegate> {
    LIUGoodCell             *_cell1;
    LIUChangeNumberCell     *_cell2;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LIUChageNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadCell];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadCell {
    
    _cell1 = [LIUGoodCell cell];
    _cell1.good = self.good;
    
    _cell2 = [LIUChangeNumberCell cell];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma -- mark Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (0 == indexPath.row) {
        cell = _cell1;
    }
    
    if (1 == indexPath.row) {
        cell = _cell2;
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 44.f;
    
    if (0 == indexPath.row) {
        height = 88.f;
    }
    if (1 == indexPath.row) {
        height = 60.f;
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
