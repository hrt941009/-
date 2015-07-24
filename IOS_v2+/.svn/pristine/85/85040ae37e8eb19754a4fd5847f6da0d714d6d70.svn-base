//
//  MeTagListModel.h
//  Love
//
//  Created by use on 15-4-2.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const kMeTagListNotificationName;
extern NSString * const kMeTagProductListNotificationName;
@interface MeTagListModel : NSObject

@property (nonatomic, strong) NSString * tagId;
@property (nonatomic, strong) NSString * tagName;
@property (nonatomic, strong) NSString * tagIntro;
@property (nonatomic, strong) NSString * tagHeader;

@property (nonatomic, strong) NSString * productId;
@property (nonatomic, strong) NSString * productHeader;
@property (nonatomic, strong) NSString * productName;
@property (nonatomic, strong) NSString * productPrice;
@property (nonatomic, strong) NSString * productIntro;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getTagListDataWithPage:(NSString *)page PageNum:(NSString *)pnum;

+ (void)getTagProductListDataWith:(NSString *)tagId Page:(NSString *)page Pnum:(NSString *)pnum;

@end
