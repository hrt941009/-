//
//  RSAObject.m
//  CSLCLottery
//
//  Created by 李伟 on 11/14/13.
//  Copyright (c) 2013 CSLC. All rights reserved.
//

#import "RSAObject.h"

#define RSADocumentDir [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"openssl_rsa"]
#define RSAPublickKeyFile [RSADocumentDir stringByAppendingPathComponent:@"public.key"]
#define RSAPrivateKeyFile [RSADocumentDir stringByAppendingPathComponent:@"private.key"]

@implementation RSAObject

- (id)init
{
    self = [super init];
    if (self) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:RSADocumentDir]) {
            [fileManager createDirectoryAtPath:RSADocumentDir withIntermediateDirectories:YES attributes:nil error:nil];
        }        
    }
    return self;
}

+ (id)shareInstance
{
    static RSAObject *_rsaObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _rsaObject = [[self alloc] init];
        
    });
    return _rsaObject;
}

/**
 *	@brief	初始化、释放rsa。
 *
 *	@return
 */
- (BOOL)generateRSAKey
{
    if (NULL != _rsa) {
        RSA_free(_rsa);
        CRYPTO_cleanup_all_ex_data();
    }
    _rsa = RSA_new(); // RSA_generate_key(keySize,RSA_F4,NULL,NULL);
    //assert(_rsa != NULL);
    
    if (_rsa) {
        return YES;
    }
    return NO;
}

/**
 *	@brief	导出公钥、私钥
 *
 *	@param 	publickeyStr 	公钥字符串
 *	@param 	privateKeyStr 	私钥字符串
 *
 *	@return
 */
- (void)exportRSAKeysWithPublicKeyString:(NSString *)publickeyStr privateKeyString:(NSString *)privateKeyStr

{
    NSString *_publicKeyStr = publickeyStr;
    NSString *_privatekeyStr = privateKeyStr;
    
    NSError *error;
    
    if ([_publicKeyStr length] > 0) {
        [_publicKeyStr writeToFile:RSAPublickKeyFile atomically:YES encoding:NSASCIIStringEncoding error:&error];
    }
    if ([_privatekeyStr length] > 0) {
        [_privatekeyStr writeToFile:RSAPrivateKeyFile atomically:YES encoding:NSASCIIStringEncoding error:&error];
    }
}

/**
 *	@brief	导入公钥、私钥
 *
 *	@return
 */
- (BOOL)importRSAKeys
{
    FILE *publicKeyFile, *privateKeyFile;
    
    publicKeyFile = fopen([RSAPublickKeyFile cStringUsingEncoding:NSASCIIStringEncoding], "rb");
    privateKeyFile = fopen([RSAPrivateKeyFile cStringUsingEncoding:NSASCIIStringEncoding], "rb");
    
    
    if (NULL != publicKeyFile) {
        const char *publicKeyFileName = [RSAPublickKeyFile cStringUsingEncoding:NSASCIIStringEncoding];
        BIO *bpubKey = NULL;
        bpubKey = BIO_new(BIO_s_file());
        BIO_read_filename(bpubKey, publicKeyFileName);
        
        _rsa = PEM_read_bio_RSA_PUBKEY(bpubKey, NULL, NULL, NULL); //PEM_read_RSAPublicKey(file,NULL, NULL, NULL);
        BIO_free_all(bpubKey);
        assert(_rsa != NULL);
    }
    if (NULL != privateKeyFile) {
        const char *privateKeyFileName = [RSAPublickKeyFile cStringUsingEncoding:NSASCIIStringEncoding];
        BIO *bpriKey = NULL;
        bpriKey = BIO_new(BIO_s_file());
        BIO_read_filename(bpriKey, privateKeyFileName);
        
        _rsa = PEM_read_bio_RSAPrivateKey(bpriKey, NULL, NULL, NULL); //PEM_read_RSAPrivateKey(file, NULL, NULL, NULL);
        BIO_free_all(bpriKey);
        assert(_rsa != NULL);
    }

    return (_rsa !=NULL)?YES:NO;
}

//加密
- (int)encryptRSAKeyWithType:(KeyType)type from:(const unsigned char *)from flen:(int)flen to:(unsigned char *)to padding:(RSAPaddingType)padding
{
    if (from != NULL && to != NULL) {
        int status;//RSA_check_key(_rsa)不是程序生成的秘钥对，不需要检查。
//        if (!status) {
//            DLog(@"rsa check key status %d", status);
//            return -1;
//        }
//        
        switch (type) {
            case KeyTypePrivate:
                
                status = RSA_private_encrypt(flen, from, to, _rsa, padding);
            
                break;
                
            default:
                
                status = RSA_public_encrypt(flen, from, to, _rsa, padding);
                
                break;
        }
        return status;
    }
    return -1;
}

//解密
- (int)decryptRSAKeyWithType:(KeyType)type from:(const unsigned char *)from flen:(int)flen to:(unsigned char *)to padding:(RSAPaddingType)padding
{
    if (from != NULL && to != NULL) {
        int status = RSA_check_key(_rsa);
        if (!status) {
            return -1;
        }
        
        switch (type) {
            case KeyTypePrivate:
                
                status = RSA_private_decrypt(flen, from, to, _rsa, padding);
                
                break;
                
            default:
                
                status = RSA_public_decrypt(flen, from, to, _rsa, padding);
                
                break;
        }
        return status;
    }
    return -1;
}

//加密
- (NSData *)encryptRSAKeyWithType:(KeyType)type padding:(RSAPaddingType)padding plainText:(NSString *)text
{
    if (text && [text length]) {
        NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
        if (data && [data length]) {
            int flen = (unsigned int)[data length];
            unsigned char from[flen];
            bzero(from, sizeof(from));
            memcpy(from, [data bytes], flen);
            
            unsigned char to[128];
            bzero(to, sizeof(to));
            
            [self encryptRSAKeyWithType:type from:from flen:flen to:to padding:padding];
            
            NSData *encryptData = [NSData dataWithBytes:to length:sizeof(to)];
            
            return encryptData;
        }
    }
    
    return nil;
}

//解密
- (NSString *)decryptRSAKeyWithTYpe:(KeyType)type padding:(RSAPaddingType)padding plainTextData:(NSData *)data
{
    if (data && [data length]) {
        int flen = (unsigned int)[data length];
        unsigned char from[flen];
        bzero(from, sizeof(from));
        memcpy(from, [data bytes], [data length]);
        
        unsigned char to[128];
        bzero(to, sizeof(to));
        
        [self decryptRSAKeyWithType:type from:from flen:flen to:to padding:padding];
        
        NSData *decryptData = [NSData dataWithBytes:to length:sizeof(to)];
        
        NSString *decryptStr = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
        
        return decryptStr;
    }
    
    return nil;
}


@end
