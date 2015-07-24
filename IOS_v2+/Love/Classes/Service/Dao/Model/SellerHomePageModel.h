//
//  SellerHomePageModel.h
//  Love
//
//  Created by 李伟 on 14-10-14.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  买手主页
//

#import <Foundation/Foundation.h>


//---正在直播
@interface SellerLivingInfoModel : NSObject

@property (nonatomic, strong) NSString *shopingLiveID;
@property (nonatomic, strong) NSString *sellerDescription;
@property (nonatomic, strong) NSString *sellerLocation;
@property (nonatomic, strong) NSString *liveStatus; //1为正在直播 2为直播未开始 3为直播结束
@property (nonatomic, strong) NSString *liveTime;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end

//---即将开始的直播
@interface SellerFutureLiveInfoModel : NSObject

@property (nonatomic, strong) NSString *shopingLiveID;
@property (nonatomic, strong) NSString *sellerDescription;
@property (nonatomic, strong) NSString *sellerLocation;
@property (nonatomic, strong) NSString *liveStatus; //1为正在直播 2为直播未开始 3为直播结束
@property (nonatomic, strong) NSString *liveTime;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end

//---历史直播
@interface SellerHistoryLiveInfoModel : NSObject

@property (nonatomic, strong) NSString *shopingLiveID;
@property (nonatomic, strong) NSString *sellerDescription;
@property (nonatomic, strong) NSString *sellerLocation;
@property (nonatomic, strong) NSString *liveStatus; //1为正在直播 2为直播未开始 3为直播结束
@property (nonatomic, strong) NSString *liveTime;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end

//---获取直播信息
@interface SellerHomePageModel : NSObject


@property (nonatomic, strong) NSString *sellerID; //买手ID
@property (nonatomic, strong) NSString *sellerName;
@property (nonatomic, strong) NSString *sellerLocation;
@property (nonatomic, strong) NSString *sellerCountry;
@property (nonatomic, strong) NSString *countryFlag;
@property (nonatomic, strong) NSString *headerPhoto;
@property (nonatomic, strong) NSString *followNum; //粉丝数量
@property (nonatomic, strong) NSString *itemsNum; //全部商品数量
@property (nonatomic, strong) NSString *liveNum; //全部直播数量
@property (nonatomic, strong) NSString *shopBackground; //买手主页背景图
@property (nonatomic, strong) NSString *isAttention; //是否关注 0 未关注、1 关注

- (instancetype)init;

+ (void)getSellerDetailInfoWithId:(NSString *)sellerId
                          pageNum:(NSString *)pnum
                            block:(void(^)(NSDictionary *sellerInfoDic, NSArray *livingArray, NSArray *futureArray, NSArray *historyArray))block;

@end
