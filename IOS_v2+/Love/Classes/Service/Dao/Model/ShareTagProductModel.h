//
//  ShareTagProductModel.h
//  Love
//
//  Created by use on 15-3-26.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const kShareTagProductDataListNotificationName;
@interface ShareTagProductModel : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *createTime;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getShareTagProductDataListWithPage:(NSString *)page pageNum:(NSString *)pageNum tagId:(NSString *)tagId;
@end
