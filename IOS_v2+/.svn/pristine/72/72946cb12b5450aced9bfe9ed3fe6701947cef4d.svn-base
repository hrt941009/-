//
//  LOVWXPayClient.h
//  Love
//
//  Created by 刘轶男 on 15/4/25.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@interface LOVWXPayClient : NSObject

+(instancetype)shareInstance;
- (void)parametersWithPartnerId:(NSString *)partnerId
                       parpayId:(NSString *)parpayId
                        package:(NSString *)package
                       nonceStr:(NSString *)nonceSte
                      timeStamp:(NSString *)timeStamp
                           sign:(NSString *)sign;
- (void)payProduct;
@end
