//
//  LOVLoadingView.m
//  Love
//
//  Created by lee wei on 14-9-20.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LOVLoadingView.h"

@implementation LOVLoadingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake(50.f, 0, 30.f, 30.f);
        [_activityView startAnimating];
        [self addSubview:_activityView];
        
        _loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.f, 0, 200.f, 30.f)];
        _loadingLabel.backgroundColor = [UIColor clearColor];
        _loadingLabel.font = [UIFont systemFontOfSize:14.f];
        _loadingLabel.textColor = [UIColor darkGrayColor];
        _loadingLabel.textAlignment = NSTextAlignmentLeft;
        _loadingLabel.text = MyLocalizedString(@"努力加载中...");
        [self addSubview:_loadingLabel];
    }
    return self;
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
