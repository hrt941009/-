//
//  LOVPhotoScrollView.m
//  Love
//
//  Created by lee wei on 14-10-9.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LOVPhotoScrollView.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "GenerationImage.h"

@implementation LOVPhotoScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
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

- (void)setImagePathArray:(NSArray *)imageArray
{
    //-------- 商品图片
    UIScrollView *photoView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    photoView.backgroundColor = [UIColor clearColor];
    photoView.delegate = self;
    photoView.pagingEnabled = YES;
    photoView.scrollEnabled = YES;
    photoView.scrollsToTop = NO;
    photoView.showsHorizontalScrollIndicator = NO;
    photoView.showsVerticalScrollIndicator = NO;
    [self addSubview:photoView];
    //----
    
    NSUInteger imageCount = [imageArray count];
    CGSize backgroundSize = CGSizeMake(photoView.frame.size.width, photoView.frame.size.height);
    UIView *imageBackgroundView = nil;
    UIImageView *imageView = nil;
    
    if (imageCount > 0) {
        photoView.contentSize = CGSizeMake(backgroundSize.width * imageCount, backgroundSize.height);
        for (NSUInteger i = 0; i < imageCount; i++) {
            imageBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(i * backgroundSize.width, 0, backgroundSize.width, backgroundSize.height)];
            imageBackgroundView.backgroundColor = [UIColor clearColor];
            imageBackgroundView.userInteractionEnabled = YES;
            [photoView addSubview:imageBackgroundView];
            
            CGFloat imageViewWidth = 0;
            CGFloat imageViewHeight = 0;
            imageViewWidth = imageBackgroundView.frame.size.width;
            imageViewHeight = imageBackgroundView.frame.size.height;
            
            imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:imageArray[i]
                         placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            
            [imageView setFrame:CGRectMake( 0, 0, imageViewWidth, imageViewHeight)];
            [imageView setCenter:CGPointMake(imageViewWidth/2, imageViewHeight/2)];
            imageView.userInteractionEnabled = YES;
            imageView.layer.masksToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.tag = i;
            
            [imageBackgroundView addSubview:imageView];
            [photoView addSubview:imageBackgroundView];
            
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
            [imageView addGestureRecognizer:tgr];
        }
    }else{
        photoView.contentSize = CGSizeMake(backgroundSize.width, backgroundSize.height);
        UIImage *image = [UIImage imageNamed:kDefalutCommodityImageDownload];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, backgroundSize.width, backgroundSize.height);
        imageView.backgroundColor = [UIColor clearColor];
        imageView.userInteractionEnabled = YES;
        [photoView addSubview:imageView];
    }
    
    CGSize sizePageControl = CGSizeMake(photoView.frame.size.width, 20.f);
    
    CGFloat pcOriginX = (self.frame.size.width - sizePageControl.width)/2;
    CGFloat pcOriginY = CGRectGetMaxY(photoView.frame) - sizePageControl.height;
    
    CGRect framePageControl = CGRectMake(pcOriginX, pcOriginY, sizePageControl.width, sizePageControl.height);
    pageControl = [[UIPageControl alloc] initWithFrame:framePageControl];
    pageControl.hidesForSinglePage = YES;
    pageControl.userInteractionEnabled = NO;
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.numberOfPages = [imageArray count];
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
}

- (void)imageViewTapped:(UITapGestureRecognizer *)recognizer
{
    [_delegate getImageViewTag:recognizer.view.tag];
}

- (void)setFullScreenImagePathArray:(NSArray *)imageArray
{
    //-------- 商品图片
    UIScrollView *photoView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    photoView.backgroundColor = [UIColor clearColor];
    photoView.delegate = self;
    photoView.pagingEnabled = YES;
    photoView.scrollEnabled = YES;
    photoView.scrollsToTop = NO;
    photoView.showsHorizontalScrollIndicator = NO;
    photoView.showsVerticalScrollIndicator = NO;
    [self addSubview:photoView];
    
    
    //----
    NSUInteger imageCount = [imageArray count];
    CGSize imageSize = CGSizeMake(photoView.frame.size.width, photoView.frame.size.height);
    
    UIImageView *imageView = nil;
    
    if (imageCount > 0) {
        photoView.contentSize = CGSizeMake(imageSize.width * imageCount, imageSize.height);
        for (NSUInteger i = 0; i < imageCount; i++) {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + i * imageSize.width, 0, imageSize.width, imageSize.height)];
//            [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]]
//                         placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                UIImage *tempImg = [GenerationImage scaleImage:image size:CGSizeMake(imageSize.width, (image.size.height/image.size.width)*imageSize.width)];
                imageView.image = [GenerationImage cutImage:tempImg];
            }];
            imageView.backgroundColor = [UIColor clearColor];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            [photoView addSubview:imageView];
            
            UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(liveImageViewTapped:)];
            [imageView addGestureRecognizer:tgr];
        }
    }else{
        photoView.contentSize = CGSizeMake(imageSize.width, imageSize.height);
        UIImage *image = [UIImage imageNamed:kDefalutCommodityImageDownload];
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
        imageView.backgroundColor = [UIColor clearColor];
        imageView.userInteractionEnabled = YES;
        [photoView addSubview:imageView];
    }
    
    CGSize sizePageControl = CGSizeMake(photoView.frame.size.width, 20.f);
    
    CGFloat pcOriginX = (self.frame.size.width - sizePageControl.width)/2;
    CGFloat pcOriginY = CGRectGetMaxY(photoView.frame) - sizePageControl.height;
    
    CGRect framePageControl = CGRectMake(pcOriginX, pcOriginY, sizePageControl.width, sizePageControl.height);
    pageControl = [[UIPageControl alloc] initWithFrame:framePageControl];
    pageControl.hidesForSinglePage = YES;
    pageControl.userInteractionEnabled = NO;
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.numberOfPages = [imageArray count];
    pageControl.currentPage = 0;
    [self addSubview:pageControl];
}


- (void)liveImageViewTapped:(UITapGestureRecognizer *)recognizer
{
    [_delegate getImageViewTag:recognizer.view.tag];
}

#pragma mark - scroll view delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(scrollView.contentOffset.x/scrollView.frame.size.width);
    
    pageControl.currentPage = index;
}



@end
