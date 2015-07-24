//
//  LOVSegmentControl.h
//  根据CCSegmentedControl修改
//
//  Created by 李伟 on 14/12/9.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  自定义SegmentControl
//

#import <UIKit/UIKit.h>

@interface LOVSegmentControl : UIControl
{
    @private
    NSMutableArray *_segments;
    UIScrollView *_scrollView;
}

@property (nonatomic, readonly) NSUInteger numberOfSegments;

@property (nonatomic, assign)   NSInteger selectedSegmentIndex;
@property (nonatomic, strong)   UIColor *titleColor;
@property (nonatomic, strong)   UIColor *selectedTitleColor;

- (instancetype)initWithItems:(NSArray *)array;


@end
