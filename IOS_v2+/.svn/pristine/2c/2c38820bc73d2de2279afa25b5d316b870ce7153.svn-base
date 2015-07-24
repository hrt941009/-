//
//  RSAObject.h
//  CSLCLottery
//
//  Created by 李伟 on 11/14/13.
//  Copyright (c) 2013 CSLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "openssl/rsa.h"
#include <openssl/pem.h>

typedef enum {
    KeyTypePublic,
    KeyTypePrivate
}KeyType;

typedef enum
{
    RSAPaddingTypeNone       = RSA_NO_PADDING,
    RSAPaddingTypePKCS1      = RSA_PKCS1_PADDING,
    RSAPaddingTypeSSLV23     = RSA_SSLV23_PADDING
}RSAPaddingType;

@interface RSAObject : NSObject
{
    RSA *_rsa;
}


+ (id)shareInstance;

- (BOOL)generateRSAKey;

- (void)exportRSAKeysWithPublicKeyString:(NSString *)publickeyStr privateKeyString:(NSString *)privateKeyStr;

- (BOOL)importRSAKeys;

- (NSData *)encryptRSAKeyWithType:(KeyType)type padding:(RSAPaddingType)padding plainText:(NSString *)text;

- (NSString *)decryptRSAKeyWithTYpe:(KeyType)type padding:(RSAPaddingType)padding plainTextData:(NSData *)data;

@end
