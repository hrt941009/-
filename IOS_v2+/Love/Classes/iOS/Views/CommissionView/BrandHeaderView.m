//
//  BrandHeaderView.m
//  Love
//
//  Created by 李伟 on 14/11/10.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "BrandHeaderView.h"

@implementation BrandHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"BrandHeaderView" owner:self options:nil];
        self = [array lastObject];
        
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}

@end
