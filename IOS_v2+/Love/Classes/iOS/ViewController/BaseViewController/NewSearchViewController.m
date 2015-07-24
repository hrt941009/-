//
//  NewSearchViewController.m
//  Love
//
//  Created by use on 15-1-16.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "NewSearchViewController.h"
#import "SearchResultViewController.h"
#import "SearchKeyWordModel.h"
#import "POP.h"

@interface NewSearchViewController ()
{
    int nextPage;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isFirst;
@end

@implementation NewSearchViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        _isFirst = YES;
        nextPage = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60.f, 40.f)];
    label.backgroundColor = [UIColor clearColor];
    label.text = MyLocalizedString(@"热门搜索");
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15.f];
    UIBarButtonItem *leftLabel = [[UIBarButtonItem alloc] initWithCustomView:label];
    [self.navigationItem setLeftBarButtonItem:leftLabel];
    
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 60.f, 40.f);
    searchButton.backgroundColor = [UIColor clearColor];
    [searchButton setTitle:MyLocalizedString(@"Cancel") forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [searchButton addTarget:self action:@selector(cancleAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchBarButton = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    [self.navigationItem setRightBarButtonItem:searchBarButton animated:YES];
    
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(chageAction:)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeRecognizer];
    
    [SearchKeyWordModel searchKeyWordData:@"1" pageNumber:@"50" block:^(NSMutableArray *dataArray) {
        if ([dataArray count] > 0) {
            _dataArray = dataArray;
            [self changeSearchKeyWord];
        }
    }];
}

- (void)chageAction:(id)sender{
    [self changeSearchKeyWord];
}

- (void)cancleAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeSearchKeyWord{
    for (UIButton *button in self.view.subviews) {
        [button removeFromSuperview];
    }
    //随机获取10个key
    NSArray *keyWordArrayTemp = [self rondomkeyWordArray];// [NSArray arrayWithObjects:@"123",@"123",@"123",@"123",@"123",@"123",@"123",@"123",@"123",@"123", nil];
    NSMutableArray *buttonArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < [keyWordArrayTemp count]; i++) {
        UIButton *button = [self keyWordButtonWithTitle:[keyWordArrayTemp objectAtIndex:i] tag:i];
        [buttonArray addObject:button];
        [self.view addSubview:button];
    }
    NSArray *frameArray = [self keyWordButtonAnimationFrameWithButtonArray:buttonArray];
    for (UIButton *button in [self.view subviews]) {
        NSValue *value = frameArray[button.tag];
        CGRect frameTemp = [value CGRectValue];
        [self showPopWithPopButton:button showPosition:frameTemp];
        
    }
}

//弹出动画
- (void)showPopWithPopButton:(UIButton *)aButton showPosition:(CGRect)aRect
{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    positionAnimation.fromValue = [NSValue valueWithCGRect:aButton.frame];
    positionAnimation.toValue = [NSValue valueWithCGRect:aRect];
    positionAnimation.springBounciness = 15.0f;
    positionAnimation.springSpeed = 10.0f;
    [aButton pop_addAnimation:positionAnimation forKey:@"frameAnimation"];
}

