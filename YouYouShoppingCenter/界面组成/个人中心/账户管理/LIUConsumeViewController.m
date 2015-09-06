//
//  LIUConsumeViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/6.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUConsumeViewController.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "LIUConsumeCell.h"
#import "UIViewController+GetHTTPRequest.h"

@interface LIUConsumeViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataList;

@property (nonatomic,assign)NSInteger   pageindex;
@property (nonatomic,assign)BOOL isCanLoad;

@end

@implementation LIUConsumeViewController

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSArray new].mutableCopy;
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消费记录";
    self.pageindex = 1;
    [self addFootRefresh];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LIUConsumeCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([LIUConsumeCell class])];
    [self getdata];
    // Do any additional setup after loading the view from its nib.
}

- (void)addFootRefresh {
    WS(ws);
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.isCanLoad) {
            self.pageindex++;
            [ws getdata];
        }else {
            [SVProgressHUD showErrorWithStatus:@"再也不能加载数据了...." duration:1.5f];
            [ws.tableView.footer endRefreshing];
        }
    }];
    
}

- (void)getdata {
    WS(ws);
    /*userid={userid}&pageindex={pageindex}&pagesize={pagesize}&begintime={begintime}&endtime={endtime}*/
    [self requestWithUrl:kGetAccountings Parameters:@{@"userid":[self getUserId],
                                                      @"pageindex":@(self.pageindex),
                                                      @"pagesize":@20,
                                                      @"begintime":@"",
                                                      @"endtime":@"",
    } Success:^(NSDictionary *result) {
        NSArray *arr = result[@"Data"];
        if (arr.count < 20) {
            ws.isCanLoad = NO;
        }else {
            ws.isCanLoad = YES;
        }
        [ws.dataList addObjectsFromArray:arr];
        [ws.tableView reloadData];
    } Failue:^(NSDictionary *failueInfo) {
                                                          
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LIUConsumeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LIUConsumeCell class]) forIndexPath:indexPath];
    cell.comsumer = self.dataList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

@end
