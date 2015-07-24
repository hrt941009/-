//
//  SKUModel.h
//  Love
//
//  Created by lee wei on 14/11/12.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SKUInfoModel : NSObject

@property (nonatomic, strong) NSString *cid;//商品id
@property (nonatomic, strong) NSString *nameInfo;//商品名称
@property (nonatomic, strong) NSString *stocksNumber;//库存
@property (nonatomic, strong) NSString *originalInfo;//原价
@property (nonatomic, strong) NSString *priceInfo;//现在价格
@property (nonatomic, strong) NSString *thumbPath;//商品图片

- (instancetype)init;

@end


@interface SKUShowModel : NSObject

@property (nonatomic, strong) NSString *keyValue;//规格属性值
@property (nonatomic, strong) NSString *keyColor;//颜色
@property (nonatomic, strong) NSString *keySize;//尺寸
@property (nonatomic, strong) NSString *showKey;//规格属性
@property (nonatomic, strong) NSString *keyEname;//规格属性英文名(用于匹配)
@property (nonatomic, strong) NSString *keyName;//规格属性中文名(用于展示) 中文名和英文名的array_key 是对应的

- (instancetype)init;

@end

@interface SKUCommissionModel : NSObject

@property (nonatomic, strong) NSString *commoId;
@property (nonatomic, strong) NSString *commoList;
@property (nonatomic, strong) NSString *commoCode;
@property (nonatomic, strong) NSString *discountInfo;
@property (nonatomic, strong) NSString *hasDiscount;
@property (nonatomic, strong) NSString *hasNextPrice;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *nextPrice;
@property (nonatomic, strong) NSString *nowPrice;
@property (nonatomic, strong) NSString *commoNumber;
@property (nonatomic, strong) NSString *originalInfo;
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *thumbPath;
@property (nonatomic, strong) NSString *discountRange;

- (instancetype)init;

@end

@interface SKUModel : NSObject

@property (nonatomic, strong) NSString *skuKeyName;
@property (nonatomic, strong) NSString *skuKeyValue;

- (instancetype)init;

+ (void)getSKUWithItem:(NSString *)item
                 block:(void(^)(NSString *thumbPath,
                                NSString *stockNum,
                                NSString *section1,
                                NSString *section2,
                                NSString *price1,
                                NSString *price2,
                                NSString *price3,
                                NSString *defaultPrice,
                                NSDictionary *commoListDic,
                                NSArray *skuValueArray))block;

@end
