//
//  LIUSuggestController.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/9/19.
//  Copyright © 2015年 刘俊. All rights reserved.
//

#import "LIUSuggestController.h"
#import "UIViewController+GetHTTPRequest.h"
#import "ZHTextView.h"
#import "SVProgressHUD.h"
#import "Masonry.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUSuggestController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *textSuperView;

@property (nonatomic,strong)ZHTextView *textView;

@end

@implementation LIUSuggestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self creatUI];
   
    // Do any additional setup after loading the view from its nib.
}

- (void)creatUI {
    
    WS(ws);
    self.textView = [[ZHTextView alloc]init];
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.placeholder = @"写下您对本软件的建议...";
    [self.textSuperView addSubview:self.textView];
    self.textSuperView.layer.cornerRadius = 5.0f;
    self.textSuperView.layer.borderWidth = 1.0;
    self.textSuperView.layer.borderColor = [UIColor blackColor].CGColor;
    self.textSuperView.layer.masksToBounds = YES;
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.textSuperView).insets(UIEdgeInsetsMake(-64, 0, 0, 0));
    }];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
}

- (void)rightAction:(UIButton *)sender {
    
    NSString *str = self.textView.text;
    if ([str isEqual:[NSNull null]] || str == nil || [str isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"写下点什么吧" duration:1.5];
        return;
    }
    WS(ws);
    [self requestWithUrl:kFeedBack Parameters:@{@"userid":[self getUserId],@"title":@"",@"content":str} Success:^(NSDictionary *result) {
        [ws.navigationController popViewControllerAnimated:YES];
    } Failue:^(NSDictionary *failueInfo) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self rightAction:nil];
        return NO;
    }
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
