//
//  ShareProductDetailViewController.h
//  Love
//
//  Created by use on 15-3-20.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//
//商品详情页
#import <UIKit/UIKit.h>

@interface ShareProductDetailViewController : LOVBaseViewController
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;

@property (nonatomic, strong) NSString *tagId;

//isShare=yes时不用传tagID
//修改为所有的均不传tagID
- (void)reloadTheDataWithShare:(BOOL)isShare;

@end
