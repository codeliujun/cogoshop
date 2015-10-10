//
//  LIUShoppingDetaileViewController.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/19.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUShoppingDetaileViewController.h"
#import "LIUDetailHeaderImageScrollerView.h"
#import "UIViewController+GetHTTPRequest.h"
#import "SVProgressHUD.h"
#import "LIUTheFirstTableViewCell.h"
#import "LIUTheSecondTableViewCell.h"
#import "LIUGouWuCheModel.h"
#import "LIUUserInfoData.h"
#import "LIULoginViewController.h"
#import "Masonry.h"
#import "LIUChageNumberController.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUShoppingDetaileViewController ()<UITableViewDataSource,UITableViewDelegate,LIUDetailHeaderImageScrollerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *detaileTableView;
@property(nonatomic,strong)UILabel *numberLabel;//显示scroller的数量的

@property (weak, nonatomic) IBOutlet UIButton *addCartButton;
@end

@implementation LIUShoppingDetaileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeaderScrollerview];
    //注册单元格
    [self.detaileTableView registerNib:[UINib nibWithNibName:@"LIUTheFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"firstCell"];
    [self.detaileTableView registerNib:[UINib nibWithNibName:@"LIUTheSecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"secondCell"];
}

- (void)addHeaderScrollerview {
    
    UIView *headerSupperView = [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, 200)];
    headerSupperView.backgroundColor = [UIColor redColor];
    
    self.addCartButton.layer.cornerRadius = 5.0f;
    self.addCartButton.layer.masksToBounds = YES;
    /**
     假数据
     */
    //self.good.imageNames = @[@"测试图片",@"测试图片",@"测试图片",@"测试图片",@"测试图片"];
    
    LIUDetailHeaderImageScrollerView *scrollerView = [LIUDetailHeaderImageScrollerView creatScrollerWithShopping:self.good];
    
    //创建和配置显示数量的label
    NSInteger count = MAX(self.good.ImageUrls.count, 2);
    self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.text = [NSString stringWithFormat:@"%d/%lu",1,(long)count];
    CGRect labelFrame = [self.numberLabel textRectForBounds:CGRectMake(0, 0, 100, 200) limitedToNumberOfLines:1];
    CGSize labelSize = CGSizeMake(MAX(labelFrame.size.width, labelFrame.size.height), MAX(labelFrame.size.width, labelFrame.size.height));
    labelFrame.size = labelSize;
    //self.numberLabel.frame = labelFrame;
    self.numberLabel.layer.cornerRadius = (labelFrame.size.width+15)*0.5;
    self.numberLabel.layer.masksToBounds = YES;
    
    [headerSupperView addSubview:self.numberLabel];
    
    self.numberLabel.backgroundColor = [UIColor yellowColor];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerSupperView.mas_right).with.offset(-20);
        make.bottom.equalTo(headerSupperView.mas_bottom).offset(-20);
        make.width.equalTo(@(labelSize.width+15));
        make.height.equalTo(@(labelSize.height+15));
    }];
    
    scrollerView.indexDelegate = self;
    scrollerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    [headerSupperView addSubview:scrollerView];
    [headerSupperView bringSubviewToFront:self.numberLabel];
    self.detaileTableView.tableHeaderView = headerSupperView;
}

#pragma --mark  scroller的下标
- (void)currentImageIndex:(NSInteger)index {
    //NSLog(@"当前的下表是%ld",(long)index);
    NSInteger count = MAX(self.good.ImageUrls.count, 2);
    self.numberLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)index,(long)count];;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma --mark TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0 || section == 1) {
        return 1;
    }else {
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LIUTheFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell" forIndexPath:indexPath];
        cell.goods = self.good;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }/*else if(indexPath.section == 1) {
      LIUTheSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell" forIndexPath:indexPath];
      cell.goods = self.good;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      return cell;
      }*/else {
          NSArray *array = @[@"商品评价"];
          UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
          cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
          cell.textLabel.text = array[indexPath.row];
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
          return cell;
      }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = nil;
    
    if (0 == section) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
        view.backgroundColor = [UIColor clearColor];
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:13.0];
        label.numberOfLines = 2;
        label.text = self.good.Name;
        
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).with.offset(20);
            make.right.equalTo(view.mas_right).with.offset(-20);
            make.height.equalTo(@35);
            make.centerY.equalTo(view);
        }];
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 106;
    }
    /*else if (1 == indexPath.section) {
     return 76.f;
     }*/
    else {
        return 44;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.detaileTableView.bounds.size.width, 10)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }else {
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 20.f;
    if ( 0 == section) {
        height = 40.f;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0;
}

#pragma --mark cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [SVProgressHUD showErrorWithStatus:@"该功能尚未开放" duration:1.0];
        NSLog(@"点击了cell");
        /*orderid={orderid}&pageindex={pageindex}&pagesize={pagesize}*/
        [self requestWithUrl:kGetGoodComment Parameters:@{@"orderid":self.good.Id,@"pageindex":@1,@"pagesize":@20} Success:^(NSDictionary *result) {
            if ([result[@"ErrorCode"] integerValue] == 200) {
                [SVProgressHUD showSuccessWithStatus:@"评论接口调用成功" duration:1.f];
                
            }
        } Failue:^(NSDictionary *failueInfo) {
            
        }];
    }
}

