//
//  EncryptorAES.m
//  CSLCLottery
//
//  Created by 李伟 on 13-1-24.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import "AES256.h"
#import "GTMBase64.h"

const NSUInteger kAlgorithmKeySize = kCCKeySizeAES256;
const NSUInteger kPBKDFRounds = 10000;  // ~80ms on an iPhone 4

static Byte saltBuff[] = {0,1,2,3,4,5,6,7,8,9,0xA,0xB,0xC,0xD,0xE,0xF};

static Byte ivBuff[]   = {0xA,1,0xB,5,4,0xF,7,9,0x17,3,1,6,8,0xC,0xD,91};

@implementation AES256

/**
 加密的key
 
 @param  key:公共的key
 
 @return 返回data
*/
+ (NSData *)AESKeyForKey:(NSString *)key{                 
    
    NSMutableData *derivedKey = [NSMutableData dataWithLength:kAlgorithmKeySize];
    
    NSData *salt = [NSData dataWithBytes:saltBuff length:kCCKeySizeAES128];
    
    int result = CCKeyDerivationPBKDF(kCCPBKDF2,        // algorithm算法
                                      key.UTF8String,  // password密码
                                      key.length,      // passwordLength密码的长度
                                      salt.bytes,           // salt内容
                                      salt.length,          // saltLen长度
                                      kCCPRFHmacAlgSHA1,    // PRF
                                      kPBKDFRounds,         // rounds循环次数
                                      derivedKey.mutableBytes, // derivedKey
                                      derivedKey.length);   // derivedKeyLen derive:出自
    
    NSAssert(result == kCCSuccess,
             @"Unable to create AES key for spassword: %d", result);
    return derivedKey;
}

/**
 加密方法，AES 256位加密，并转换成Base64字符串
 
 @param  string:需要加密的字符串
 
 @return 返回一个Base64编码的加密字符串
*/
+ (NSString *)AES256EncryptBase64String:(NSString *)string
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *keyData = [userDefaults objectForKey:@"SessionKey"];

    const void  *by = [keyData bytes];
    const char(* dby)[32] = by;
    
    NSData *plainText = [string dataUsingEncoding:NSUTF8StringEncoding];
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
	NSUInteger dataLength = [plainText length];
    
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);
    bzero(buffer, sizeof(buffer));
	
	size_t numBytesEncrypted = 0;
    
	CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          dby, kCCKeySizeAES256,
										  ivBuff /* initialization vector (optional) */,
										  [plainText bytes], dataLength, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesEncrypted);
	if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
		return [GTMBase64 stringByEncodingData:encryptData];
	}
	free(buffer); //free the buffer;
	return nil;
}

/**
 解密方法，将AES256位加密的Base64字符串解密
 
 @param  string:需要加密的字符串
 
 @return 返回解密后的字符串
*/
+ (NSString *)AES256DecryptBase64String:(NSString *)string
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *keyData = [userDefaults objectForKey:@"SessionKey"];
    const void  *by = [keyData bytes];
    const char(* dby)[32] = by;
    
    NSData *cipherData = [GTMBase64 decodeString:string];//[NSData dataFromBase64String:string];
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
	bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
	NSUInteger dataLength = [cipherData length];
	
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc(bufferSize);

    
	size_t numBytesDecrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode,
										  dby, kCCKeySizeAES256,
										  ivBuff ,/* initialization vector (optional) */
										  [cipherData bytes], dataLength, /* input */
										  buffer, bufferSize, /* output */
										  &numBytesDecrypted);
	
	if (cryptStatus == kCCSuccess) {
        NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
		return [[NSString alloc] initWithData:encryptData encoding:NSUTF8StringEncoding];
	}
	
	free(buffer); //free the buffer;
	return nil;
}



@end
