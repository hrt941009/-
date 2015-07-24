//
//  PriceAndNumbersTableViewCell.m
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "PriceAndNumbersTableViewCell.h"
#import "BuyBackgroundView.h"
#import "UIButton+Block.h"

@implementation PriceAndNumbersTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        BuyBackgroundView *bgView = [[BuyBackgroundView alloc] initWithFrame:CGRectMake(5.f, 0, self.frame.size.width - 10.f, 150.f)];
        [self.contentView addSubview:bgView];
        
        //-----
        UILabel *priceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 0, 160.f, 25.f)];
        priceTitleLabel.backgroundColor = [UIColor clearColor];
        priceTitleLabel.text = @"预估到手价(元)";
        priceTitleLabel.textColor = [UIColor blackColor];
        priceTitleLabel.font = [UIFont systemFontOfSize:14.f];
        [bgView addSubview:priceTitleLabel];
        
        UILabel *priceDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 25.f, 160.f, 25.f)];
        priceDetailLabel.backgroundColor = [UIColor clearColor];
        priceDetailLabel.text = @"实际到手价格可能因为运费差异和预估到手价有些出入";
        priceDetailLabel.textColor = [UIColor darkGrayColor];
        priceDetailLabel.font = [UIFont systemFontOfSize:10.f];
        priceDetailLabel.numberOfLines = 2;
        [bgView addSubview:priceDetailLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame) - 100.f , 0, 90.f, 50.f)];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.font = [UIFont systemFontOfSize:14.f];
        _priceLabel.numberOfLines = 1;
        [bgView addSubview:_priceLabel];
        
        //------- 分割线1
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50.f, bgView.frame.size.width, 0.5)];
        lineView1.backgroundColor = [UIColor lightGrayColor];
        [bgView addSubview:lineView1];
        
        //-----
        UILabel *moneyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(3.f, CGRectGetMaxY(lineView1.frame), 160.f, 50.f)];
        moneyTitleLabel.backgroundColor = [UIColor clearColor];
        moneyTitleLabel.text = @"定金(元)";
        moneyTitleLabel.textColor = [UIColor redColor];
        moneyTitleLabel.font = [UIFont systemFontOfSize:14.f];
        [bgView addSubview:moneyTitleLabel];
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame) - 100.f , moneyTitleLabel.frame.origin.y, 90.f, 50.f)];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.textColor = [UIColor redColor];
        _moneyLabel.font = [UIFont systemFontOfSize:14.f];
        _moneyLabel.numberOfLines = 1;
        [bgView addSubview:_moneyLabel];
        
        //------- 分割线2
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(moneyTitleLabel.frame), bgView.frame.size.width, 0.5)];
        lineView2.backgroundColor = [UIColor lightGrayColor];
        [bgView addSubview:lineView2];
        
        //------
        if (_isDetail) {
            UILabel *numberTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, CGRectGetMaxY(lineView2.frame), 160.f, 25.f)];
            numberTitleLabel.backgroundColor = [UIColor clearColor];
            numberTitleLabel.text = @"数量";
            numberTitleLabel.textColor = [UIColor blackColor];
            numberTitleLabel.font = [UIFont systemFontOfSize:14.f];
            [bgView addSubview:numberTitleLabel];
            
            _numberDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, CGRectGetMaxY(numberTitleLabel.frame), 160.f, 25.f)];
            _numberDetailLabel.backgroundColor = [UIColor clearColor];
            _numberDetailLabel.textColor = [UIColor blackColor];
            _numberDetailLabel.font = [UIFont systemFontOfSize:12.f];
            _numberDetailLabel.numberOfLines = 2;
            [bgView addSubview:_numberDetailLabel];
        }else{
            UILabel *numberTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(3.f, CGRectGetMaxY(lineView2.frame), 160.f, 50.f)];
            numberTitleLabel.backgroundColor = [UIColor clearColor];
            numberTitleLabel.text = @"数量";
            numberTitleLabel.textColor = [UIColor blackColor];
            numberTitleLabel.font = [UIFont systemFontOfSize:14.f];
            [bgView addSubview:numberTitleLabel];
        }

        _numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(bgView.frame) - 50.f , CGRectGetMaxY(lineView2.frame) + 15.f, 40.f, 22.f)];
        _numberTextField.backgroundColor = [UIColor clearColor];
        _numberTextField.textColor = [UIColor blackColor];
        _numberTextField.borderStyle = UITextBorderStyleLine;
        _numberTextField.font = [UIFont systemFontOfSize:14.f];
        _numberTextField.delegate = self;
        _numberTextField.keyboardType = UIKeyboardTypeNumberPad;
        [bgView addSubview:_numberTextField];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_delegate priceAndNumbersKeyboardDidShow];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_numberTextField resignFirstResponder];
}

@end