- (UIButton *)keyWordButtonWithTitle:(NSString *)aTitle tag:(NSInteger)aTag
{
    CGFloat button_X = kScreenWidth / 2;
    CGFloat button_Y = 150;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger fontSize = (arc4random() % 11) + 15;
    CGFloat button_W = [self widthForLableWithText:aTitle fontSize:fontSize];
    
    CGFloat red = (arc4random() % 246) + 10;
    CGFloat blue = (arc4random() % 246) + 10;
    CGFloat green = (arc4random() % 246) + 10;
    
    button.frame = CGRectMake(button_X, button_Y, button_W, 30);
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:red/255.0 green:blue/255.0 blue:green/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:fontSize]];
    button.tag = aTag;
    [button addTarget:self action:@selector(keyWordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return  button;
}

- (void)keyWordBtnAction:(UIButton*)sender{
    
    SearchResultViewController *searchKeyVC = [[SearchResultViewController alloc] init];
    searchKeyVC.searchKey = sender.titleLabel.text;
    [self.navigationController pushViewController:searchKeyVC animated:YES];
    
    
    
}

#pragma mark - 获取动画的位移的frame
//获取10个位移后的frame
- (NSArray *)keyWordButtonAnimationFrameWithButtonArray:(NSArray *)aButtonArray
{
    NSMutableArray *frameArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSArray *rowNoArray = [self keywordRowNoArray];
    NSInteger count = 0;
    
    NSInteger buttonCount = 0;
    for (int i = 0; i < [rowNoArray count]; i ++ ) {
        NSNumber *rowNo = [rowNoArray objectAtIndex:i];
        
        NSInteger button_y = (iPhone5?20:0) + i * 50;
        
        NSMutableArray *weightArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int j = 0 ; j < [rowNo integerValue]; j++) {
            
            if ([aButtonArray count] >= buttonCount) {
                
                UIButton *button = [aButtonArray objectAtIndex:buttonCount];
                [weightArray addObject:[NSNumber numberWithInteger:button.frame.size.width]];
                buttonCount ++ ;
            }
            
        }
        NSArray *xArray = [self rowKeyWordButtonAnimationWithFrameArray:weightArray];
        for (int k = 0; k < [xArray count]; k ++ ) {
            UIButton *button = [aButtonArray objectAtIndex:count];
            count ++;
            NSInteger rondomY = (arc4random() % 20) + 0;//随机Y
            NSNumber *xNumber = [xArray objectAtIndex:k];
            CGRect frameTemp = CGRectMake([xNumber integerValue] , button_y + rondomY , button.frame.size.width, button.frame.size.height );
            
            [frameArray addObject:[NSValue valueWithCGRect:frameTemp]];
            
        }
    }
    
    return frameArray;
}

