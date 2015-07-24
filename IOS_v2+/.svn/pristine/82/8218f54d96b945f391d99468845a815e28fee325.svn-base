//
//  FollowModel.h
//  Love
//
//  Created by lee wei on 14-9-24.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  关注
//

#import <Foundation/Foundation.h>

extern NSString * const kFollowSubjectNotificationName;
extern NSString * const kFollowBrandNotificationName;
extern NSString * const kFollowDresserNotificationName;
extern NSString * const kFollowShopNotificationName;
extern NSString * const kFollowLiveNotificationName;
extern NSString * const kFollowMasterNotificationName;

@interface FollowMasterModel : NSObject

@property (nonatomic, strong) NSString *mid;//达人id
@property (nonatomic, strong) NSString *mName;//达人姓名
@property (nonatomic, strong) NSString *mIntro;//达人简介
@property (nonatomic, strong) NSString *mheader;//头像
@property (nonatomic, strong) NSString *mLocation;//地址

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getFollowMasterWithP:(NSString *)p pnum:(NSString *)pnum;

@end

//关注专辑
@interface FollowSubjectModel : NSObject

@property (nonatomic, strong) NSString *sid;         //专辑ID
@property (nonatomic, strong) NSString *albumName;   //专辑名称
@property (nonatomic, strong) NSString *subjectDesc;
@property (nonatomic, strong) NSString *thumbPath;   //专辑封面图片
@property (nonatomic, strong) NSString *userId; //专辑介绍
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *interestNum;//关注数量
@property (nonatomic, strong) NSString *reviewNum;//评论数

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getFollowSubjectWithP:(NSString *)p pnum:(NSString *)pnum;

@end


//关注品牌
@interface FollowBrandModel : NSObject

@property (nonatomic, strong) NSString *bid;         //品牌ID
@property (nonatomic, strong) NSString *brandName;   //品牌名称
@property (nonatomic, strong) NSString *brandNation;
@property (nonatomic, strong) NSString *thumbPath;   //品牌封面图片
@property (nonatomic, strong) NSString *brandIntro; //品牌介绍
@property (nonatomic, strong) NSString *brandOperation;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getFollowBrandtWithP:(NSString *)p pnum:(NSString *)pnum;

@end


//关注美妆师
@interface FollowDresserModel : NSObject

@property (nonatomic, strong) NSString *sellerId;
@property (nonatomic, strong) NSString *dresesrLocation;         //
@property (nonatomic, strong) NSString *dresserName;   //美妆师名称
@property (nonatomic, strong) NSString *numAtt; //粉丝数
@property (nonatomic, strong) NSString *thumbPath;   //专辑封面图片
@property (nonatomic, strong) NSString *dresserIntro; //美妆师 介绍
@property (nonatomic, strong) NSString *numProduct; //商品数
@property (nonatomic, strong) NSString *dresserStar; //等级

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getFollowDresserWithPage:(NSString *)p pageNum:(NSString *)pnum;

@end

@interface FollowLiveModel : NSObject

@property (nonatomic, strong) NSString *liveId;
@property (nonatomic, strong) NSString *liveLocation;         //
@property (nonatomic, strong) NSString *liveName;   //美妆师名称
@property (nonatomic, strong) NSString *artistId; //美妆师id
@property (nonatomic, strong) NSString *thumbPath;   //专辑封面图片
@property (nonatomic, strong) NSString *artistName; //美妆师名称
@property (nonatomic, strong) NSString *headerPath; //美妆师头像
@property (nonatomic, strong) NSString *star; //星星数量
@property (nonatomic, strong) NSString *love;//喜欢数量
@property (nonatomic, strong) NSString *discuss;//评论数量
@property (nonatomic, strong) NSString *createTime;//创建时间

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getFollowLiveWithPage:(NSString *)p pageNum:(NSString *)pnum;

@end

//关注品牌
@interface FollowShopModel : NSObject

@property (nonatomic, strong) NSString *shopId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopLogo;
@property (nonatomic, strong) NSString *shopType;
@property (nonatomic, strong) NSString *shopCat;
@property (nonatomic, strong) NSString *shopRegion;
@property (nonatomic, strong) NSString *shopAddress;
@property (nonatomic, strong) NSString *shopPostcode;
@property (nonatomic, strong) NSString *shopMobile;
@property (nonatomic, strong) NSString *shopIntro;
@property (nonatomic, strong) NSString *shopDetail;
@property (nonatomic, strong) NSString *shopOperateType;
@property (nonatomic, strong) NSString *goodsResource;
@property (nonatomic, strong) NSString *isStore;
@property (nonatomic, strong) NSString *isFactory;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *createName;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *updateName;
@property (nonatomic, strong) NSString *shopState;
@property (nonatomic, strong) NSString *deletedInfo;
@property (nonatomic, strong) NSString *shopBigLogo;
@property (nonatomic, strong) NSString *brandInfo;
@property (nonatomic, strong) NSString *currencyInfo;
@property (nonatomic, strong) NSString *isOwn;

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

+ (void)getFollowShopWithPage:(NSString *)p pnum:(NSString *)pnum;

@end


//--------
@interface FollowModel : NSObject


@end
