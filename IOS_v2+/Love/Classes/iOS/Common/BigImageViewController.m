//
//  BigImageViewController.m
//  Love
//
//  Created by lee wei on 14-7-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "BigImageViewController.h"
#import "UIImageView+WebCache.h"

@interface BigImageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation BigImageViewController

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (UIImage *)imageViewSizeWithImageArray:(NSArray *)imageArray forIndex:(NSInteger)index;
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:imageArray[index]
                 placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    //CGSize imageSize = CGSizeMake(imageView.image.size.width, imageView.image.size.height);
    return imageView.image;
}


/**
 购买
 
 @param  imageArray  图片地址数组
 @param  tag         选中图片标识
 */
- (void)getImageArray:(NSArray *)imageArray selectedImageViewTag:(NSInteger)tag
{
    
    NSUInteger imageCount = [imageArray count];
//    CGSize imageSize = CGSizeMake(CGRectGetWidth(self.view.frame), 400.f);
//    UIImageView *imageView = nil;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    CGSize backgroundSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height);

    
    CGSize sizePageControl = CGSizeMake(300.f, 40.f);
    CGRect framePageControl = CGRectMake((_scrollView.frame.size.width - sizePageControl.width)/2, backgroundSize.height + 30.f, sizePageControl.width, sizePageControl.height);
    _pageControl = [[UIPageControl alloc] initWithFrame:framePageControl];
    _pageControl.hidesForSinglePage = YES;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = [imageArray count];
    [self.view addSubview:_pageControl];
    
    
    
    _scrollView.contentSize = CGSizeMake(backgroundSize.width * imageCount, backgroundSize.height);
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.frame) * tag, 0) animated:YES];
    _scrollView.bouncesZoom = NO;
    _pageControl.currentPage = tag;
//    for (NSUInteger i = 0; i < imageCount; i++) {
//        
//        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + i * imageSize.width, 40.f, imageSize.width, imageSize.height)];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]]
//                     placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
//        imageView.backgroundColor = [UIColor clearColor];
//        imageView.userInteractionEnabled = YES;
//        [_scrollView addSubview:imageView];
//        
//        
//        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTapped)];
//        [imageView addGestureRecognizer:tgr];
//    }

    UIView *imageBackgroundView = nil;
    UIImageView *imageView = nil;
    for (NSUInteger i = 0; i < imageCount; i++) {
        imageBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(i * backgroundSize.width, 0, backgroundSize.width, backgroundSize.height)];
        imageBackgroundView.backgroundColor = [UIColor GitHub];
        [_scrollView addSubview:imageBackgroundView];
        
        UIImage *image = [self imageViewSizeWithImageArray:imageArray forIndex:i];
        
        CGSize imageSize = CGSizeMake(image.size.width, image.size.height);
        CGFloat imageViewWidth = 0;
        CGFloat imageViewHeight = 0;
        if (imageSize.width/backgroundSize.width >= 1) {
            imageViewWidth = backgroundSize.width;
            imageViewHeight = (backgroundSize.width/imageSize.width) * imageSize.height;
            if (imageViewHeight/backgroundSize.height >=1) {
                imageViewHeight = backgroundSize.height;
                imageViewWidth = (backgroundSize.height/imageSize.height) * imageSize.width;
            }
        }else {
            if (imageViewHeight/backgroundSize.height >=1) {
                imageViewHeight = backgroundSize.height;
                imageViewWidth = (backgroundSize.height/imageSize.height) * imageSize.width;
            }else{
                imageViewWidth = imageSize.width;
                imageViewHeight = imageSize.height;
            }
        }
        NSLog(@"imageViewSizeWithImageArray = %f, %f", imageViewWidth, imageViewHeight);
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake((backgroundSize.width - imageViewWidth)/2, (backgroundSize.height - imageViewHeight)/2, imageViewWidth, imageViewHeight)];
        [imageView sd_setImageWithURL:imageArray[i]
                     placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        [imageBackgroundView addSubview:imageView];
        [_scrollView addSubview:imageBackgroundView];
        
        
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTapped)];
        [_scrollView addGestureRecognizer:tgr];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backTapped
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(_scrollView.contentOffset.x/_scrollView.frame.size.width);
    
    _pageControl.currentPage = index;
}

@end
