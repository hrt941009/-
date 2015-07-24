//
//  MyAddressTableViewCell.m
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MyAddressTableViewCell.h"
#import "BuyBackgroundView.h"

@implementation MyAddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _bgView = [[BuyBackgroundView alloc] initWithFrame:CGRectMake(5.f, 0, self.frame.size.width - 10.f, 40.f)];
        [self.contentView addSubview:_bgView];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0, CGRectGetWidth(_bgView.frame) - 60.f, 40.f)];
        _addressLabel.backgroundColor = [UIColor clearColor];
        _addressLabel.textColor = [UIColor blackColor];
        _addressLabel.text = @"创建地址";
        _addressLabel.font = [UIFont systemFontOfSize:14.f];
        _addressLabel.numberOfLines = 0;
        [_bgView addSubview:_addressLabel];

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

- (CGFloat)setMyAddressCellHeight
{
    CGFloat height = 0;
    
//    CGSize size = [_addressLabel.text sizeWithFont:[UIFont systemFontOfSize:14.f]
//                                constrainedToSize:CGSizeMake(_addressLabel.frame.size.width, 2000)
//                                    lineBreakMode:NSLineBreakByCharWrapping];
    CGSize size = [_addressLabel.text boundingRectWithSize:CGSizeMake(_addressLabel.frame.size.width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
    if (size.height < 40.f) {
        return 40.f;
    }
    
    CGRect addressRect = _addressLabel.frame;
    addressRect.size.height = size.height;
    _addressLabel.frame = addressRect;
    
    CGRect bgViewRect = _bgView.frame;
    bgViewRect.size.height = size.height;
    _bgView.frame = bgViewRect;

    height = _bgView.frame.size.height;

    return height;
}

@end
