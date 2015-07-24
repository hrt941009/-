//
//  MCPagerView.m
//  MCPagerView
//
//  Created by Baglan on 7/20/12.
//  Copyright (c) 2012 MobileCreators. All rights reserved.
//

#import "MCPagerView.h"
#import "LOVCircle.h"

static NSString * const kPlaceholderImageName = @"icon_pic.png";

@implementation MCPagerView {
    NSMutableDictionary *_images;
    NSMutableArray *_pageViews;
}

@synthesize page = _page;
@synthesize pattern = _pattern;
@synthesize delegate = _delegate;

- (void)commonInit
{
    _page = 0;
    _imgViewWidth = 50.f;
    _imgViewHeight = 50.f;
    _pattern = @"";
    _images = [NSMutableDictionary dictionary];
    _pageViews = [NSMutableArray array];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        
    }
    return self;
}

- (void)scrollPages
{
    NSLog(@" ------- ");
    [self setNeedsLayout];

}

- (void)setPage:(NSInteger)page
{
    // Skip if delegate said "do not update"
    if ([_delegate respondsToSelector:@selector(pageView:shouldUpdateToPage:)] && ![_delegate pageView:self shouldUpdateToPage:page]) {
        return;
    }
    
    _page = page;
    [self setNeedsLayout];
    
    // Inform delegate of the update
    if ([_delegate respondsToSelector:@selector(pageView:didUpdateToPage:)]) {
        [_delegate pageView:self didUpdateToPage:page];
    }
    
    // Send update notification
    [[NSNotificationCenter defaultCenter] postNotificationName:MCPAGERVIEW_DID_UPDATE_NOTIFICATION object:self];
}

- (NSInteger)numberOfPages
{
    return _pattern.length;
}

- (void)tapped:(UITapGestureRecognizer *)recognizer
{
    self.page = [_pageViews indexOfObject:recognizer.view];
}

- (LOVCircle *)imageViewForKey:(NSString *)key frame:(CGRect)frame
{
    NSDictionary *pathData = [_images objectForKey:key];
    NSString *path = [pathData objectForKey:@"downloadPath"];
    LOVCircle *imageView = [[LOVCircle alloc] initWithFrame:frame imageWithPath:path
                                           placeholderImage:[UIImage imageNamed:kPlaceholderImageName]];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [imageView addGestureRecognizer:tgr];
    
    return imageView;
}


- (void)layoutSubviews
{
    [_pageViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIView *view = obj;
        [view removeFromSuperview];
    }];
    [_pageViews removeAllObjects];
    
    CGFloat multiple = 0.6;
    NSInteger pages = self.numberOfPages;

    CGFloat xOffset = self.frame.size.width - _imgViewWidth * pages  - 10.f;;
    for (int i=0; i<pages; i++) {
        NSString *key = [_pattern substringWithRange:NSMakeRange(i, 1)];

        if (i != self.page) {
            LOVCircle *imageView = [self imageViewForKey:key frame:CGRectMake(0, (self.frame.size.height - _imgViewHeight * multiple)/4, _imgViewWidth * multiple, _imgViewHeight * multiple)];
            
            CGRect frame = imageView.frame;
            frame.origin.x = xOffset;
            imageView.frame = frame;
            //imageView.highlighted = (i == self.page);
            
            [self addSubview:imageView];
            [_pageViews addObject:imageView];
            
            xOffset = xOffset + frame.size.width  + 10.f;
            
        }else{
            LOVCircle *imageView = [self imageViewForKey:key frame:CGRectMake(0, (self.frame.size.height - _imgViewHeight)/2, _imgViewWidth, _imgViewHeight)];
            
            CGRect frame = imageView.frame;
            frame.origin.x = xOffset;
            imageView.frame = frame;
            //imageView.highlighted = (i == self.page);
            
            [self addSubview:imageView];
            [_pageViews addObject:imageView];
            
            xOffset = xOffset + frame.size.width  + 10.f;
        }
    }
}

- (void)setImagePath:(NSString *)path forKey:(NSString *)key
{
    NSDictionary *imageData = [NSDictionary dictionaryWithObjectsAndKeys:path, @"downloadPath", nil];
    [_images setObject:imageData forKey:key];
    [self setNeedsLayout];
}

@end
