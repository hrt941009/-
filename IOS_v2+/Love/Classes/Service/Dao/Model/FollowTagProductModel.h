//
//  FollowTagProductModel.h
//  Love
//
//  Created by use on 15-4-6.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const kFollowTagProductNotificationName;
@interface FollowTagProductModel : NSObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *thumbPath;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *loveNumber;
@property (nonatomic, strong) NSString *isLove;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;
+ (void)getFollowTagProductListDataWithTagId:(NSString *)tagId Page:(NSString *)page Pnum:(NSString *)pnum;
@end
