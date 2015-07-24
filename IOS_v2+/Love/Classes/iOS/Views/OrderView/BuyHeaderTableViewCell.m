//
//  BuyHeaderTableViewCell.m
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "BuyHeaderTableViewCell.h"

@implementation BuyHeaderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImage *headerImage = [UIImage imageNamed:@"order_head.png"];
        CGFloat headerWidth = headerImage.size.width;
        CGFloat headerHeight = headerImage.size.height;
        
//        
//        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), headerHeight + 22.f)];
//        headerView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *headerImageView = [[UIImageView alloc] initWithImage:headerImage];
        headerImageView.frame = CGRectMake((self.frame.size.width - headerWidth)/2, 6.f, headerWidth, headerHeight);
        headerImageView.backgroundColor = [UIColor clearColor];
        
        //[headerView addSubview:headerImageView];
        [self.contentView addSubview:headerImageView];
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
