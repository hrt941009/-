//
//  UserHomeHeaderView.m
//  Love
//
//  Created by use on 15-3-18.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "UserHomeHeaderView.h"

@implementation UserHomeHeaderView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _iconImageView = [[UIView alloc] init];
        _iconImageView.frame = CGRectMake((self.frame.size.width - 75)/2, 20, 75, 75);
        _iconImageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_iconImageView];
        
        _attentButton = [[UIButton alloc] init];
        _attentButton.frame = CGRectMake((self.frame.size.width - 100)/2, 100, 100, 30);
        _attentButton.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_attentButton];
        
        _fans = [[UILabel alloc] init];
        _fans.frame = CGRectMake((kScreenWidth - 155)/2, 135, 30, 20);
        _fans.backgroundColor = [UIColor clearColor];
        _fans.textColor = [UIColor whiteColor];
        _fans.text = MyLocalizedString(@"粉丝");
        _fans.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:_fans];
        
        _fasnNumber = [[UILabel alloc] init];
        _fasnNumber.frame = CGRectMake(_fans.frame.origin.x + 35, 135, 40, 20);
        _fasnNumber.backgroundColor = [UIColor clearColor];
        _fasnNumber.textColor = [UIColor whiteColor];
        _fasnNumber.font = [UIFont systemFontOfSize:13.f];
        _fasnNumber.text = @"500";
        _fasnNumber.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_fasnNumber];
        
        _lineView = [[UIView alloc] init];
        _lineView.frame = CGRectMake(_fasnNumber.frame.origin.x + 42, 140, 1, 10);
        _lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_lineView];
        
        _shared = [[UILabel alloc] init];
        _shared.frame = CGRectMake(_lineView.frame.origin.x + 5, 135, 40, 20);
        _shared.text = MyLocalizedString(@"已分享");
        _shared.textColor = [UIColor whiteColor];
        _shared.backgroundColor = [UIColor clearColor];
        _shared.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:_shared];
        
        _shareLabel = [[UILabel alloc] init];
        _shareLabel.frame = CGRectMake(_shared.frame.origin.x + 42, 135, 40, 20);
        _shareLabel.textColor = [UIColor whiteColor];
        _shareLabel.backgroundColor = [UIColor clearColor];
        _shareLabel.font = [UIFont systemFontOfSize:13.f];
        _shareLabel.text = @"680";
        _shareLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_shareLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
