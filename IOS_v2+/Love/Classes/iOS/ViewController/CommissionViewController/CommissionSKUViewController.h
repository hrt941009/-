//
//  CommissionSKUViewController.h
//  Love
//
//  Created by lee wei on 14/11/12.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommissionSKUViewController : LOVBaseViewController

@property (nonatomic, strong) NSString *commoStr;
@property (nonatomic, strong) NSString *thumbPath;
@property (nonatomic, strong) NSString *defaultPrice;
@property (nonatomic, strong) NSString *stocksNum;
@property (nonatomic, strong) NSDictionary *commList;
@property (nonatomic, strong) NSArray *skuValueArr;
@property (nonatomic, strong) NSString *intro;

@property (nonatomic, strong) NSString *section1;
@property (nonatomic, strong) NSString *section2;
@property (nonatomic, strong) NSString *price1;
@property (nonatomic, strong) NSString *price2;
@property (nonatomic, strong) NSString *price3;

@property (nonatomic, assign) BOOL isCart; //是否加入购物车

@property (nonatomic, strong) NSString *dresserId;
@end
