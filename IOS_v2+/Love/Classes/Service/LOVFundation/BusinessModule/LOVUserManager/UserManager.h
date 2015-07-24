//
//  UserManager.h
//  Love
//
//  Created by 李伟 on 14-7-18.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KeychainItemWrapper;

@interface UserManager : NSObject


+ (void)saveAccount:(NSString *)account  password:(NSString *)password;
+ (void)saveSig:(NSString *)sig uid:(NSString *)uid;
+ (void)saveOpenId:(NSString *)openid;

+ (NSString *)readAccount;
+ (NSString *)readPassword;
+ (NSString *)readSig;
+ (NSString *)readUid;
+ (NSString *)readOpenId;

+ (void)restKeychain;

@end
