//
//  ShareProductViewController.h
//  Love
//
//  Created by use on 15-3-18.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//
//商品列表显示类
#import <UIKit/UIKit.h>
@protocol pushNextViewController <NSObject>
- (void)pushViewDelegateAndProductId:(NSString *)productId productName:(NSString *)productName;

- (void)pushSKUViewControllerWithProductId:(NSString *)productId ProductIntro:(NSString *)productIntro;

- (void)changeFrame:(UITableView *)tableView;
@end


@interface ShareProductViewController : LOVBaseViewController
- (void)reloadProductListData;
@property (nonatomic, weak) id<pushNextViewController>delegate;
@property (nonatomic, strong) NSString *userId;

@end
