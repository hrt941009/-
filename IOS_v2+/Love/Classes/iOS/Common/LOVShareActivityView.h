//
//  LOVShareActivityView.h
//  Love
//
//  Created by lee wei on 15/2/8.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//
//  分享
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

@interface ShareCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@interface LOVShareActivityView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, readonly) NSArray *dataArray; //分享内容 微信、朋友圈、微博、QQ、QQ空间
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSString *shareTitle; //标题
@property (nonatomic, strong) NSString *shareDesc;//描述
@property (nonatomic, strong) NSString *shareURL; //网址
@property (nonatomic, strong) NSString *shareImageURL; //图片地址

- (id)initWithShareType:(NSUInteger)type shareTitle:(NSString *)title shareDesc:(NSString *)desc shareURL:(NSString *)urlString shareImageURL:(NSString *)imageURL;
- (void)show;

@end
