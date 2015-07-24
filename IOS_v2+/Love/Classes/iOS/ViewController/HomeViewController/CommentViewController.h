//
//  CommentViewController.h
//  Love
//
//  Created by use on 15-3-20.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//
//评论列表页
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MyCommentStatus)
{
    MyCommentStatusShare = 0,
    MyCommentStatusProduct,
    MyCommentStatusDresser
};
@interface CommentViewController : LOVBaseViewController
@property (nonatomic, strong) NSString *shareId;
@property (nonatomic, strong) NSString *totleDiscussNum;

@property (nonatomic, strong) NSString *productId;

@property (nonatomic, strong) NSString *liveId;

@property (nonatomic, assign) NSInteger commentStatu;
/**
 *  美妆师
 */
@property (nonatomic, strong) NSString *dresserName;
@end
