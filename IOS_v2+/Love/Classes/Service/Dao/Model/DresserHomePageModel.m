//
//  DresserHomePageModel.m
//  Love
//
//  Created by lee wei on 14-10-18.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "DresserHomePageModel.h"
#import "APPNetworkDao.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Additions.h"
#import "APPCommissionDetailDao.h"

NSString * const kDresserHomePageNotificationName = @"kDresserHomePageNotificationName";
static NSString * const kDresserHomePageURL = @"ArtistLive/liveList";
static NSString * const kDresserLiveURL = @"ArtistLive/liveDetail";

@implementation DresserHomePageModel

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
            
//        UIImageView *imageView = [[UIImageView alloc] init];
//        [imageView sd_setImageWithURL:[NSURL URLWithString:[attributes valueForKeyPath:@"thumb"]]
//                     placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
//        CGFloat imgWidth = imageView.image.size.width;
//        CGFloat imgHeight = imageView.image.size.height;
//        NSLog(@"--- w %f  h %f", imgWidth,imgHeight);
//        UIImage *thumbImage = nil;
//        //150.f cell宽度
//        if (imgWidth > 150.f) {
//            CGFloat thumbImgHeight = (imgWidth/imgHeight) * 150.f;
//            CGSize size = CGSizeMake(150.f, thumbImgHeight);
//            thumbImage = [UIImage lovThumbImage:imageView.image size:size];
//        }else{
//            thumbImage = imageView.image;
//        }
//        _thumbImage = thumbImage;
        _picWhRatio = [attributes valueForKey:@"pic_wh_ratio"];
        _artistId = [attributes valueForKeyPath:@"artist_id"];
        _artistName = [attributes valueForKeyPath:@"artist_name"];
        _createTime = [attributes valueForKeyPath:@"create_time"];
        _commentNum = [attributes valueForKeyPath:@"discuss"];
        _dresserHeader = [attributes valueForKeyPath:@"header"];
        _liveId = [attributes valueForKeyPath:@"live_id"];
        _liveName = [attributes valueForKeyPath:@"live_name"];
        _dresserLevel = [attributes valueForKeyPath:@"star"];
        _dresserLocation = [attributes valueForKeyPath:@"location"];
        _likeNum = [attributes valueForKeyPath:@"love"];
        _thumbPath = [attributes valueForKeyPath:@"thumb"];
        _isAttention = [attributes valueForKey:@"is_attention"];

    }
    return self;
}

+ (void)getDresserListPage:(NSString *)page pageNum:(NSString *)pageNum
{
    NSString *urlString = [NSString stringWithFormat:@"%@?p=%@&pnum=%@", kDresserHomePageURL, page, pageNum];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                              if ([array count] > 0) {
                                  for (NSDictionary *dic in array) {
                                      DresserHomePageModel *model = [[DresserHomePageModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                      
                                  }
                              }
                              [[NSNotificationCenter defaultCenter] postNotificationName:kDresserHomePageNotificationName object:[NSArray arrayWithArray:mutableArray] userInfo:nil];
                          }];
}

+ (void)getDresserListPage:(NSString *)page pageNum:(NSString *)pageNum block:(void(^)(NSArray *array))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@?p=%@&pnum=%@", kDresserHomePageURL, page, pageNum];
    [APPNetworkDao getURLString:urlString
                     parameters:nil
                          block:^(NSArray *array, NSNumber *currentTime, NSError *error) {
                              NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                              if ([array count] > 0) {
                                  for (NSDictionary *dic in array) {
                                      DresserHomePageModel *model = [[DresserHomePageModel alloc] initWithAttributes:dic];
                                      [mutableArray addObject:model];
                                      
                                  }
                              }
                              if (block) {
                                  block([NSArray arrayWithArray:mutableArray]);
                              }
                          }];
}

+ (void)getDresserLiveDataWithLiveId:(NSString *)liveId block:(void(^)(NSDictionary *dic))block{
    NSString *urlStr = [NSString stringWithFormat:@"%@?live=%@",kDresserLiveURL,liveId];
    [APPCommissionDetailDao getURLString:urlStr block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
        if (block) {
            block(dic);
        }
    }];
}

@end
