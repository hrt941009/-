//
//  SKUModel.m
//  Love
//
//  Created by lee wei on 14/11/12.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SKUModel.h"
#import "APPCommissionDetailDao.h"

static NSString *kSKUURL = @"HtPayList/allLists";


@implementation SKUInfoModel

/**
 商品信息 获取的key = info
 
 @param    cid            商品id
 @param    nameInfo       商品名称
 @param    stocksNumber   库存
 @param    originalInfo   原价
 @param    priceInfo      现在价格
 @param    thumbPath      商品图片
 
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _cid = @"id";
        _nameInfo = @"name";
        _stocksNumber = @"number";
        _originalInfo = @"original";
        _priceInfo = @"price";
        _thumbPath = @"thumb";
    }
    return self;
}

@end


@implementation SKUShowModel

/**
 商品规格展示 获取的key = sku_show
 
 @param    keyValue   规格属性值
 @param    keyColor   颜色
 @param    keySize    尺寸
 @param    showKey    规格属性
 @param    keyEname   规格属性英文名(用于匹配)
 @param    keyName    规格属性中文名(用于展示) 中文名和英文名的array_key 是对应的
 
 ** --------- 例子 --------
 "sku_show" = {
        "key_value" = {
                color = (
                    ""
                );
                size = (
                    ""
                );
        };
        "show_key" = {
                "key_ename" = (
                    color, //对应key_value中的color
                    size   //对应key_value中的size
                );
                "key_name" = (
                    "深绿",
                    "均码"
                );
        };
 };
 
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _keyValue = @"key_value";
        _keyColor = @"color";
        _keySize = @"size";
        _showKey = @"show_key";
        _keyEname = @"key_ename";
        _keyName = @"key_name";
    }
    return self;
}

@end

@implementation SKUCommissionModel

/**
 商品信息 获取的key = sku
 
 @param    commoId          商品ID列表, 商品为海淘商品时，由于可不添加sku属性，当commo_id 的长度为1时，默认选择该商品。不为1，则通过规格获取id。
 @param    commoCode        库存
 @param    discountInfo     折扣值
 @param    hasDiscount      是否有折扣 1有 0无
 @param    hasNextPrice     是否有下次购买价 1有 0无
 @param    cid              商品ID（commo）
 @param    nextPrice        下次购买价
 @param    nowPrice         现价
 @param    commoNumber      商品库存
 @param    originalInfo     就价格
 @param    productId        产品ID（product_id）
 @param    thumbPath        商品图片（由于后台没设，取的是产品图片）
 
 **-------- --------
 commo_list (key)	 	用于匹配的列表 其key为"sku_show.show_key.key_ename[0]:sku_show.show_key.key_ename[1]"
 commo_list (value)	array	匹配后得到的商品详情
 commo_list:{
    军绿:均码: {
    id: "112",
    product_id: "97",
    number: "200",
    original: "0",
    thumb: "",
    code: "0001",
    has_discount: "1",
    discount: "7.8",
    now_price: "353.02",
    has_next_price: "1",
    next_price: "323.08"
    }
 }
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _commoId = @"commo_id";
        _commoList = @"commo_list";
        _commoCode = @"code";
        _discountInfo = @"discount";
        _hasDiscount = @"has_discount";
        _hasNextPrice = @"has_next_price";
        _cid = @"id";
        _nextPrice = @"next_price";
        _nowPrice = @"now_price";
        _commoNumber = @"number";
        _originalInfo = @"original";
        _productId = @"product_id";
        _thumbPath = @"thumb";
        _discountRange = @"discount_range";
        
    }
    return self;
}


@end


@implementation SKUModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _skuKeyName = @"skuKeyName";
        _skuKeyValue = @"skuKeyValue";
    }
    return self;
}

/**
 获取sku信息
 
 @param   item 商品id
 
 @param   thumbPath      商品图片地址
 @param   stockNum       库存
 @param   defaultPrice   默认价格
 @param   commoList      选择sku属性后得到的商品详情，从详情中查找商品价格，查找价格见SKUCommissionModel
 @param   skuValueArray  sku属性 key_name获取属性名称， 用key_ename的内容做key获取key_value中的数据，拼成数组
 skuValueArray = @[@{skuKeyName : @"颜色", skuKeyValue: @"红, 黄"}, @{skuKeyName : @"尺寸", skuKeyValue: @"S, SL"}]
 
 @return  block
 */
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
                                NSArray *skuValueArray))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@?item=%@", kSKUURL, item];
    [APPCommissionDetailDao getURLString:urlString
                                   block:^(NSDictionary *dic, NSNumber *currentTime, NSError *error) {
                                       //-------
                                       SKUInfoModel *infoModel = [[SKUInfoModel alloc] init];
                                       NSDictionary *infoDic = [dic objectForKey:@"info"];
                                       NSString *thumb = [infoDic objectForKey:infoModel.thumbPath];
                                       NSString *defaultPrice = [infoDic objectForKey:infoModel.priceInfo];
                                       NSString *stocks = [infoDic objectForKey:infoModel.stocksNumber];
                                       NSString *section1 = [[infoDic objectForKey:@"default_range"] objectForKey:@"section_1"];
                                       NSString *section2 = [[infoDic objectForKey:@"default_range"] objectForKey:@"section_2"];
                                       NSString *price1 = [[infoDic objectForKey:@"default_range"] objectForKey:@"price_1"];
                                       NSString *price2 = [[infoDic objectForKey:@"default_range"] objectForKey:@"price_2"];
                                       NSString *price3 = [[infoDic objectForKey:@"default_range"] objectForKey:@"price_3"];
                                       //-------
                                       SKUCommissionModel *commModel = [[SKUCommissionModel alloc] init];
                                       NSDictionary *commDic = [dic objectForKey:@"sku"];
                                       NSArray *commoIdArr = [commDic objectForKey:commModel.commoId];
                                       if ([commoIdArr count] > 0) {
                                           NSDictionary *commoListDic = [commDic objectForKey:commModel.commoList];
                                           //-------
                                           SKUShowModel *showModel = [[SKUShowModel alloc] init];
                                           NSDictionary *showDic = [dic objectForKey:@"sku_show"];
                                           NSArray *keyNameArr = [[showDic objectForKey:showModel.showKey] objectForKey:showModel.keyName];
                                           NSArray *keyEnameArr = [[showDic objectForKey:showModel.showKey] objectForKey:showModel.keyEname];
                                           NSDictionary *keyValueDic = [showDic objectForKey:showModel.keyValue];
                                           
                                           NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
                                           SKUModel *skuModel = [[SKUModel alloc] init];
                                           if ([keyEnameArr count] == [keyNameArr count]) {
                                               for (int i = 0; i < [keyNameArr count]; i++) {
                                                   NSArray *keyValueArr = [keyValueDic objectForKey:keyEnameArr[i]];
                                                   NSDictionary *resultDict = @{skuModel.skuKeyName: keyNameArr[i], skuModel.skuKeyValue: keyValueArr};
                                                   [mutableArray addObject:resultDict];
                                               }
                                           }
                                           NSLog(@"sku dic = %@ ", dic);
                                           //NSLog(@"commoListDic = %@ ", commoListDic);
                                           if (block) {

                                               block(thumb,
                                                     stocks,
                                                     section1,
                                                     section2,
                                                     price1,
                                                     price2,
                                                     price3,
                                                     defaultPrice,
                                                     commoListDic,
                                                     [NSArray arrayWithArray:mutableArray]);
                                           }
                                       }else{
                                           if (block) {
                                               block(thumb, stocks, section1, section2, price1, price2, price3, defaultPrice, @{}, @[]);
                                           }
                                       }
                                   }];
}

@end
