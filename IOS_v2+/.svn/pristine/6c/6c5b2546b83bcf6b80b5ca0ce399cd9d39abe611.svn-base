//
//  SubjectCommissionTableViewCell.m
//  Love
//
//  Created by lee wei on 14-9-17.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SubjectCommissionTableViewCell.h"

@implementation SubjectCommissionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

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

- (UIImageView *)productImageView
{
    if (!_productImageView) {
        _productImageView = [[UIImageView alloc] init];
        _productImageView.backgroundColor = [UIColor colorRGBWithRed:169.f green:169.f blue:169.f alpha:1.f];
//        _productImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//        _productImageView.layer.borderWidth = 1.f;
        _productImageView.layer.masksToBounds = YES;
        _productImageView.layer.cornerRadius = 3.f;
        [self.contentView addSubview:_productImageView];
    }
    return _productImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:14.f];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)introLabel
{
    if (!_introLabel) {
        _introLabel = [[UILabel alloc] init];
        _introLabel.backgroundColor = [UIColor clearColor];
        _introLabel.textColor = [UIColor darkGrayColor];
        _introLabel.font = [UIFont systemFontOfSize:12.f];
        _introLabel.numberOfLines = 0;
        [self.contentView addSubview:_introLabel];
    }
    return _introLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textColor = [UIColor colorRGBWithRed:237.f green:99.f blue:133.f alpha:1.f];
        _priceLabel.font = [UIFont systemFontOfSize:14.f];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}
- (UIButton *)buyButton
{
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _buyButton.backgroundColor = [UIColor clearColor];
        [_buyButton setBackgroundImage:[UIImage imageNamed:@"icon_addcart"] forState:UIControlStateNormal];
//        [_buyButton setTitle:@"立即\n购买" forState:UIControlStateNormal];
//        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _buyButton.titleLabel.numberOfLines = 2;
//        _buyButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [self.contentView addSubview:_buyButton];
    }
    return _buyButton;
}

- (void)setCellHeight
{
    [self layoutSubviews];
    
    CGFloat height = self.nameLabel.frame.size.height + self.introLabel.frame.size.height + 70.f;
    
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    原来高度为112
    _productImageView.frame = CGRectMake(17.f, 15.f, 132.f, 103.f);
    
//    CGSize titleSize = [self.nameLabel.text sizeWithFont:[UIFont systemFontOfSize:14.f]
//                                   constrainedToSize:CGSizeMake(200.f, 500.f)
//                                       lineBreakMode:NSLineBreakByWordWrapping];
    CGSize titleSize = [self.nameLabel.text boundingRectWithSize:CGSizeMake(200.f, 500.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
    CGFloat titleHeight = 0;
    if (titleSize.height < 30.f) {
        titleHeight = 30.f;
    }else{
        titleHeight = titleSize.height;
    }
    self.nameLabel.frame = CGRectMake(160.f, 15.f, kScreenWidth - 168.f, titleHeight);
    
//    CGSize introSize = [self.introLabel.text sizeWithFont:[UIFont systemFontOfSize:12.f]
//                                   constrainedToSize:CGSizeMake(200.f, 500.f)
//                                       lineBreakMode:NSLineBreakByWordWrapping];
    CGSize introSize = [self.introLabel.text boundingRectWithSize:CGSizeMake(200.f, 500.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} context:nil].size;
    CGFloat introHeight = 0;
    if (introSize.height < 30.f) {
        introHeight = 30.f;
    }else{
        introHeight = introSize.height;
    }
    self.introLabel.frame = CGRectMake(160.f, CGRectGetMaxY(_nameLabel.frame) + 5.f, kScreenWidth - 168.f, introHeight);
    
    self.priceLabel.frame = CGRectMake(160.f, CGRectGetMaxY(self.introLabel.frame) + 5.f, 100.f, 40.f);
    self.priceLabel.adjustsFontSizeToFitWidth = YES;
    
    self.buyButton.frame = CGRectMake(kScreenWidth - 60.f, CGRectGetMaxY(self.introLabel.frame) + 15.f, 40.f, 25.f);
    
    if ([self.priceLabel.text length] > 0) {
        NSMutableAttributedString *priceAttrString = [[NSMutableAttributedString alloc] initWithString:self.priceLabel.text];
        [priceAttrString setAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20.f]}
                                 range:NSMakeRange(1.f, [self.priceLabel.text length] - 1.f)];
        self.priceLabel.attributedText = priceAttrString;
    }else{
        self.priceLabel.text = @"";
    }
}

@end
