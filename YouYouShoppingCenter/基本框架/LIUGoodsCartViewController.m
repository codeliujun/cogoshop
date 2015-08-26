//
//  LIUGoodsCartViewController.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/2.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#define kUnloginBg_Color        [UIColor colorWithRed:177/255.0f green:178/255.0f blue:179/255.0f alpha:1]

#define kGoodsCartCell          @"mycell"

#import "LIUGoodsCartViewController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUQueRenDingController.h"
#import "LIUGoodsCartTableViewCell.h"
#import "LIULoginViewController.h"
#import "LIUCartGoodModel.h"
#import "LIUUserInfoData.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUGoodsCartViewController ()<UITableViewDataSource,UITableViewDelegate,LIUGoodsCartTableViewCellDelegate,LIULoginViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *allSelectButton; //全选按钮
@property (weak, nonatomic) IBOutlet UILabel *allCountLabel;    //合计label
@property (weak, nonatomic) IBOutlet UILabel *caculaterLabel; //结算的显示label
@property (weak, nonatomic) IBOutlet UITableView *tableView;


//未登录的view 或者没有物品的view
@property (nonatomic, strong) UIView *unLoginOrNoGoodsView;
@property (nonatomic, strong) UIButton *unLoginOrNoGoodsButton;


//数据
@property (nonatomic, strong) LIUUserInfoData *userInfo;
@property (nonatomic, strong) NSMutableArray *cartGoodData;

//编辑，完成按钮
@property(nonatomic, strong) UIBarButtonItem *editButton;
@property(nonatomic, strong) UIBarButtonItem *doneButton;
@property(nonatomic, assign) BOOL isEdit;


@end

@implementation LIUGoodsCartViewController

- (NSMutableArray *)cartGoodData {
    if (!_cartGoodData) {
        _cartGoodData = [NSMutableArray new];
    }
    return _cartGoodData;
}

- (UIBarButtonItem *)editButton {
    if (!_editButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [button setTitle:@"编辑" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(editDidTap:) forControlEvents:UIControlEventTouchUpInside];
        _editButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    return _editButton;
}

- (UIBarButtonItem *)doneButton {
    if (!_doneButton) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(editDidTap:) forControlEvents:UIControlEventTouchUpInside];
        _doneButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    return _doneButton;
}

- (LIUUserInfoData *)userInfo {
    if (!_userInfo) {
        _userInfo = [LIUUserInfoData defaultUserInfo];
    }
    return _userInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isEdit = NO;
    
    self.navigationItem.rightBarButtonItem = self.editButton;
    [self.tableView registerNib:[UINib nibWithNibName:@"LIUGoodsCartTableViewCell" bundle:nil] forCellReuseIdentifier:kGoodsCartCell];
    
    self.caculaterLabel.layer.cornerRadius = 5.f;
    self.caculaterLabel.layer.masksToBounds = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /**
     *每次显示之前都要判断是否登录 然后请求数据
     */
    if (![self userIsLogin]) {
        //没有登录
        [self initUnLoginViewWithButtonTitle:@"登录"];
    }
    else {
        /**
         *  @author 刘俊, 15-08-02
         *
         *  已经登录 隐藏未登录页面
         */
        //已经登录，接下来就是请求数据
        [self requestWithUrl:kGetCartGood Parameters:@{@"userid":[self getUserId]} Success:^(NSDictionary *result) {
            if ([result[@"ErrorCode"] integerValue] == 200) {
                NSArray *array = result[@"Data"];
                if (array.count <= 0) {
                    [self initUnLoginViewWithButtonTitle:@"去逛逛"];
                }else {
                    self.cartGoodData = [LIUCartGoodModel objectArrayWithKeyValuesArray:array];
                    /**
                     *  @author 刘俊, 15-08-03
                     *
                     *  这里有数据
                     */
                    [self updateTotalCountLabel];
                    self.allSelectButton.selected = NO;
                    [self.unLoginOrNoGoodsView setHidden:YES];
                    [self.tableView reloadData];
                }
            }else {
                [SVProgressHUD showErrorWithStatus:@"网络数据请求错误" duration:2.f];
            }
        } Failue:^(NSDictionary *failueInfo) {
            NSLog(@"%@",failueInfo);
        }];
        
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BOOL test = YES;
    if (test == YES) {
        LIUQueRenDingController *confirmVC = [[LIUQueRenDingController alloc]init];
        confirmVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:confirmVC animated:YES];
        //[self presentViewController:confirmVC animated:YES completion:nil];
    }
}

