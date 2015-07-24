//
//  UIButton+Block.h
//  CSLCLottery
//
//  Created by 李伟 on 13-1-25.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


typedef void (^ActionBlock)();

@interface UIButton(Block)

@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;

@end
