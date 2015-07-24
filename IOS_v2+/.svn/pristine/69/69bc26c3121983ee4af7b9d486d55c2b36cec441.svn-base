//
//  UIButton+Block.m
//  CSLCLottery
//
//  Created by 李伟 on 13-1-25.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import "UIButton+Block.h"

@implementation UIButton(Block)

static char overviewKey;

@dynamic event;

- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}


- (void)callActionBlock:(id)sender {
    __strong ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}


@end