/**
 *  @author 刘俊, 15-08-02
 *
 *  创建为登录的界面
 */
- (void)initUnLoginViewWithButtonTitle:(NSString *)title {
    
    if (self.unLoginOrNoGoodsView) {
        self.unLoginOrNoGoodsView.hidden = NO;
        [self.unLoginOrNoGoodsButton setTitle:title forState:UIControlStateNormal];
        return;
    }
    
    WS(ws);
    
    {//View
        self.unLoginOrNoGoodsView = [[UIView alloc]init];
        self.unLoginOrNoGoodsView.backgroundColor = kUnloginBg_Color;
        [self.view addSubview:self.unLoginOrNoGoodsView];
        [self.view bringSubviewToFront:self.unLoginOrNoGoodsView];
        
        [self.unLoginOrNoGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    UIImageView *imageView = nil;
    {//ImageView
        imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"emptyCart"];
        [self.unLoginOrNoGoodsView addSubview:imageView];//240 160
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.unLoginOrNoGoodsView);
            make.centerY.equalTo(ws.unLoginOrNoGoodsView).with.offset(-40);
            make.width.equalTo(@240);
            make.height.equalTo(@160);
        }];
    }
    
    {//button
        self.unLoginOrNoGoodsButton = [[UIButton alloc]init];
        self.unLoginOrNoGoodsButton.backgroundColor = [UIColor redColor];
        self.unLoginOrNoGoodsButton.titleLabel.textColor = [UIColor whiteColor];
        [self.unLoginOrNoGoodsButton setTitle:title forState:UIControlStateNormal];
        self.unLoginOrNoGoodsButton.layer.cornerRadius = 5.f;
        self.unLoginOrNoGoodsButton.layer.masksToBounds = YES;
        [self.unLoginOrNoGoodsButton addTarget:self action:@selector(tapUnloginButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.unLoginOrNoGoodsView addSubview:self.unLoginOrNoGoodsButton];
        [self.unLoginOrNoGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).with.offset(5);
            make.left.equalTo(ws.unLoginOrNoGoodsView.mas_left).with.offset(30);
            make.right.equalTo(ws.unLoginOrNoGoodsView.mas_right).with.offset(-30);
            make.height.equalTo(@49);
        }];
    }
}

- (void)tapUnloginButton:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"登录"]) {
        LIULoginViewController *loginVC = [LIULoginViewController shareLoginViewController];
        loginVC.delegate = self;
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [self presentViewController:navi animated:YES completion:nil];
    }
    else {
        [self.tabBarController setSelectedIndex:0];
    }
}

