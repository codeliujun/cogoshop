//
//  LIUHomeViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/17.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUHomeViewController.h"
#import "LIUHomeViewRecommendTableViewCell.h"
#import "LIUHomeCategoryCell.h"
#import "LIUSearchViewController.h"
#import "LIUScanTwoDimensionalCode.h"
#import "SVProgressHUD.h"
#import "LIUUserInfoData.h"
#import "Masonry.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface LIUHomeViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,LIUScanTwoDimensionalCodeDelegate>

@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (weak, nonatomic) IBOutlet UIView *tableHeaderViewCustom;
@property(nonatomic,strong)UIScrollView *tableHeaderScrollerView;
@property(nonatomic,strong)NSMutableArray *scrollerAllButtons;
@property(nonatomic,strong)UIPageControl *scrollerPageController;

@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)LIUScanTwoDimensionalCode *scanCodeView;

@end

@implementation LIUHomeViewController

- (NSMutableArray *)scrollerAllButtons {
    if (!_scrollerAllButtons) {
        _scrollerAllButtons = [NSMutableArray new];
    }
    return _scrollerAllButtons;
}

- (UIPageControl *)scrollerPageController {
    if (!_scrollerPageController) {
        _scrollerPageController = [[UIPageControl alloc]init];
    }
    return _scrollerPageController;
}

- (UIScrollView *)tableHeaderScrollerView {
    if (!_tableHeaderScrollerView) {
        _tableHeaderScrollerView = [[UIScrollView alloc]init];
    }
    return _tableHeaderScrollerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.homeTableView registerNib:[UINib nibWithNibName:@"LIUHomeViewRecommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell1"];
    [self.homeTableView registerNib:[UINib nibWithNibName:@"LIUHomeCategoryCell" bundle:nil] forCellReuseIdentifier:@"mycell2"];
    
    [self addRightButton];
    //这里只显示图片吧
    [self addTableHeaderViewWithGoods:@[@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片"]];
    [self itemLayout];
}

/**
 *  @author 刘俊, 15-07-28
 *
 *  添加右边的按钮
 */
- (void)addRightButton {
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightButton setTitle:@"扫描" forState:UIControlStateNormal];
    [rightButton setTitle:@"取消" forState:UIControlStateSelected];
    [rightButton addTarget:self action:@selector(scanTwoDimensionalCode:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = rightButton;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

- (void)addTableHeaderViewWithGoods:(NSArray *)goods {
    
    WS(ws);
    //配置page
    [self.tableHeaderViewCustom addSubview:self.scrollerPageController];
    [self.scrollerPageController mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.tableHeaderViewCustom.mas_bottom).with.offset(0);
        make.left.equalTo(ws.tableHeaderViewCustom);
        make.right.equalTo(ws.tableHeaderViewCustom);
        make.height.equalTo(@20);
    }];
    //self.scrollerPageController.backgroundColor = [UIColor redColor];
    self.scrollerPageController.numberOfPages = goods.count;
    self.scrollerPageController.userInteractionEnabled = NO;
    
    [self.tableHeaderViewCustom addSubview:self.tableHeaderScrollerView];
    self.tableHeaderScrollerView.pagingEnabled = YES;
    self.tableHeaderScrollerView.showsHorizontalScrollIndicator = NO;
    self.tableHeaderScrollerView.delegate = self;
    self.tableHeaderScrollerView.bounces = NO;
    
    [self.tableHeaderScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.tableHeaderViewCustom);
    }];
    
    UIView *contrain = [UIView new];
    [self.tableHeaderScrollerView addSubview:contrain];
    [contrain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.tableHeaderScrollerView);
        make.height.equalTo(ws.tableHeaderScrollerView);
    }];
    
    UIButton *lastButton = nil;
    for (int i = 0; i < goods.count; i++) {
        UIButton *button = [UIButton new];
        [button setBackgroundImage:[UIImage imageNamed:goods[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [contrain addSubview:button];
        [self.scrollerAllButtons addObject:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(ws.tableHeaderScrollerView.mas_width);
            make.height.equalTo(ws.tableHeaderScrollerView.mas_height);
            if (lastButton) {
                make.left.equalTo(lastButton.mas_right);
            }else{
                make.left.equalTo(contrain.mas_left);
            }
        }];
        lastButton = button;
    }
    
    [contrain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastButton.mas_right);
    }];
    
    [self.tableHeaderViewCustom bringSubviewToFront:self.scrollerPageController];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/self.tableHeaderViewCustom.bounds.size.width;
    self.scrollerPageController.currentPage = index;
}

- (void)tapButton:(UIButton *)sender {
    NSLog(@"dianjile");
    LIUUserInfoData *user = [LIUUserInfoData defaultUserInfo];
    NSLog(@"%@",user);
}

#pragma --mark 界面元素的布局
- (void)itemLayout {
    //搜索按钮
    self.searchButton.layer.cornerRadius = self.searchButton.bounds.size.height*0.5;
    self.searchButton.layer.masksToBounds = YES;
    
}
#pragma --mark 搜索商品点击
- (IBAction)searchShopping:(UIButton *)sender {
    LIUSearchViewController *searchController = [LIUSearchViewController new];
    [self presentViewController:searchController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger row = 1;
    if (1 == section) {
        row = 10;
    }
    
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        LIUHomeViewRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.recommends = @[@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片"];
        cell.buttonTap = ^{
            /**
             *  @author 刘俊, 15-07-27
             *
             *  点击了更多的按钮
             */
        };
        return cell;
    }else {
        LIUHomeCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell2" forIndexPath:indexPath];
        return cell;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = nil;
    if (1 == section) {
        view = [UIView new];
        UIView *leftView = [UIView new];
        leftView.backgroundColor = [UIColor greenColor];
        [view addSubview:leftView];
        [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view).with.offset(5);
            make.width.equalTo(@6);
            make.height.equalTo(@30);
            make.left.equalTo(view.mas_left).with.offset(0);
        }];
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:15.f];
        label.text = @"商品分类";
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView.mas_right).with.offset(5);
            make.centerY.equalTo(leftView);
            make.width.equalTo(@71);
            make.height.equalTo(@31);
        }];
        
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CGFloat height = 10;
    if (1 == section) {
        height = 40;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 80.f;
    
    if (0 == indexPath.section) {
        height = 200.f;
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = nil;
    if (1 == section) {
        view = [UIView new];
    }
    return view;
}

#pragma --mark 扫描二维码
- (void)scanTwoDimensionalCode:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    if (!self.scanCodeView) {
        self.scanCodeView = [[LIUScanTwoDimensionalCode alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [self.view addSubview:self.scanCodeView];
        [self.scanCodeView start];
        self.scanCodeView.delegate = self;
    }else {
        [self.scanCodeView removeFromSuperview];
        self.scanCodeView = nil;
    }
    
}

- (void)scanSuccess:(NSString *)str AndScanObj:(LIUScanTwoDimensionalCode *)obj {
    [obj removeFromSuperview];
    self.rightButton.selected = !self.rightButton.isSelected;
    self.scanCodeView = nil;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:str delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
}



@end
