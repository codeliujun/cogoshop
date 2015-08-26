
//
//  LIUCategoryViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/17.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUCategoryViewController.h"
#import "LIUCategoryScrollerView.h"
#import "LIUCategoryCollectionView.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUDisplayShoppingViewController.h"
#import "LIUDemoData.h"
#import "LIUCategoryModel.h"
#import "Masonry.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface LIUCategoryViewController ()

@property(nonatomic,strong)LIUCategoryScrollerView *categoryScroller;
@property(nonatomic,strong)LIUCategoryCollectionView *categoryCollectionView;

@property(nonatomic,strong)NSArray *categorys;

@end

@implementation LIUCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma 添加分类按钮的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(categoryChange:) name:@"LIUDidTapCategoryButton" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(subCategory:) name:@"LIUDidTapCategoryItem" object:nil];
    
    
    //添加左边的Scroller
    [self creatScroller];
}

#pragma --mark 添加左边的scrollerView
- (void)creatScroller {
    //因为有navigation，所以要加一层Scroller
    WS(ws);
    UIScrollView *scroller = [UIScrollView new];
    [self.view addSubview:scroller];
    [scroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0,0,0,ws.view.bounds.size.width-80));
    }];
    
    //获取左边的一级分类
    /*
     pageindex={pageindex}&pagesize={pagesize}&thumbwidth={thumbwidth}&thumbheight={thumbheight}
     */
    [self requestWithUrl:kGetFirstCater Parameters:@{@"pageindex":@1,
                                                     @"pagesize":@20,
                                                     @"thumbwidth":@20,
                                                     @"thumbheight":@20,
    } Success:^(NSDictionary *result) {
        ws.categorys = result[@"Data"];
        ws.categoryScroller = [LIUCategoryScrollerView creatCategoryScrollerViewWithCategorys:ws.categorys];
        [ws.view addSubview:self.categoryScroller];
        [ws.categoryScroller mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(64,0,49,ws.view.bounds.size.width-80));
        }];
        [ws.view bringSubviewToFront:self.categoryScroller];
        [ws.categoryScroller chuShiHuaSubScroller];
    } Failue:^(NSDictionary *failueInfo) {

    }];
    
    
//    self.categoryScroller = [LIUCategoryScrollerView creatCategoryScrollerViewWithCategorys:@[@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公",@"电脑办公"]];
//    [self.view addSubview:self.categoryScroller];
//    [self.categoryScroller mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.insets(UIEdgeInsetsMake(64,0,49,ws.view.bounds.size.width-80));
//    }];
//    [self.view bringSubviewToFront:self.categoryScroller];
//    [self.categoryScroller chuShiHuaSubScroller];
}

#pragma --mark 通知的处理
- (void)categoryChange:(NSNotification *)notification {
    //remove原来的界面
    [self.categoryCollectionView removeFromSuperview];
    //1.解析数据
    NSDictionary *dic = notification.userInfo[@"Shopping"];
    //2.创建视图 右边的collectionView
    self.categoryCollectionView = [LIUCategoryCollectionView creatCategoryCollectionViewWithCategpry:dic];
    [self.view addSubview:self.categoryCollectionView];
    WS(ws);
    [self.categoryCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(ws.categoryScroller.mas_right);
        make.top.equalTo(ws.view).with.offset(64);
        make.right.equalTo(ws.view);
        make.bottom.equalTo(ws.view).with.offset(-49);
        //make.edges.equalTo(ws.view).insets(UIEdgeInsetsMake(0, 0, 0, 0)); //类似2种写法
    }];
}

- (void)subCategory:(NSNotification *)notification {
    LIUDisplayShoppingViewController *disVC = [LIUDisplayShoppingViewController new];
    //拿到model
    LIUCategoryModel *model = notification.userInfo[@"category"];
    disVC.categoryid = model.categoryId;
    //disVC.titleLabel.text = model.name;
    disVC.model = model;
    [self presentViewController:disVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma --mark 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self forKeyPath:@"LIUDidTapCategoryButton"];
}
@end
