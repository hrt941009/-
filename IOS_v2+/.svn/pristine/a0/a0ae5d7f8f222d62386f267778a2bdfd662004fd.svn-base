//
//  DresserHomePageHeaderView.m
//  Love
//
//  Created by lee wei on 15/2/1.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "DresserHomePageHeaderView.h"

@implementation DresserHomePageHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"DresserHomePageHeaderView" owner:nil options:nil];
        self = array[0];
        
        _bgImageView.userInteractionEnabled = YES;
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _addressLabel.numberOfLines = 2;
        _introLabel.numberOfLines = 3;
        _funsLabel.adjustsFontSizeToFitWidth = YES;
        _publishLabel.adjustsFontSizeToFitWidth = YES;
        
        [_funsButton setTitle:MyLocalizedString(@"粉丝") forState:UIControlStateNormal];
//        [_funsButton setImage:[UIImage imageNamed:@"brand_follow_num"] forState:UIControlStateNormal];
        [_publishButton setTitle:MyLocalizedString(@"已分享") forState:UIControlStateNormal];
//        [_publishButton setImage:[UIImage imageNamed:@"brand_push_num"] forState:UIControlStateNormal];
        
        _iconView.frame = CGRectMake((kScreenWidth - 75)/2, 20, 75, 75);
        _followButton.frame = CGRectMake((kScreenWidth - 100)/2, 100, 100, 30);
        _funsButton.frame = CGRectMake((kScreenWidth - 155)/2, 135, 30, 20);
        _funsLabel.frame = CGRectMake(_funsButton.frame.origin.x + 35, 135, 40, 20);
        _line1.frame = CGRectMake(_funsLabel.frame.origin.x + 42, 140, 1, 10);
        _publishButton.frame = CGRectMake(_line1.frame.origin.x + 5, 135, 40, 20);
        _publishLabel.frame = CGRectMake(_publishButton.frame.origin.x + 42, 135, 40, 20);
        
        _levelImageView.hidden = YES;
        _nameLabel.hidden = YES;
        _addressLabel.hidden = YES;
        _introLabel.hidden = YES;
        _line2.hidden = YES;
        _line3.hidden = YES;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    _bgImageView.frame = CGRectMake(0, 0, kScreenWidth, 165);
//    _nameLabel.frame = CGRectMake(99, 8, kScreenWidth - 109, 24);
//    _addressLabel.frame = CGRectMake(99, 33, kScreenWidth - 109, 34);
//    _introLabel.frame = CGRectMake(99, 68, kScreenWidth - 109, 42);
//    _line1.frame = CGRectMake(8, 116, kScreenWidth - 16, 2);
//    _line2.frame = CGRectMake((kScreenWidth - 30)/3, 122, 2, 36);
//    _line3.frame = CGRectMake((2 * (kScreenWidth - 30)/3), 122, 2, 36);
//    _funsLabel.frame = CGRectMake(((kScreenWidth - 30)/3 - 56)/2, 122, 56, 18);
//    _funsButton.frame = CGRectMake(((kScreenWidth - 30)/3 - 56)/2, 138, 54, 27);
//    _publishLabel.frame = CGRectMake((kScreenWidth - 30)/2 - 56/2, 122, 56, 18);
//    _publishButton.frame = CGRectMake((kScreenWidth - 30)/2 - 80/2, 138, 80, 27);
//    _followButton.frame = CGRectMake(5 * kScreenWidth / 6 - 80/2 - 10, 123, 80, 34);
    
}

@end
