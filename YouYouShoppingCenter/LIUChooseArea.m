//
//  LIUChooseArea.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/9/3.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self
#import "LIUChooseArea.h"
#import "UIViewController+GetHTTPRequest.h"

@interface LIUChooseArea ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *areaList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LIUChooseArea

- (NSString *)provinceid {
    if (!_provinceid) {
        _provinceid = @"";
    }
    return _provinceid;
}

- (NSString *)cityid {
    if (!_cityid) {
        _cityid = @"";
    }
    return _cityid;
}

- (NSArray *)areaList {
    if (!_areaList) {
        _areaList = @[];
    }
    return _areaList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.areaTitle;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)getData {
    WS(ws);
    /*provinceid={provinceid}&cityid={cityid}*/
    [self requestWithUrl:kSearchAddres Parameters:@{@"provinceid":self.provinceid,
                                                    @"cityid":self.cityid}
    Success:^(NSDictionary *result) {
        ws.areaList = result[@"Data"];
        [ws.tableView reloadData];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.areaList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *area = self.areaList[indexPath.row];
    
    cell.textLabel.text = area[@"Name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(ws);
    LIUChooseArea *chooseArea = [[LIUChooseArea alloc]init];
    NSDictionary *currentDic = self.areaList[indexPath.row];
    switch (self.currentArreaType) {
        case AreaTypeProvince://当前是省份
        {
            chooseArea.currentArreaType = AreaTypeCityid;
            chooseArea.provinceid = currentDic[@"Id"];
            chooseArea.areaTitle = currentDic[@"Name"];
            chooseArea.cityid = @"";
            chooseArea.chooseAreaBlock = ^(NSDictionary *dic) {
                NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [mDic setValue:currentDic forKey:@"province"];
                if (ws.chooseAreaBlock) {
                    ws.chooseAreaBlock(mDic);
                   // [ws.navigationController popViewControllerAnimated:YES];
                    [ws dismissViewControllerAnimated:YES completion:nil];
                }
                
            };
            [self.navigationController pushViewController:chooseArea animated:YES];
        }
            break;
            
        case AreaTypeCityid://当前是城市
        {
            chooseArea.currentArreaType = AreaTypeArea;
            chooseArea.provinceid = @"";//self.provinceid;
            chooseArea.cityid = currentDic[@"Id"];
            chooseArea.areaTitle = currentDic[@"Name"];
            chooseArea.chooseAreaBlock = ^(NSDictionary *dic) {
                NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                [mDic setValue:currentDic forKey:@"city"];
                if (ws.chooseAreaBlock) {
                    ws.chooseAreaBlock(mDic);
                    [ws.navigationController popViewControllerAnimated:YES];
                }
                
            };
            [self.navigationController pushViewController:chooseArea animated:YES];
        }
            break;
            
        case AreaTypeArea://当前是区域
        {
            NSDictionary *mDic = @{@"area":currentDic};
                if (ws.chooseAreaBlock) {
                    ws.chooseAreaBlock(mDic);
                    [ws.navigationController popViewControllerAnimated:YES];
                }
        }
            break;
            
        default:
            break;
    }
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
