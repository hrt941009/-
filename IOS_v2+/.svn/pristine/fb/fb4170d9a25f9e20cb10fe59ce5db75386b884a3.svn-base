//
//  DresserDetailModel.h
//  Love
//
//  Created by lee wei on 14-10-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//



#import <Foundation/Foundation.h>



extern NSString * const kDresserInfoNotification;
extern NSString * const kDresserProductListNotification;
extern NSString * const kDresserDetailNotification;
extern NSString * const kDresserLiveNotification;



//美装师信息

@interface DresserInfoModel : NSObject



@property (nonatomic, strong) NSString *sid;

@property (nonatomic, strong) NSString *dresserName;

@property (nonatomic, strong) NSString *followNum;

@property (nonatomic, strong) NSString *itemsNum;

@property (nonatomic, strong) NSString *dresserLevel;

@property (nonatomic, strong) NSString *dresserInfo;

@property (nonatomic, strong) NSString *headerPath;

@property (nonatomic, strong) NSString *shopBackground;

@property (nonatomic, strong) NSString *dresserLocation;

@property (nonatomic, strong) NSString *attention;      //0 未关注、1 已关注



- (instancetype)init;



+ (void)getDresserInfoWithSellerID:(NSString *)sellerID;



@end



//美妆师直播详情商品列表

@interface DresserProductModel : NSObject



@property (nonatomic, strong) NSString *productID;

@property (nonatomic, strong) NSString *productName;

@property (nonatomic, strong) NSString *productPrice;

@property (nonatomic, strong) NSString *thumbPath;

@property (nonatomic, strong) NSString *isRecom;

@property (nonatomic, strong) NSString *recomId;



- (instancetype)initWithAttributes:(NSDictionary *)attributes;



+ (void)getDresserProductListWithLiveID:(NSString *)liveId;



@end



//美妆师直播详情

@interface DresserDetailModel : NSObject



@property (nonatomic, strong) NSString *artistID;

@property (nonatomic, strong) NSString *dresserIntro;

@property (nonatomic, strong) NSString *attention;

@property (nonatomic, strong) NSString *liveID;

@property (nonatomic, strong) NSString *liveName;

@property (nonatomic, strong) NSString *dresserLocation;

@property (nonatomic, strong) NSString *photoArray;



- (instancetype)init;



+ (void)getDresserDetailWithLiveID:(NSString *)liveID block:(void(^)(NSDictionary *dic))block;



@end



//美妆师页直播列表

@interface DresserLiveModel : NSObject



@property (nonatomic, strong) NSString *liveID;//	int	直播id

@property (nonatomic, strong) NSString *liveName;//	string	直播

@property (nonatomic, strong) NSString *dresserIntro;//	string	介绍

@property (nonatomic, strong) NSString *dresserLocation;//	string	直播地址

@property (nonatomic, strong) NSString *livePic;//	string	直播封面

@property (nonatomic, strong) NSString *artistID;//	int	美妆师ID

@property (nonatomic, strong) NSString *createTime;



- (instancetype)initWithAttributes:(NSDictionary *)attributes;



+ (void)getDresserDetailWithSellerID:(NSString *)sellerid;



@end