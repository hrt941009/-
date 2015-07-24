//
//  SubjectCommissionHeaderView.m
//  Love
//
//  Created by lee wei on 14-9-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SubjectCommissionHeaderView.h"

@implementation SubjectCommissionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SubjectCommissionHeaderView" owner:self options:nil];
        self = [array lastObject];
        
        self.backgroundColor = [UIColor clearColor];
        
        _titleLabel.textColor = [UIColor whiteColor];
//        _iconView = [[UIView alloc] init];
//        _iconView.frame = CGRectMake((kScreenWidth - 60)/2, 10, 60, 60);
//        [self addSubview:_iconView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
     _iconView.frame = CGRectMake((kScreenWidth - 105)/2, 27, 105, 105);
    _titleLabel.frame = CGRectMake(8, 132, kScreenWidth - 16, 30);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
