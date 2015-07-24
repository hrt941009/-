//
//  DresserDetailViewController.h
//  Love
//
//  Created by lee wei on 14-10-7.
//  Copyright (c) 2014年 李伟. All rights reserved.
//
//  美妆师详细页面
//

#import <UIKit/UIKit.h>

@interface DresserDetailViewController : LOVBaseViewController

@property (nonatomic, strong) NSString *artistID;
@property (nonatomic, strong) NSString *liveID;
@property (nonatomic, strong) NSString *publishTitle;
@property (nonatomic, strong) NSString *publishContent;
@property (nonatomic, strong) NSString *publishDate;
@property (nonatomic, assign) int isAttention; //是否喜欢 0 未喜欢，1 喜欢

@property (nonatomic, strong) NSArray  *imageArray;

@property (nonatomic, assign) BOOL isHomePage;//判断是从哪个页面进入，yes 首页 no 美妆师主页

- (void)getPhotoArray:(NSArray *)imgArray;

@end
