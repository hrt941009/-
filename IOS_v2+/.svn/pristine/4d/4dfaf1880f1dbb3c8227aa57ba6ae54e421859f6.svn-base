//
//  ComplainModel.h
//  Love
//
//  Created by use on 15-1-7.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const kComplainNoticefationName;
@interface ComplainModel : NSObject

@property (nonatomic, strong) NSString *date;
@property (nonatomic ,strong) NSString *service_result;
@property (nonatomic, strong) NSString *service_code;
@property (nonatomic, strong) NSString *service_type;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSArray *img;


- (instancetype)initWithAttributtes:(NSDictionary *)attributes;

+ (void)getComplainDataCode:(NSString *)code block:(void(^)(NSString *date, NSString *service_result, NSString *service_code, NSString *service_type, NSString *money, NSArray *img))block;
@end
