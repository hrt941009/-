//
//  BrandModel.h
//  Love
//
//  Created by lee wei on 14/12/4.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//  品牌
//

#import <Foundation/Foundation.h>

extern NSString * const kBrandProductListNoticefationName;

@interface BrandModel : NSObject

@property (nonatomic, strong) NSString *commentNum;
@property (nonatomic, strong) NSString *introString;
@property (nonatomic, strong) NSString *loveNum;
@property (nonatomic, strong) NSString *productPrice;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *saveNum;
@property (nonatomic, strong) NSString *thumbPath;

- (instancetype)initWithAttributtes:(NSDictionary *)attributes;

+ (void)getBrandInfoWithID:(NSString *)bid block:(void(^)(NSString *fansNum,
                                                          NSString *brandID,
                                                          NSString *intro,
                                                          NSString *brandName,
                                                          NSString *productNum,
                                                          NSString *thumbPath))block;


+ (void)getBrandProductListWithID:(NSString *)bid page:(NSString *)page pageNumber:(NSString *)pageNumber;

@end
