//
//  SellerLiveModel.h
//  Love
//
//  Created by 李伟 on 14-7-23.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  买手商品直播
//

#import <Foundation/Foundation.h>
#import "SellerInfoModel.h"

extern NSString * const kShoppingLiveListNotificationName;

@interface ShoppingLiveDetailModel : NSObject

+ (void)getLiveDetailInfoWithLiveID:(NSString *)liveID block:(void (^)(NSString *sellerId,
                                                                       NSString *sellerName,
                                                                       NSString *header,
                                                                       NSString *description,
                                                                       NSString *Location,
                                                                       NSString *flag,
                                                                       NSString *startTime,
                                                                       NSString *endTime,
                                                                       NSString *attention,
                                                                       NSNumber *currentTime))block;

@end


@interface ShoppingLiveModel : NSObject

//@property (nonatomic, strong) NSString *startTime;         //此次开始时间，此值从1970年到现在的秒数，为本此商品shoppingLive的结束计算标志，此值一到，则结束此shopping
//@property (nonatomic, strong) NSString *endTime;           //直播剩余时间
//@property (nonatomic, strong) NSString *flag;              //国旗图片URL
//@property (nonatomic, strong) NSString *shoppingLiveID;	   //此次shoppingShow的ID
//@property (nonatomic, strong) NSString *coordinate;	       //此次shoppingShow的坐标


@property (nonatomic, strong) SellerInfoModel *sellerInfo; //买手信息
@property (nonatomic, strong) NSString *userName;          //评论人
@property (nonatomic, strong) NSString *msg;               //评论内容
@property (nonatomic, strong) NSArray *commentArray;       //评论信息列表
@property (nonatomic, strong) NSString *itemID;            //商品ID
@property (nonatomic, strong) NSString *sellerName;        
@property (nonatomic, strong) NSArray  *imagesArray;       //array 商品图片列表，每个原素为一个图片URL。图片个数不一，总数不超过10个，至少1个
@property (nonatomic, strong) NSString *shopDescription;       //商品介绍，此值为HTML，只做简单样式描述，如换行，字体颜色（字体大小不做控制）
@property (nonatomic, strong) NSString *stock;             //库存
@property (nonatomic, strong) NSString *price;             //价格，默认为人民币
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *rebateNum;  //评论数量

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (void)getLiveDetailInfoWithLiveID:(NSString *)liveID page:(NSString *)page pageNum:(NSString *)pnum;


@end
