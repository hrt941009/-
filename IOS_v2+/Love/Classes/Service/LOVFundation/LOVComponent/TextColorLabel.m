//
//  TextColorLabel.m
//  CSLCLottery
//
//  Created by 李伟 on 13-4-12.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import "TextColorLabel.h"

@implementation TextColorLabel

- (id)init {
    
    self = [super init];
    if (self) {
        self.text = nil;
        self.stringColor = nil;
        self.keywordColor = nil;
        self.keywordLen = 1;
        //self.list = [[NSMutableArray alloc] init];
        // Initialization code.
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.text = nil;
        self.stringColor = nil;
        self.keywordColor = nil;
        self.keywordLen = 1;
        //self.list = [[NSMutableArray alloc] init];
        // Initialization code.
        self.numberOfLines = 10;
    }
    return self;
}

//设置字体颜色和关键字的颜色
- (void) cnv_setUIlabelTextColor:(UIColor *) strColor
                 andKeyWordColor: (UIColor *) keyColor
{
    self.stringColor = strColor;
    self.keywordColor = keyColor;
}
//设置关键字，并且调用保存关键字函数将关键字的Range存再list中。
- (void) cnv_setUILabelText:(NSString *)string andKeyWord:(NSString *)keyword
{
    if (self.text != string) {
        self.text = string;
    }
    self.keywordLen = (unsigned int)[keyword length];
    
    //[self saveKeywordRangeOfText:keyword];
}

////保存关键字再Text中的位置信息
//- (void) saveKeywordRangeOfText:(NSString *)keyWord
//{
//    int nLen = [keyWord length];
//    for (int i = 0  ; i < nLen; i++)
//    {
//        //按照所给的位置，长度，从keyword中截取子串
//        NSString *strTemp = [keyWord substringWithRange:NSMakeRange(i, 1)];
//        //获取单个关键字符在text中的位置
//        NSString *strText = self.text;
//        int TextLenth = [strText length];
//        for (int j= 0; j<TextLenth; j++) {
//            NSRange range = NSMakeRange(j,1);
//            NSString * star = [strText substringWithRange:range];
//            if ([star isEqualToString:strTemp]) {
//                //                NSRange range = [strText rangeOfString:star];
//                //由于结构体不能直接存到NSArray中，所以要转换一下。
//                NSValue *value = [NSValue valueWithRange:range];
//
//                if (range.length > 0)
//                {
//                    [self.list addObject:value];
//                }
//            }
//        }
//        NSRange range = [strText rangeOfString:strTemp];
//        //由于结构体不能直接存到NSArray中，所以要转换一下。
//        NSValue *value = [NSValue valueWithRange:range];
//
//        if (range.length > 0)
//        {
//            [self.list addObject:value];
//        }
//
//    }
//
//}


//设置颜色属性和字体属性
- (NSAttributedString *)illuminatedString:(NSString *)text
                                     font:(UIFont *)AtFont{
	
    int len = (unsigned int)[text length];
    int keylen = self.keywordLen;
    if (len - keylen - 1 > 4) {
        //创建一个可变的属性字符串
        NSMutableAttributedString *mutaString = [[[NSMutableAttributedString alloc] initWithString:text] autorelease];
        //改变字符串 从1位 长度为1 这一段的前景色，即字的颜色。
        
        [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName)
                           value:(id)self.stringColor.CGColor
                           range:NSMakeRange(0, len - keylen - 1)];
        
        
        
        if (self.keywordColor != nil)
        {
            [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName)
                               value:(id)self.keywordColor.CGColor
                               range:NSMakeRange(len - keylen, keylen)];
        }
        
        
        //设置是否使用连字属性，这里设置为0，表示不使用连字属性。标准的英文连字有FI,FL.默认值为1，既是使用标准连字。也就是当搜索到f时候，会把fl当成一个文字。
        int nNumType = 0;
        CFNumberRef cfNum = CFNumberCreate(NULL, kCFNumberIntType, &nNumType);
        [mutaString addAttribute:(NSString *)kCTLigatureAttributeName
                           value:(id)cfNum
                           range:NSMakeRange(0, len)];
        
        CTFontRef ctFont2 = CTFontCreateWithName((CFStringRef)AtFont.fontName,
                                                 AtFont.pointSize,
                                                 NULL);
        [mutaString addAttribute:(NSString *)(kCTFontAttributeName)
                           value:(id)ctFont2
                           range:NSMakeRange(0, len)];
        CFRelease(ctFont2);
        return [[mutaString copy] autorelease];

    }
    return nil;
}

//重绘Text
- (void)drawRect:(CGRect)rect
{
    //获取当前label的上下文以便于之后的绘画，这个是一个离屏。
	CGContextRef context = UIGraphicsGetCurrentContext();
    //压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
    //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
	CGContextSaveGState(context);
    //x，y轴方向移动
	CGContextTranslateCTM(context, 0.0, 0.0);/*self.bounds.size.height*/
    
    //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
	CGContextScaleCTM(context, 1, -1);

    //创建一个文本行对象，此对象包含一个字符
	CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)
                                                      [self illuminatedString:self.text font:self.font]);	//[UIFont fontWithName:fontName size:60]
    //设置文字绘画的起点坐标。由于前面沿x轴翻转了（上面那条边）所以要移动到与此位置相同，也可以只改变CGContextSetTextPosition函数y的坐标，效果是一样的只是意义不一样
    CGContextTranslateCTM(context, 0.0, - ceill(self.bounds.size.height) + 4);//加8是稍微调整一下位置，让字体完全现实，有时候y，j下面一点点会被遮盖
	CGContextSetTextPosition(context, 0.0, 0.0); /*ceill(self.bounds.size.height) + 8*/
    //在离屏上绘制line
	CTLineDraw(line, context);
    //将离屏上得内容覆盖到屏幕。此处得做法很像windows绘制中的双缓冲。
	CGContextRestoreGState(context);
	CFRelease(line);
	//CGContextRef	myContext = UIGraphicsGetCurrentContext();
	//CGContextSaveGState(myContext);
	//[self MyColoredPatternPainting:myContext rect:self.bounds];
	//CGContextRestoreGState(myContext);
}


@end