- (void)didLoging {
    [self viewWillAppear:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  @author 刘俊, 15-08-02
 *
 *  编辑按钮
 */
#pragma --mark 点击编辑
- (void)editDidTap:(UIButton *)sender {
    self.isEdit = !self.isEdit;
    self.navigationItem.rightBarButtonItem = self.isEdit?self.doneButton:self.editButton;
    [self.tableView reloadData];
}


#pragma --mark UItableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cartGoodData.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [tableView numberOfRowsInSection:[tableView numberOfSections]-1]-1) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        //cell.backgroundColor = [UIColor redColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        LIUGoodsCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodsCartCell forIndexPath:indexPath];
        cell.isEdit = self.isEdit;
        cell.cartGood = self.cartGoodData[indexPath.row];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma --mark LIUGoodsCartTableViewCellDelegate
/**
 *  @author 刘俊, 15-08-03
 *
 *  返回count代理
 */
- (void)cell:(LIUGoodsCartTableViewCell *)cell GoodCountDidChangeWithAndCurrentCount:(NSInteger)count {
    /**
     *  @author 刘俊, 15-08-03
     *
     *  获取cell对应的数据，拿到model，更改number，并发送数据
     */
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    LIUCartGoodModel *good = self.cartGoodData[index.row];
    
    /**
     *  @author 刘俊, 15-08-03
     *
     *  发送更改数据的请求
     */
    [self requestWithUrl:kChangeGoodCOunt Parameters:@{@"amount":@(count),@"itemid":good.Id} Success:^(NSDictionary *result) {
        NSLog(@"===%@",result);
        if ([result[@"ErrorCode"]integerValue] == 200) {
            good.Number = @(count);
            [self.cartGoodData replaceObjectAtIndex:index.row withObject:good];//这里可要可不要，经过验证，只要是从array中传出去的数据都只传得地址，只要后面数据更改，前面的源数据也会被更改
            [self updateTotalCountLabel];
        }else {
            [SVProgressHUD showErrorWithStatus:@"数据请求出错" duration:1.f];
        }
        
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
}
/**
 *  @author 刘俊, 15-08-03
 *
 *  删除按钮的点击
 */
- (void)cell:(LIUGoodsCartTableViewCell *)cell DidTapDeletedButton:(UIButton *)sender {
    
    /**
     *  @author 刘俊, 15-08-03
     *
     *  获取cell对应的数据，删除订单，并且删除数据源，并刷新
     */
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    LIUCartGoodModel *good = self.cartGoodData[index.row];
    
    [self requestWithUrl:kDeletedGood Parameters:@{@"itemid":good.Id} Success:^(NSDictionary *result) {
        if ([result[@"ErrorCode"]integerValue] == 200) {
            [self.cartGoodData removeObject:good];
            if (self.cartGoodData.count == 0) {
                [self viewWillAppear:YES];
                return;
            }
            [self updateTotalCountLabel];
            [self.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationRight];
            
        }
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
}

/**
 *  @author 刘俊, 15-08-03
 *
 *  选择按钮的点击
 */
- (void)cell:(LIUGoodsCartTableViewCell *)cell DidTapSelectButton:(UIButton *)sender {
    
    /**
     *  @author 刘俊, 15-08-03
     *
     *  获取cell对应的数据，删除订单，并且删除数据源，并刷新
     */
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    LIUCartGoodModel *good = self.cartGoodData[index.row];
    good.isSelect = sender.isSelected;
    
    [self updateTotalCountLabel];
    
}

- (void)updateTotalCountLabel {
    
    NSInteger goodsCount = 0;
    CGFloat goodsTotalPrice = 0.00f;
    
    for (LIUCartGoodModel *good in self.cartGoodData) {
        if (good.isSelect) {
            goodsCount++;
            goodsTotalPrice = goodsTotalPrice + [good.Price floatValue]*[good.Number integerValue];
        }
    }
    
    self.caculaterLabel.text = [NSString stringWithFormat:@"结算（%lu）",goodsCount];
    self.allCountLabel.text = [NSString stringWithFormat:@"合计：%.2f",goodsTotalPrice];
}


#pragma --mark CurrentpageButtonEvent
- (IBAction)allSelectButtonTap:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    for (LIUCartGoodModel *good in self.cartGoodData) {
        good.isSelect = sender.selected;
    }
    [self.tableView reloadData];
    [self updateTotalCountLabel];
}

/**
 *  @author 刘俊, 15-08-03
 *  结算按钮
 */
- (IBAction)caculaterButtonTap:(UIButton *)sender {
    
    //1.将选中的商品转移到订单中
    NSMutableArray *marray = [NSMutableArray new];
    for (LIUCartGoodModel *good in self.cartGoodData) {
        if (good.isSelect) {
            [marray addObject:good.Id];
        }
    }
    if (marray.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请至少选择一件商品" duration:1.5f];
        return;
    }
    //NSString *allGood = marray.count==1?[marray firstObject]:[marray componentsJoinedByString:@","];
    
    [self requestWithUrl:kCreatOrder Parameters:@{@"shopid":@"",@"userid":[self getUserId]} Success:^(NSDictionary *result) {
        
        //跳转界面
        LIUQueRenDingController *confirmVC = [[LIUQueRenDingController alloc]init];
        confirmVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:confirmVC animated:YES];
       // [self presentViewController:confirmVC animated:YES completion:nil];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
    
    
    
    //    LIUConfirmBookingViewController *confirmVC = [[LIUConfirmBookingViewController alloc]init];
    //    //[self.navigationController pushViewController:confirmVC animated:YES];
    //    [self presentViewController:confirmVC animated:YES completion:nil];
    
    
    //    [self requestWithUrl:kCreatOrder Parameters:@{@"shopid":allGood} Success:^(NSDictionary *result) {
    //        if ([result[@"ErrorCode"] integerValue] == 200) {
    //            LIUConfirmBookingViewController *confirmVC = [[LIUConfirmBookingViewController alloc]init];
    //            //[self.navigationController pushViewController:confirmVC animated:YES];
    //            [self presentViewController:confirmVC animated:YES completion:nil];
    //        }
    //
    //    } Failue:^(NSDictionary *failueInfo) {
    //        
    //    }];
    
}

@end