//获取一行的三个frame  如 100 100 100
- (NSArray *)rowKeyWordButtonAnimationWithFrameArray:(NSArray *)frameArray
{
    NSMutableArray *xPointArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSInteger count = [frameArray count];
    
    NSInteger totalWeight = 0;//n个frame 加起来的宽度
    for (int i = 0; i < count; i ++ ) {
        NSNumber *weight =[frameArray objectAtIndex:i];
        totalWeight += [weight floatValue];
    }
    NSInteger subWeight = kScreenWidth - totalWeight;
    if (subWeight < 0) {
        subWeight = -subWeight;
        NSInteger xTemp = (CGFloat)random() / (CGFloat)RAND_MAX * subWeight;//(arc4random() % subWeight) + 0;
        NSInteger x = 0;
        for (int i = 0; i < count; i ++ ) {
            
            if (i != 0) {
                NSNumber *weight =[frameArray objectAtIndex:i - 1];
                x = x + [weight floatValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
            else
            {
                //                NSNumber *weight =[frameArray objectAtIndex:0];
                x = -xTemp ;//[weight floatValue] -xTemp ;
                [xPointArray addObject:[NSNumber numberWithInteger:-xTemp]];
            }
            
        }
    }
    else
    {
        
        NSMutableArray * xTempArray = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i = 0; i < count; i ++) {
            NSInteger xTemp = (CGFloat)random() / (CGFloat)RAND_MAX * (subWeight/(count - i));//(arc4random() % subWeight) + 0;
            subWeight = subWeight - xTemp;
            [xTempArray addObject:[NSNumber numberWithInteger:xTemp]];
        }
        
        for (int k = 0; k < count; k ++ ) {
            
            if (k != 0) {
                
                NSNumber *x1 = [xPointArray objectAtIndex:k - 1];
                NSNumber *rondomX =[xTempArray objectAtIndex:k];
                
                NSNumber *prevWeight = [frameArray objectAtIndex:k-1];
                
                NSInteger x = [x1 integerValue] + [rondomX integerValue] + [prevWeight floatValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
            else
            {
                NSInteger x = [[xTempArray objectAtIndex:0] integerValue];
                [xPointArray addObject:[NSNumber numberWithInteger:x]];
            }
            
        }
    }
    return xPointArray;
}

- (NSArray *)keywordRowNoArray
{
    NSInteger keyWordNo = 10;//keyword个数
    NSInteger maxRow = 5;//最大行
    NSInteger minRow = 3;//最小行
    
    NSInteger row = (arc4random() % (maxRow - minRow +1)) + 5;
    
    NSInteger theMaxRowNo = 4;
    
    NSInteger maxRowNo = keyWordNo / minRow + 1;//每行的最大数
    NSInteger minRowNo = [self keyWordCGFloatToNSInteger:(keyWordNo - maxRowNo) / (CGFloat)(row - 1) -1] ;//最小行keyWord个数
    
    NSMutableArray * rowNoArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < row; i ++ ) {
        if (i == row - 1) {
            NSInteger rowNo = keyWordNo;
            [rowNoArray addObject:[NSNumber numberWithInteger:rowNo]];
        }
        else
        {
            NSInteger rowNo = (arc4random() % (maxRowNo - minRowNo +1)) + minRowNo;
            [rowNoArray addObject:[NSNumber numberWithInteger:rowNo]];
            
            keyWordNo -= rowNo;
            NSInteger maxRowNoTemp = keyWordNo - (row - i - 1) + 1;
            maxRowNo = maxRowNoTemp>theMaxRowNo?theMaxRowNo:maxRowNoTemp ;//每行的最大数
            minRowNo =  [self keyWordCGFloatToNSInteger:(keyWordNo - maxRowNo) / (CGFloat)(row - i - 1 - 1)] ;//最小行keyWord个数
        }
        
    }
    return rowNoArray;
}

- (NSInteger )keyWordCGFloatToNSInteger:(CGFloat)aFloat
{
    NSInteger smallInt = aFloat;
    if (aFloat - smallInt > 0) {
        return smallInt + 1;
    }
    return smallInt;
}

// 取N个不同的随机数
- (NSArray *)rondomArrayWithCount:(NSInteger)arrayCount totalCount:(NSInteger)totalCount
{
    NSMutableArray *rondomArray = [[NSMutableArray alloc] initWithCapacity:0];
    do
    {
        int random = arc4random()%totalCount +0;
        
        NSString *randomString = [NSString stringWithFormat:@"%d",random];
        
        if (![rondomArray containsObject:randomString]) {
            [rondomArray addObject:randomString];
        }
        else{
            //            NSLog(@"数组中有已有该随机数，重新取数！");
        }
        
    } while (rondomArray.count != arrayCount);
    return rondomArray;
}

//获取N个热词
- (NSArray *)rondomkeyWordArray
{
    if ([self.dataArray count] > 10) {
        if (self.isFirst) {
            self.isFirst = NO;
            //第一次取前十个热词
            NSArray *keyWordArray = [self.dataArray objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 10)]];
            return keyWordArray;
        }
        else
        {
            //第二次开始随机取
            NSArray *rondomNumArray = [self rondomArrayWithCount:10 totalCount:[self.dataArray count]];
            NSMutableArray *rondomKeyWordArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (int i = 0; i < 10; i++) {
                NSString *indexStr = [rondomNumArray objectAtIndex:i];
                [rondomKeyWordArray addObject:[self.dataArray objectAtIndex:[indexStr integerValue]]];
            }
            return rondomKeyWordArray;
        }
        
    }
    else
    {
        return self.dataArray;
    }
    return nil;
}

- (CGFloat) widthForLableWithText:(NSString *)strText fontSize:(NSInteger)fontSize
{
    CGSize constraint = CGSizeMake(CGFLOAT_MAX,20);
//    CGSize size = [strText sizeWithFont: [UIFont systemFontOfSize:fontSize] constrainedToSize:constraint lineBreakMode:NSLineBreakByClipping];
    CGSize size = [strText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    float fHeight = size.width +2;
    return fHeight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
