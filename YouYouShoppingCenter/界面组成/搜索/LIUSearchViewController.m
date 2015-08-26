//
//  LIUSearchViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/18.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUSearchViewController.h"
#import "LIUDisplayShoppingViewController.h"
#import "Masonry.h"
#import "XKYSearchVCRecommendTableHeaderView.h"
#import "UIViewController+GetHTTPRequest.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#define kThemClolor     [UIColor colorWithRed:105/256.0 green:34/256.0 blue:56/256.0 alpha:1]

@interface LIUSearchViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property(nonatomic,assign)BOOL isEmpty;
@property (weak, nonatomic) IBOutlet UITableView *showTableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UIView *headerView;


@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LIUSearchViewController

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    
    [self.showTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mycell"];
    
    //配置searchView
    self.searchView.layer.cornerRadius = 3.0;
    self.searchView.layer.masksToBounds = YES;
    [self.searchTextField becomeFirstResponder];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    //添加头视图
    [self getHotKey];
}

- (void)getData {
    self.isEmpty = YES;
    self.dataSource = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchHistory"];
}

#pragma 获取数据
- (void)getHotKey {
    WS(ws);
    [self requestWithUrl:kGetHotVocabulary Parameters:nil Success:^(NSDictionary *result) {
        ws.dataArray = result[@"Data"];
        [ws addTableHeaderView];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
}


#pragma --mark 设置搜索的头视图
- (void)addTableHeaderView {
    
    XKYSearchVCRecommendTableHeaderView *headerViewWitXib = [[[NSBundle mainBundle]loadNibNamed:@"XKYSearchVCRecommendTableHeaderView" owner:nil options:nil] lastObject];
    /**
     * 设置headerView的值 并设置返回的值
     */
    
   
    
    [headerViewWitXib setRecommendDataWithDataArray:self.dataArray andDidTapBlock:^(NSInteger index) {
        NSDictionary *dic = self.dataArray[index];
        self.searchTextField.text = dic[@"Key"];
    }];
    
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 132)];
    self.headerView.backgroundColor = [UIColor clearColor];
    [self.headerView addSubview:headerViewWitXib];
    WS(ws);
    [headerViewWitXib mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.headerView);
    }];
    
    self.showTableView.tableHeaderView = self.headerView;
}


#pragma --mark 返回按钮
- (IBAction)goBack:(UIButton *)sender {
    [self.searchTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma --mark 监听textField的变化
- (void)textDidChange:(NSNotification *)notification {
    //如果textField为空的话，就显示历史记录
    NSLog(@"%@",self.searchTextField.text);
    if ([self.searchTextField.text isEqualToString:@""]) {
        self.isEmpty = YES;
        self.dataSource = [[NSUserDefaults standardUserDefaults] objectForKey:@"searchHistory"];
        /**
         * @author 刘俊, 15-07-06
         *
         * 监测变化，没有搜索的时候就要显示推荐页面
         */
        self.showTableView.tableHeaderView = self.headerView;
        self.showTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.showTableView reloadData];
    }else{
        //在这里发网络请求，找到与之匹配的再显示
        self.isEmpty = NO;
        self.dataSource = [@[@"假数据",@"假数据",@"假数据",@"假数据",@"假数据",@"假数据"] mutableCopy];
        
        /**
         * @author 刘俊, 15-07-06
         *
         * 监测变化，当搜索的时候就要隐藏推荐页面
         */
        self.showTableView.tableHeaderView = nil;
        self.showTableView.contentInset = UIEdgeInsetsMake(-33, 0, 0, 0);
        [self.showTableView reloadData];
    }
    
}

#pragma --mark 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isEmpty) {
        return self.dataSource.count;
    }else{
        return self.dataSource.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (self.isEmpty) {
        self.searchTextField.text = self.dataSource[indexPath.row];
    }else {
        self.searchTextField.text = self.dataSource[indexPath.row];
    }
    [self searchData];
}

/**
 * @author 刘俊, 15-07-06
 *
 * 清除历史记录按钮
 */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.isEmpty&&self.dataSource.count!=0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
        view.backgroundColor = [UIColor whiteColor];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((self.view.bounds.size.width-200)*0.5, 10, 200, 30)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:@"清除历史记录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:kThemClolor];
        [button addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 5.0;
        button.layer.masksToBounds = YES;
        [view addSubview:button];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    if (self.isEmpty) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"icon_wait_4_assessment"];
        [view addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.centerX.equalTo(view);
            make.height.equalTo(@100);
            make.width.equalTo(@100);
        }];
        return view;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //    if (self.isEmpty) {
    //        return 50.f;
    //    }else{
    //        return 110.f;
    //    }
    return 300.f;
}


/**
 * @author 刘俊, 15-07-06
 *
 * 配置headerView
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isEmpty) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 200, 23)];
        label.text = @"历史搜索";
        label.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
        label.textColor = kThemClolor;
        [view addSubview:label];
        return view;
    }else {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 200, 23)];
        label.text = @"搜索结果";
        label.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
        label.textColor = kThemClolor;
        [view addSubview:label];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 33.0f;
}

#pragma --mark cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.searchTextField.text = self.dataSource[indexPath.row];
    [self searchData];
}

#pragma --mark 搜索网上数据
- (void)searchData {
    //1.将本次搜索保存到本地
    NSMutableSet *localData = nil;
    NSMutableArray *array = [[NSUserDefaults standardUserDefaults]objectForKey:@"searchHistory"];
    if (array == nil) {
        localData = [NSMutableSet new];
    }else{
        localData = [[NSMutableSet alloc]initWithArray:array];
    }
    //为了防止重复输入，先把原来的都移除掉,转变为set再添加
    [localData addObject:self.searchTextField.text];
    
    NSMutableArray *local = [[localData allObjects] mutableCopy];
    [[NSUserDefaults standardUserDefaults]setObject:local forKey:@"searchHistory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //2.拿到数据到网上请求，获取结果后，跳转到商品展示界面
    [self segueToDisplayViewWithData:nil];
}

#pragma --mark 跳转到商品展示界面
- (void)segueToDisplayViewWithData:(NSArray*)data {
    
    LIUDisplayShoppingViewController *disVC = [LIUDisplayShoppingViewController new];
    disVC.keywords = self.searchTextField.text;
    [self presentViewController:disVC animated:YES completion:nil];
    
}

#pragma --mark 搜索按钮
- (IBAction)search:(UIButton *)sender {
    [self searchData];
}

#pragma --mark 移除本地数据
- (void)removeLocalDataWithKey:(NSString *)str {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:str];
    [self getData];
    [self.showTableView reloadData];
}
- (void)clearHistory:(UIButton *)sener {
    [self removeLocalDataWithKey:@"searchHistory"];
}

@end
