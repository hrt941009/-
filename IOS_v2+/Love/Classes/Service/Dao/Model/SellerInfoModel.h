//
//  SellerInfoModel.h
//  Love
//
//  Created by lee wei on 14-7-23.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  买手信息
//

#import <Foundation/Foundation.h>

@interface SellerInfoModel : NSObject

@property (nonatomic, strong) NSString *sellerName;	    //商家名
@property (nonatomic, strong) NSString *sellerID;	    //商家ID
@property (nonatomic, strong) NSString *header;	        //商家头像URL
@property (nonatomic, strong) NSString *location;	    //此次shoppingShow的地址，文字描述
@property (nonatomic, strong) NSString *shopDescription;     //商店信息

- (id)initWithAttributes:(NSDictionary *)attributes;

@end
