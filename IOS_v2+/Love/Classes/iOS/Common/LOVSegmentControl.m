//
//  LOVSegmentControl.m
//  CustomTabBar
//
//  Created by 李伟 on 14/12/9.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LOVSegmentControl.h"

@implementation LOVSegmentControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)array
{
    self = [super init];
    if (self) {
        _segments = [[NSMutableArray alloc] init];
        _titleColor = [UIColor darkGrayColor];
        _selectedTitleColor = [UIColor colorWithRed:230.f/255.f green:60.f/255.f blue:103.f/255.f alpha:1.f];
        _selectedSegmentIndex = -1;
        
        
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        NSInteger endIndex = [array count]-1;
        __weak typeof(self) weakSelf = self;
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx == endIndex) {
                [weakSelf insertSegmentTitle:(NSString *)obj forSegmentAtIndex:idx animated:YES];
            }else{
                [weakSelf insertSegmentTitle:(NSString *)obj forSegmentAtIndex:idx animated:NO];
            }
        }];
    }
    return self;
}

- (void)insertSegmentTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated
{
    UILabel *segmentLabel = [[UILabel alloc] init];
    segmentLabel.alpha = 0;
    segmentLabel.text = title;
    segmentLabel.textColor = self.titleColor;
    segmentLabel.font = [UIFont boldSystemFontOfSize:14];
    segmentLabel.backgroundColor = [UIColor clearColor];
    segmentLabel.userInteractionEnabled = YES;
    segmentLabel.adjustsFontSizeToFitWidth = YES;
    segmentLabel.textAlignment = NSTextAlignmentCenter;
    [segmentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelSelect:)]];
    [segmentLabel sizeToFit];
    
    
    NSUInteger index = MAX(MIN(segment, self.numberOfSegments), 0);
    if (index < _segments.count) {
        UIView* itemView = (UIView *)_segments[index];
        segmentLabel.center = itemView.center;
        [self insertSubview:segmentLabel belowSubview:_segments[index]];
        [_segments insertObject:segmentLabel atIndex:index];
    } else {
        //新增到最后的 item
        segmentLabel.center = self.center;
        [self addSubview:segmentLabel];
        [_segments addObject:segmentLabel];
    }
    
    //重新调整选中 item 的下标
    if (self.selectedSegmentIndex >= index) {
        self.selectedSegmentIndex++;
    }
    
    if (animated) {
        [UIView animateWithDuration:0.4 animations:^{
            [self layoutSubviews];
         }];
    } else {
        [self setNeedsLayout];
    }
}


- (void)labelSelect:(UIGestureRecognizer *)gestureRecognizer
{
    NSUInteger index = [_segments indexOfObject:gestureRecognizer.view];
    if (index != NSNotFound) {
        self.selectedSegmentIndex = index;
        [self setNeedsLayout];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}


//设定子视图的大小和位置
- (void)layoutSubviews
{
    CGFloat totalItemWidth = 0;
    for (UIView *item in _segments)
    {
        float itemWidth = CGRectGetWidth(item.bounds);
        totalItemWidth += itemWidth;
    }
    
    CGFloat interItemSpace = 5.f;//spaceLeft / (CGFloat)(_segments.count + 1);
    
    __block CGFloat pos = interItemSpace;
    
    [_segments enumerateObjectsUsingBlock:^(UILabel *item, NSUInteger idx, BOOL *stop) {
        item.alpha = 1;
        CGFloat width = (self.frame.size.width - 5 * ([_segments count] + 1))/[_segments count]; //rect.size.width;
        item.frame = CGRectMake(pos, 0, width, self.frame.size.height);
        pos += CGRectGetWidth(item.bounds) + interItemSpace;
    }];
    
    if (self.selectedSegmentIndex == -1) {
        
    } else {
        UIView *selectedIndex = _segments[self.selectedSegmentIndex];
        NSInteger arrCount = [_segments count];
        for (int i = 0; i < arrCount; i++) {
            UILabel *label = _segments[i];
            if (label == selectedIndex) {
                CGRect labelRect = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, label.frame.size.height)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.f]}
                                                            context:nil];
                CGFloat lineWidth = labelRect.size.width + 12.f;
                CGFloat lineX = (label.frame.size.width - lineWidth)/2;
                CGFloat lineY = label.frame.size.height - 6.f;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, lineY, lineWidth, 2.f)];
                lineView.backgroundColor = [UIColor colorRGBWithRed:221.f green:1.f blue:65.f alpha:1.f];
                label.textColor = self.selectedTitleColor;
                label.font = [UIFont boldSystemFontOfSize:14];
                label.layer.masksToBounds = YES;
                [label addSubview:lineView];
                /*
                 NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
                 [attributedString setAttributes:@{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}
                 range:NSMakeRange(0, [label.text length])];
                 label.attributedText = attributedString;
                 */
            } else {
                label.textColor = self.titleColor;
                label.font = [UIFont boldSystemFontOfSize:14];
                for (id view in [label subviews]) {
                    if ([view isKindOfClass:[UIView class]]) {
                        [view removeFromSuperview];
                    }
                }
                /*
                 NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
                 [attributedString setAttributes:@{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleNone]}
                 range:NSMakeRange(0, [label.text length])];
                 label.attributedText = attributedString;
                 */
            }
        }
        /*
        for (UILabel *label in _segments) {
            
        }
         */
    }
}


- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    if (_selectedSegmentIndex != selectedSegmentIndex) {
        _selectedSegmentIndex = selectedSegmentIndex;
        [self setNeedsLayout];
    }
}

- (NSUInteger)numberOfSegments
{
    return [_segments count];
}

@end
