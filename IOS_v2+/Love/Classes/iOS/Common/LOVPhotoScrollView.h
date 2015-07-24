//
//  LOVPhotoScrollView.h
//  Love
//
//  Created by lee wei on 14-10-9.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LOVPhotoScrollViewDelegate <NSObject>

@optional
- (void)getImageViewTag:(NSInteger)tag;

@end

@interface LOVPhotoScrollView : UIView <UIScrollViewDelegate>
{
    UIPageControl *pageControl;
}

@property (nonatomic, weak) id<LOVPhotoScrollViewDelegate> delegate;

- (void)setImagePathArray:(NSArray *)imageArray;

- (void)setFullScreenImagePathArray:(NSArray *)imageArray;

@end
