//
//  BuyDetailTableViewCell.m
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "BuyDetailTableViewCell.h"
#import "BuyBackgroundView.h"

@implementation BuyDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        BuyBackgroundView *bgView = [[BuyBackgroundView alloc] initWithFrame:CGRectMake(5.f, 0, self.frame.size.width - 10.f, 60.f)];
        [self.contentView addSubview:bgView];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 0, bgView.frame.size.width - 10.f, bgView.frame.size.height)];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.text = MyLocalizedString(@"购买提示");
        detailLabel.textColor = [UIColor darkGrayColor];
        detailLabel.font = [UIFont systemFontOfSize:14.f];
        detailLabel.numberOfLines = 4;
        [bgView addSubview:detailLabel];
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

@end
