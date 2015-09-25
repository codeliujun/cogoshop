//
//  LIUEvalatController.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/30.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUEvalatController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "LIUEvaFirstCell.h"
#import "LIUSecondCell.h"
#import "LIUEvaThreadCell.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUEvalatController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    LIUEvaFirstCell     *_fCell;
    LIUSecondCell       *_sCell;
    LIUEvaThreadCell    *_tCell;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *stardescription;
@property (nonatomic,strong)NSString *starservice;
@property (nonatomic,strong)NSString *startransit;

@end

@implementation LIUEvalatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCell];
    
}

- (void)initCell {
    self.title = @"评价";
    
    _fCell = [LIUEvaFirstCell cell];
    _fCell.model = self.model;
    
    _sCell = [LIUSecondCell cell];
    _sCell.tfInput.delegate = self;
    _sCell.tfInput.returnKeyType = UIReturnKeyDone;
    
    _tCell = [LIUEvaThreadCell cell];
    WS(ws);
    _tCell.starBlock = ^(EvaType type, NSString *sta) {
        switch (type) {
            case EvaTypeDes:
                ws.stardescription = sta;
                break;
            case EvaTypeSer:
                ws.starservice = sta;
                break;
            case EvaTypeSpeed:
                ws.startransit = sta;
                break;
                
            default:
                break;
        }
        
        
    };
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [button setTitle:@"评价" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    button.titleLabel.textAlignment = NSTextAlignmentRight;
    [button addTarget:self action:@selector(eva:) forControlEvents:UIControlEventTouchUpInside];
   // self.navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    //[self.navigationController.navigationBar addSubview:button];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if (0 == indexPath.row) {
        cell = _fCell;
    }
    if (1 == indexPath.row) {
        cell = _sCell;
    }
    if (2 == indexPath.row) {
        cell = _tCell;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 44.f;
    if (0 == indexPath.row) {
        height = 70.f;
    }
    if (1 == indexPath.row) {
       height = 90.f;
    }
    if (2 == indexPath.row) {
       height = 180.f;
    }
    
    return height;
}

- (void)eva:(UIButton *)sender {
    
    self.content = _sCell.tfInput.text;
    if ([self.content isEqual:[NSNull null]]) {
        self.content = @"";
    }
    
    if (!self.stardescription) {
        self.stardescription = @"0";
    }
    if (!self.starservice) {
        self.stardescription = @"0";
    }if (!self.startransit) {
        self.stardescription = @"0";
    }
    /*
     Goods/addcomment?userid={userid}&orderid={orderid}&commentcontent={commentcontent}&rank={rank}&stardescription={stardescription}&starservice={starservice}&startransit={startransit}*/
    [self requestWithUrl:kAddComment Parameters:@{
                    @"userid":[self getUserId],
                    @"orderid":self.model.Id,
                    @"commentcontent":self.content,
                    @"rank":@"0",
                    @"stardescription":self.stardescription,
                    @"starservice":self.starservice,
                    @"startransit":self.startransit,
                    } Success:^(NSDictionary *result) {
                        [self.navigationController popViewControllerAnimated:YES];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
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
