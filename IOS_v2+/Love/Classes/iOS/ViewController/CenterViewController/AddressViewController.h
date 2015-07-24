//
//  AddressViewController.h
//  Love
//
//  Created by lee wei on 14-10-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  我-个人信息-地址
//

#import <UIKit/UIKit.h>
#import "CenterViewControllerDelegate.h"

@interface AddressViewController : LOVBaseViewController

@property (nonatomic, strong) NSString *address;
@property (nonatomic, weak) id<CenterViewControllerDelegate> delegate;

@end
