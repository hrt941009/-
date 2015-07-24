//
//  AlipayIDListModel.h
//  Love
//
//  Created by use on 15-1-7.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlipayIDListModel : NSObject
@property (nonatomic, strong) NSString *alipay;
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithAttributtes:(NSDictionary *)attributes;
+ (void)getAlipayIDLisyDataBlock:(void(^)(NSArray *array))block;
@end
