//
//  FollowTableViewCell.m
//  Love
//
//  Created by lee wei on 14-7-15.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "FollowTableViewCell.h"
#import "LOVCircle.h"
#import "MyFollowModel.h"
#import "UIImageView+WebCache.h"



@implementation FollowTableViewCell

- (void)awakeFromNib
{
    _statusLabel.layer.borderColor = [[UIColor clearColor] CGColor];
    _statusLabel.layer.borderWidth = 1.f;
    _statusLabel.layer.cornerRadius = 4.f;
    _statusLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setMyFollow:(MyFollowModel *)myFollow
{
    _myFollow = myFollow;
    LOVCircle *iv = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, 45.f, 45.f)
                                       imageWithPath:_myFollow.header
                                    placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    [_iconView addSubview:iv];
    [_flagImageView sd_setImageWithURL:[NSURL URLWithString:_myFollow.flag]
                      placeholderImage:[UIImage imageNamed:kDefalutFlagImageDownload]];
    
    _sellerNameLabel.text = myFollow.sellerName;
    _infoLabel.text = myFollow.sellerDescription;
    _liveTimeLabel.text = myFollow.shoppingLiveTime;
    _likeLabel.text = myFollow.follow;
    _photoLabel.text = myFollow.photos;
    _liveLabel.text = myFollow.live;
    if ([myFollow.status intValue]== 0) {
        _statusLabel.text = @"暂无直播";
    }
    if ([myFollow.status intValue] == 1) {
        _statusLabel.text = @"直播中";
    }
    if ([myFollow.status intValue] == 2) {
        _statusLabel.text = @"直播中";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cancelFollowSellerAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [_delegate cancelFollowButton:button];
}

@end
