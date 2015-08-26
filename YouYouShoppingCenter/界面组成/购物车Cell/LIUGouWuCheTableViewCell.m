//
//  LIUGouWuCheTableViewCell.m
//  YouYouShoppingCenter
//
//  Created by 刘俊 on 15/6/23.
//  Copyright (c) 2015年 刘俊. All rights reserved.
//

#import "LIUGouWuCheTableViewCell.h"
#import "Masonry.h"

#define WS(weakSelf) __weak __typeof(&*self)weakSelf=self

@interface LIUGouWuCheTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *unEditView;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UIImageView *shoppingImageView;

//没有编辑的页面的属性
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCountLabel;


@property(nonatomic,strong)UILabel *currentPriceLabel;
@property(nonatomic,strong)UILabel *originPriceLabel;

//编辑的页面的属性
@property (weak, nonatomic) IBOutlet UILabel *countLabel;//编辑的时候的属性
@end

@implementation LIUGouWuCheTableViewCell

- (UILabel *)currentPriceLabel {
    if (!_currentPriceLabel) {
        _currentPriceLabel = [[UILabel alloc]init];
    }
    return _currentPriceLabel;
}

- (UILabel *)originPriceLabel {
    if (!_originPriceLabel) {
        _originPriceLabel = [[UILabel alloc]init];
    }
    return _originPriceLabel;
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    if (isEdit) {
        self.editView.hidden = NO;
        self.unEditView.hidden = YES;
    }else{
        self.editView.hidden = YES;
        self.unEditView.hidden = NO;
    }
}


- (void)setGoodModel:(LIUCartGoodModel *)goodModel {
    _goodModel = goodModel;
    
    /*
     "ThumbFileId" : null,
     "Id" : "03e6034f-470e-4bf8-8f92-a4e4015c98d8",
     "Name" : "康师傅 酸梅汤 450ml",
     "ProductId" : "0cc38ee1-291d-435b-9491-a4e2013a8a69",
     "MemberId" : "3ac8d1f3-448c-4ec6-9ee8-a4e2013a8a43",
     "Number" : 1,
     "ShopId" : null,
     "OtherFeesRmk" : null,
     "ThumbUrl" : "http:\/\/uugo.cnnst.com\/skins\/default\/images\/nophoto.png",
     "TotalMoney" : 0,
     "Price" : 12,
     "OtherFees" : 0,
     "Code" : "2123124563456342160",
     "BarCode" : null,
     "InstoreNumber" : 10
     */
    [self.currentPriceLabel removeFromSuperview];
    self.currentPriceLabel = nil;
    [self.originPriceLabel removeFromSuperview];
    self.originPriceLabel = nil;
    
    self.shoppingImageView.image = [UIImage imageNamed:@"测试图片"];
    self.desLabel.text = _goodModel.Name;
    self.selectButton.selected = _goodModel.isSelect;
    
    WS(ws);
    //当前价格和原来价格
    self.currentPriceLabel.text = [NSString stringWithFormat:@"￥%@",goodModel.Price];
    self.currentPriceLabel.font = [UIFont systemFontOfSize:13];
    self.currentPriceLabel.textColor = [UIColor redColor];
    CGRect rect = [self.currentPriceLabel textRectForBounds:CGRectMake(0, 0, 100, 100) limitedToNumberOfLines:1];
    [self.unEditView addSubview:self.currentPriceLabel];
    [self.currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.unEditView).with.offset(10);
        make.bottom.equalTo(ws.unEditView).with.offset(-10);
        make.width.equalTo(@(rect.size.width));
        make.height.equalTo(@(rect.size.height));
    }];
    
    self.originPriceLabel.text = [NSString stringWithFormat:@"￥%@",goodModel.Price];
    self.originPriceLabel.font = [UIFont systemFontOfSize:8];
    self.originPriceLabel.textColor = [UIColor lightGrayColor];
    rect = [self.originPriceLabel textRectForBounds:CGRectMake(0, 0, 100, 100) limitedToNumberOfLines:1];
    [self.unEditView addSubview:self.originPriceLabel];
    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.currentPriceLabel);
        make.left.equalTo(self.currentPriceLabel.mas_right).with.offset(5);
        make.width.equalTo(@(rect.size.width));
        make.height.equalTo(@(rect.size.height));
    }];
    
}
 


- (IBAction)selectButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.goodModel.isSelect = sender.selected;
    [self.delegate didTapSelectButtonWithIsSelect:sender.selected AndCell:self];
}

#pragma --mark 编辑的页面
- (IBAction)jian:(UIButton *)sender {
    if (self.goodModel.count==1) {
        NSLog(@"不能再少了");
        return;
    }
    self.goodModel.count--;
    [self updateTotalCountLabelWithCount:self.goodModel.count];
}
- (IBAction)jia:(UIButton *)sender {
    self.goodModel.count++;
    [self updateTotalCountLabelWithCount:self.goodModel.count];
}
- (void)updateTotalCountLabelWithCount:(NSInteger)count {
    self.totalCountLabel.text = [NSString stringWithFormat:@"×%ld",(long)count];
    self.countLabel.text = [NSString stringWithFormat:@"%ld",count];
    [self.delegate countDidChange];
    [self setNeedsLayout];
}
- (IBAction)deleteButton:(UIButton *)sender {
    [self.delegate didTapDeleteButtonWithCell:self];
}


@end
