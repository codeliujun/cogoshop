//
//  LIUDisplayShoppingViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/19.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUDisplayShoppingViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "LIUDisplayTableViewCell.h"
#import "LIUShoppingDetaileViewController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUDemoData.h"
#import "LIUHeaderView.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUDisplayShoppingViewController ()<UITableViewDataSource,UITableViewDelegate,LIUHeaderViewDelegate>

//@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *displayShoppingTableView;
@property(nonatomic,strong) LIUShoppingDetaileViewController *shoppingVC;

@property(nonatomic,strong)NSMutableArray *shoppingList;//保存数据的
/**
 *  @author 刘俊, 15-07-28
 *
 *  请求数据的字段
 */
@property(nonatomic,strong)NSString *brandid;
@property(nonatomic,strong)NSString *minprice;
@property(nonatomic,strong)NSString *maxprice;
@property(nonatomic,assign)NSInteger pageindex;
@property(nonatomic,assign)NSInteger pagesize;
@property(nonatomic,assign)NSInteger orderby;


@property(nonatomic,assign)BOOL isCanLoad;

@end

@implementation LIUDisplayShoppingViewController

- (NSString *)categoryid {
    if (!_categoryid) {
        _categoryid = @"";
    }
    return _categoryid;
}

- (NSString *)keywords {
    if (!_keywords) {
        _keywords = @"";
    }
    return _keywords;
}

- (NSMutableArray *)shoppingList {
    if (!_shoppingList) {
        _shoppingList = [NSMutableArray new];
    }
    return _shoppingList;
}

-(LIUShoppingDetaileViewController *)shoppingVC {
    if (!_shoppingVC) {
        _shoppingVC = [[LIUShoppingDetaileViewController alloc]init];
    }
    return _shoppingVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.model) {
        self.titleLabel.text = self.model.name;
    }else {
        self.titleLabel.text = @"商品搜索";
    }
    
    [self resetRequestParam];
    
    [self.displayShoppingTableView registerNib:[UINib nibWithNibName:@"LIUDisplayTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
    
    [self addRefresh];
    
    
    [self addHeaderView];
    
    /**
     *  @author 刘俊, 15-07-28
     *  请求数据
     */
    
    [self getGoods];
}

- (void)resetRequestParam {//重置配置
    //配置请求的数据
    self.brandid = @"";
    self.minprice = @"0";
    self.maxprice = @"100000";
    self.pageindex = 1;
    self.pagesize = 15;
    self.orderby = 1;
    
    [self.shoppingList removeAllObjects];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)addHeaderView {
    
//    self.searchButton.layer.cornerRadius = self.searchButton.bounds.size.height*0.5;
//    self.searchButton.layer.masksToBounds = YES;
    
    LIUHeaderView *headerView = [LIUHeaderView creatHeaderViewWithItems:@[@"综合",@"销量",@"价格",@"筛选"]];
    headerView.delegate = self;
    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 40);
    self.displayShoppingTableView.tableHeaderView = headerView;
}

#pragma --mark 代理
- (void)headerViewDidSelectButtonInfo:(NSDictionary *)Info{
    [self.displayShoppingTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark 返回按钮
- (IBAction)dismissView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma --mark 二维码扫描
- (IBAction)erWeiMaSaoMiao:(id)sender {
    [SVProgressHUD showErrorWithStatus:@"该功能努力开发中" duration:1.0];
}

#pragma --mark searchButton
//- (IBAction)searchButton:(UIButton *)sender {
//    [SVProgressHUD showErrorWithStatus:@"此功能暂代确定" duration:1.0];
//}


#pragma --mark UItableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shoppingList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LIUDisplayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    LIUGoodModel *goodModel = self.shoppingList[indexPath.row];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.shopping = goodModel;
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSIndexPath *indexPath = [self.displayShoppingTableView indexPathForSelectedRow];
    [self.displayShoppingTableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96;
}

#pragma --mark cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了cell");
    
    //LIUShoppingDetaileViewController *shoppingVC = [[LIUShoppingDetaileViewController alloc]init];
    self.shoppingVC.good = self.shoppingList[indexPath.row];
    [self presentViewController:self.shoppingVC animated:YES completion:nil];
}

#pragma --mark 数据请求
- (void)getGoods {
    
    /*keywords={keywords}&categoryid={categoryid}&brandid={brandid}&minprice={minprice}&maxprice={maxprice}&pageindex={pageindex}&pagesize={pagesize}&orderby={orderby}*/
    NSDictionary *dic = @{@"keywords":self.keywords,@"categoryid":self.categoryid,@"brandid":self.brandid,@"minprice":self.minprice,@"maxprice":self.maxprice,@"pageindex":@(self.pageindex),@"pagesize":@(self.pagesize),@"orderby":@(self.orderby)};
    
    [self requestWithUrl:kSearchGoods Parameters:dic Success:^(NSDictionary *result) {
        NSMutableArray *data = [LIUGoodModel objectArrayWithKeyValuesArray:result[@"Data"]];
        
        if (data.count == 0) {
            [SVProgressHUD showSuccessWithStatus:@"没有数据" duration:2.0f];
            return ;
        }
        
        if (data.count < self.pagesize) {
            self.isCanLoad = NO;
        }else {
            self.isCanLoad = YES;
        }
        
        [self.shoppingList addObjectsFromArray:data];
        [self.displayShoppingTableView reloadData];
        [self.displayShoppingTableView.header endRefreshing];
        [self.displayShoppingTableView.footer endRefreshing];
        
        NSLog(@"%@",result);
    } Failue:^(NSDictionary *failueInfo) {
        NSLog(@"%@",failueInfo);
    }];
    
}


#pragma --mark 添加刷新空间
- (void)addRefresh {
    
    /**
     *  @author 刘俊, 15-07-29
     *
     *  1.添加头部刷新
     */
    WS(ws);
    self.displayShoppingTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [ws resetRequestParam];
        [ws getGoods];
        
    }];
    
    self.displayShoppingTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (self.isCanLoad) {
            self.pageindex++;
            [ws getGoods];
        }else {
            [SVProgressHUD showErrorWithStatus:@"再也不能加载数据了...." duration:1.5f];
            [ws.displayShoppingTableView.footer endRefreshing];
        }
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}


@end
