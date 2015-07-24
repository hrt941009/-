//
//  LOVGuardView.m
//  Love
//
//  Created by 李伟 on 14-6-27.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LOVGuardView.h"
#import "UIImage+iPhone5.h"

@implementation LOVGuardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *first = [userDefaults objectForKey:@"first-start"];
        
        //如果第一次启动 显示引导界面
        if ([first length] == 0) {
            _pages = 3;        //页数
            
            //-----
            float screenHeight = self.frame.size.height;
            float screenWidth = self.frame.size.width;
            
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            scrollView.backgroundColor = [UIColor clearColor];
            scrollView.contentSize = CGSizeMake(screenWidth * _pages, screenHeight);
            scrollView.pagingEnabled = YES;
            scrollView.scrollEnabled = YES;
            scrollView.scrollsToTop = NO;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.delegate = self;
            [self addSubview:scrollView];
            
            for (NSUInteger i = 0; i < _pages; i++) {
                _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + i * screenWidth, 0, screenWidth, screenHeight)];
                _imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guard%ld", (unsigned long)i + 1]];
                //[UIImage imageNamedWithiPhone5:[NSString stringWithFormat:@"%d", i + 1] imageTyped:@"jpg"];// [UIImage imageNamed:@"guard1.png"];//[NSString stringWithFormat:@"guard%ld.jpg", (unsigned long)i + 1]];
                //
                _imgView.userInteractionEnabled = YES;
                [scrollView addSubview:_imgView];
                
                _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
                _startButton.backgroundColor = [UIColor clearColor];
                _startButton.alpha = 1;
                _startButton.frame = CGRectMake((screenWidth-200.f)/2, screenHeight - 100.f, 200.f, 90.f);
                [_startButton addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
                [_imgView addSubview:_startButton];
            }
        }
    }
    return self;
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
//    CGPoint trans = scrollView.contentOffset;
//    if (trans.x == screenWidth * 4) {
//        _startButton.alpha = 1;
//    }
}


#pragma mark - button
- (void)startAction:(id)sender
{
    [_imgView removeFromSuperview];
    [_startButton removeFromSuperview];
    
    [_delegate startApp];
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
