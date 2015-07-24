//
//  AddressManagerController.h
//  Love
//
//  Created by use on 14-11-22.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//收货地址管理

#import <UIKit/UIKit.h>
@class ReciveAdressModel;
@protocol GetAddressDelegate <NSObject>

- (void)GetAddressData:(ReciveAdressModel *)model;

@end
@interface AddressManagerController : LOVBaseViewController

@property (nonatomic, assign) BOOL isCommidity;

@property (nonatomic, weak) id<GetAddressDelegate>delegate;

@end
