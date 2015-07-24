//
//  LogisticsModel.h
//  Love
//
//  Created by use on 14-12-22.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//物流信息

#import <Foundation/Foundation.h>
extern NSString * const kLogisticeNoticefationName;
@interface LogisticsModel : NSObject
@property (nonatomic, strong) NSMutableArray *express_data;//信息详情
@property (nonatomic, strong) NSString *express_name;//快递公司名称
@property (nonatomic, strong) NSString *express_code;//快递单号

- (instancetype)initWithAttributtes:(NSDictionary *)attributes;
+ (void)getLogisticeDataCode:(NSString *)code;
@end
