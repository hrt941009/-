//
//  TextColorLabel.h
//  CSLCLottery
//
//  Created by 李伟 on 13-4-12.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface TextColorLabel : UILabel

@property (nonatomic ,strong)  UIColor *stringColor;//CGColorRef
@property (nonatomic ,strong)  UIColor *keywordColor;
//@property (nonatomic ,strong)  NSMutableArray *list;

@property (nonatomic ,assign) int keywordLen;

//-(id) initWithStringColor:(UIColor *)strColor keyColor:(UIColor *)keyColor;

//设置字符串颜色和关键字颜色
- (void) cnv_setUIlabelTextColor:(UIColor *) strColor andKeyWordColor: (UIColor *) keyColor;

//设置显示的字符串和关键字。即将显示时调用此函数。
- (void) cnv_setUILabelText:(NSString *)string andKeyWord:(NSString *)keyword;

//将关键字的位置和长度，存放在list中。
//- (void) saveKeywordRangeOfText:(NSString *)keyWord;


@end
