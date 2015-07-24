//
//  LikeShareViewController.h
//  Love
//
//  Created by use on 15-4-3.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CellSelectedDelegate <NSObject>
- (void)cellSelectedActionWithShareId:(NSString *)shareId;
@end

@interface LikeShareViewController : UIViewController

- (void)reloadShareListData;

@property (nonatomic, weak) id<CellSelectedDelegate>delegate;

@end