#pragma --mark 返回按钮
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma --mark 加入购物车
- (IBAction)addToShoppingCart:(UIButton *)sender {
    
    LIUChageNumberController *changeVc = [[LIUChageNumberController alloc]init];
    changeVc.good = self.good;
    [self.navigationController pushViewController:changeVc animated:YES];
    
    
//    //弹出数量选择框
//    //[self showCountSelectView];
//    
//    
//    //1.判断是否登录
//    LIUUserInfoData *userInfo = [LIUUserInfoData defaultUserInfo];
//    
//    if (userInfo.Id.length <= 0) {
//        //没有登录
//        LIULoginViewController *loginVC = [LIULoginViewController shareLoginViewController];
//        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginVC];
//        [self presentViewController:navi animated:YES completion:nil];
//        return;
//    }
//    else {
//        /*
//         goodsid={goodsid}&count={count}&shopid={shopid}
//         */
//  
//       // 先注释
////        if ([self.good.InstoreNumber integerValue] <= 0) {
////            [SVProgressHUD showErrorWithStatus:@"没有库存" duration:1.5];
////            return;
////        }
//        
//        NSString *userId = [self getUserId];
//        [self requestWithUrl:kAddGood Parameters:@{
//                                                   @"goodsid":self.good.Id,
//                                                   @"count":@1,
//                                                   @"shopid":@"",
//                                                   @"userid":userId
//                                                   } Success:^(NSDictionary *result) {
//                                                       NSLog(@"%@",result);
//                                                       if ([result[@"ErrorCode"] integerValue] == 200) {
//                                                           [SVProgressHUD showSuccessWithStatus:@"加入购物车成功" duration:2.f];
//                                                       }
//                                                   } Failue:^(NSDictionary *failueInfo) {
//                                                       NSLog(@"%@",failueInfo);
//                                                   }];
//        
//        
//    }
//
    /*
     //2.得到当前用户
     LIUPersonModel *person = [LIUPersonModel defaultUser];
     //配置商品
     self.good.count = 1;//默认是1,修改数量在购物车中
     self.good.isSelect = NO;
     
     //然后就是添加
     //1.判断购物车中原来有没有这个商家的model
     BOOL isAddSuccess = NO;
     
     for (LIUGouWuCheModel *gouModel in person.gouWuCheGoods) {
     NSLog(@"self:%@---gouModel:%@",self.good.storeName,gouModel.storeName);
     if ([self.good.storeName isEqualToString:gouModel.storeName]) {
     //原来添加了这个商家的商品,接下来判断改商品是否重复，我这里直接用地址了，到时要修改
     for (LIUGoodModel *goodModel in gouModel.didInGouWuCheGoods) {
     if ([self.good.currentPrice isEqualToNumber:goodModel.currentPrice]) {
     NSLog(@"原来添加了这个商家的商品,接下来判断改商品是否重复，我这里直接用地址了，到时要修改");
     NSLog(@"商品已经添加过了");
     return;//没有继续下去的必要了
     }
     }
     //如果全部循环完了，还没有重复的，那么就可以添加了
     [gouModel.didInGouWuCheGoods addObject:self.good];
     isAddSuccess = YES;//已经添加成功
     }
     //如果添加成功，就不要循环了
     if (isAddSuccess) {
     break;
     }
     }
     
     //如果全部循环完了，商品还没有添加完，好吧，那么就新建一个购物车Model吧
     if (isAddSuccess == NO) {
     LIUGouWuCheModel *gouwuChe = [LIUGouWuCheModel new];
     gouwuChe.storeName = self.good.storeName;
     [gouwuChe.didInGouWuCheGoods addObject:self.good];
     [person.gouWuCheGoods addObject:gouwuChe];
     }
     */
}


@end
