//
//  UserManager.m
//  Love
//
//  Created by 李伟 on 14-7-18.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "UserManager.h"
#import "KeychainItemWrapper.h"

static  NSString  *const baaiAccount = @"BAAIAccountNumber";

@implementation UserManager

+ (void)saveAccount:(NSString *)account  password:(NSString *)password
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:baaiAccount
                                                                       accessGroup:nil];
    [wrapper setObject:account forKey:(id)CFBridgingRelease(kSecAttrAccount)];
    [wrapper setObject:password forKey:(id)CFBridgingRelease(kSecValueData)];
}

+ (void)saveSig:(NSString *)sig uid:(NSString *)uid
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:baaiAccount
                                                                       accessGroup:nil];
    [wrapper setObject:sig forKey:(id)CFBridgingRelease(kSecAttrLabel)];
    [wrapper setObject:uid forKey:(id)CFBridgingRelease(kSecAttrComment)];
}

+ (void)saveOpenId:(NSString *)openid
{
    KeychainItemWrapper *warpper = [[KeychainItemWrapper alloc] initWithIdentifier:baaiAccount accessGroup:nil];
    [warpper setObject:openid forKey:(id)CFBridgingRelease(kSecAttrDescription)];
}

+ (NSString *)readAccount
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:baaiAccount
                                                                       accessGroup:nil];
    NSString *account = [wrapper objectForKey:(id)CFBridgingRelease(kSecAttrAccount)];
    return account;
}

+ (NSString *)readPassword
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:baaiAccount
                                                                       accessGroup:nil];
    NSString *password = [wrapper objectForKey:(id)CFBridgingRelease(kSecValueData)];
    return password;
}

+ (NSString *)readSig
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:baaiAccount
                                                                       accessGroup:nil];
    NSString *sig = [wrapper objectForKey:(id)CFBridgingRelease(kSecAttrLabel)];
    return sig;
}
+ (NSString *)readUid
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:baaiAccount
                                                                       accessGroup:nil];
    NSString *uid = [wrapper objectForKey:(id)CFBridgingRelease(kSecAttrComment)];
    return uid;
}

+ (NSString *)readOpenId
{
    KeychainItemWrapper *warpper = [[KeychainItemWrapper alloc] initWithIdentifier:baaiAccount accessGroup:nil];
    NSString *openid = [warpper objectForKey:(id)CFBridgingRelease(kSecAttrDescription)];
    return openid;
}

+ (void)restKeychain
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:baaiAccount
                                                                       accessGroup:nil];
    [wrapper resetKeychainItem];
}

@end
