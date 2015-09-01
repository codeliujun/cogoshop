//
//  LIUGoodsCartTableViewCell.m
//  YouYouShoppingCenter
//
//  Created by liujun on 15/8/2.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//
/**
 *  @author 刘俊, 15-08-02
 *
 *  重构cell
 */


#import "LIUGoodsCartTableViewCell.h"
#import "SVProgressHUD.h"

@interface LIUGoodsCartTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *selectButtonImageView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *goodIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;

//编辑的View
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel; //显示加减的数量

//没有编辑的view
@property (weak, nonatomic) IBOutlet UIView *unEditView;
@property (weak, nonatomic) IBOutlet UILabel *showCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic, assign) NSInteger countNumber;

@end


@implementation LIUGoodsCartTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCartGood:(LIUCartGoodModel *)cartGood {
    _cartGood = cartGood;
    [self updateContent];
}

- (void)updateContent {
    
    self.goodIconImageView.image = [UIImage imageNamed:@"测试图片"];
    self.goodNameLabel.text = self.cartGood.Name;
    self.countNumber = [self.cartGood.Number integerValue];
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)self.countNumber];
    self.showCountLabel.text = [NSString stringWithFormat:@"数量：%ld",(long)self.countNumber];
    self.priceLabel.text = [NSString stringWithFormat:@"价格：%@",self.cartGood.Price];
    self.selectButtonImageView.highlighted = self.cartGood.isSelect;
    
    if (self.isEdit) {
        self.editView.hidden = NO;
        self.unEditView.hidden = YES;
    }else {
        self.editView.hidden = YES;
        self.unEditView.hidden = NO;
    }
}

- (void)updateCountLabel {
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)self.countNumber];
    self.showCountLabel.text = [NSString stringWithFormat:@"数量：%ld",(long)self.countNumber];
    
    [self.delegate cell:self GoodCountDidChangeWithAndCurrentCount:self.countNumber];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


//按钮的操作
- (IBAction)reduceCount:(UIButton *)sender {
    self.countNumber--;
    if (self.countNumber <= 0) {
        [SVProgressHUD showErrorWithStatus:@"真的不能再少了..." duration:1.5f];
        self.countNumber = 1;
        return;
    }
    [self updateCountLabel];
    //减
    NSLog(@"reduce");
}

- (IBAction)addCount:(UIButton *)sender {
    self.countNumber++;
    if (self.countNumber > [self.cartGood.InstoreNumber integerValue]) {
        [SVProgressHUD showErrorWithStatus:@"库存不够呀" duration:1.f];
        self.countNumber = [self.cartGood.InstoreNumber integerValue];
        return;
    }
    [self updateCountLabel];
    //加
    NSLog(@"add");
}

- (IBAction)delectGood:(UIButton *)sender {
    //删除
    [self.delegate cell:self DidTapDeletedButton:sender];
    NSLog(@"delect");
}

- (IBAction)selectButton:(UIButton *)sender {
    //选择
    self.selectButton.selected = !sender.isSelected;
    self.selectButtonImageView.highlighted = self.selectButton.selected;
    [self.delegate cell:self DidTapSelectButton:sender];
}



@end
