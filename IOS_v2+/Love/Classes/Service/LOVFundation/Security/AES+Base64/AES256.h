//
//  EncryptorAES.h
//  CSLCLottery
//
//  Created by 李伟 on 13-1-24.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>



@interface AES256 : NSObject

+ (NSString *)AES256EncryptBase64String:(NSString *)string;        /*加密方法,参数需要加密的内容*/
+ (NSString *)AES256DecryptBase64String:(NSString *)string;        /*解密方法，参数数密文*/

@end
