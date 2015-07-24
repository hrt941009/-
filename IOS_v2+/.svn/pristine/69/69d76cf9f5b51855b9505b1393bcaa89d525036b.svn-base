//
//  LOVShareActivityView.m
//  Love
//
//  Created by lee wei on 15/2/8.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "LOVShareActivityView.h"

@interface NSString (URL)
- (NSString *)URLEncodedString;
@end

@implementation NSString (URL)

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}
@end

@implementation ShareCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 50.f)/2, 0, 50.f, 50.f)];
        _iconImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconImageView.frame), self.frame.size.width, 24.f)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLabel];
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
}


@end

static NSString * const kCellReuseIdentifier = @"kCellReuseIdentifier";


@implementation LOVShareActivityView

- (id)initWithShareType:(NSUInteger)type shareTitle:(NSString *)title shareDesc:(NSString *)desc shareURL:(NSString *)urlString shareImageURL:(NSString *)imageURL
{
    self = [super init];
    if (self) {
        
        self.frame = [[UIScreen mainScreen] bounds];
        self.alpha = 0.f;
        
        UIWindow *win =  [[UIApplication sharedApplication] keyWindow];
        [win addSubview:self];
        
        //---
        self.shareTitle = title;
        self.shareDesc = desc;
        self.shareURL = urlString;
        self.shareImageURL = imageURL;
    }
    return self;
}

//显示分享
- (void)show
{
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = self.bounds;
    bgButton.backgroundColor = [UIColor darkGrayColor];
    bgButton.alpha = 0.5;
    [bgButton addTarget:self action:@selector(hiddenViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgButton];
    
    UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 210.f, self.frame.size.width, 210.f)];
    shareView.backgroundColor = [UIColor colorRGBWithRed:246.f green:246.f blue:246.f alpha:1.f];
    [self addSubview:shareView];
    
    //----
    _dataArray = @[@[NSLocalizedString(@"微信", nil), @"share_weixin"],
                   @[NSLocalizedString(@"朋友圈", nil), @"share_weixin_timeline"],
                   @[NSLocalizedString(@"新浪微博", nil), @"share_weibo"],
                   @[NSLocalizedString(@"QQ", nil), @"share_qq"],
                   @[NSLocalizedString(@"QQ空间", nil), @"share_qzone"]];
    
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 0, self.frame.size.width - 10.f, 30.f)];
    introLabel.backgroundColor = [UIColor clearColor];
    introLabel.textColor = [UIColor blackColor];
    introLabel.textAlignment = NSTextAlignmentLeft;
    introLabel.font = [UIFont systemFontOfSize:14.f];
    introLabel.text = NSLocalizedString(@"分享到...", @"");
    [shareView addSubview:introLabel];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(90.f, 76.f)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(introLabel.frame), self.frame.size.width, shareView.frame.size.height - 30.f)
                                         collectionViewLayout:flowLayout];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    _collectionView.scrollEnabled = NO;
    [_collectionView setBackgroundColor:[UIColor colorRGBWithRed:246.f green:246.f blue:246.f alpha:1.f]];
    [shareView addSubview:_collectionView];
    
    [_collectionView registerClass:[ShareCollectionCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
    
    //--
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1.f;
    }];
}


- (void)hiddenViewAction
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    }];
}

#pragma mark - collection view data source methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShareCollectionCell *cell = (ShareCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    
    NSArray *list = _dataArray[indexPath.row];
    cell.titleLabel.text = list[0];
    cell.iconImageView.image = [UIImage imageNamed:list[1]];
    
    return cell;
}

#pragma mark - delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = indexPath.row;
    if (row == LOVShareTypeWeixin) {
        [self shareToWeixin];
    }
    if (row == LOVShareTypeWeixinTimeline) {
        [self shareToWeixinTimeline];
    }
    if (row == LOVShareTypeQQ) {
        [self shareToQQ];
    }
    if (row == LOVShareTypeQzone) {
        [self shareToQzone];
    }
    if (row == LOVShareTypeSinaWeibo) {
        [self shareToSinaWeibo];
    }
    
}

- (void)shareToWeixin
{
    [self shareSDKType:ShareTypeWeixiSession];
}

- (void)shareToWeixinTimeline
{
    [self shareSDKType:ShareTypeWeixiTimeline];
}

- (void)shareToQQ
{
    [self shareSDKType:ShareTypeQQ];
}

- (void)shareToQzone
{
    [self shareSDKType:ShareTypeQQSpace];
}

- (void)shareToSinaWeibo
{
    [self shareSDKType:ShareTypeSinaWeibo];
}

- (void)shareSDKType:(ShareType)type
{
    id<ISSContent> publishContent = [ShareSDK content:self.shareDesc
                                       defaultContent:@""
                                                image:[ShareSDK imageWithUrl:self.shareImageURL]
                                                title:self.shareTitle
                                                  url:self.shareURL
                                          description:self.shareDesc
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    
    
    //显示分享菜单
    [ShareSDK showShareViewWithType:type
                          container:container
                            content:publishContent
                      statusBarTips:YES
                        authOptions:nil
                       shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                           oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                            qqButtonHidden:NO
                                                     wxSessionButtonHidden:NO
                                                    wxTimelineButtonHidden:NO
                                                      showKeyboardOnAppear:NO
                                                         shareViewDelegate:nil
                                                       friendsViewDelegate:nil
                                                     picViewerViewDelegate:nil]
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 
                                 if (state == SSPublishContentStateSuccess)
                                 {
                                     NSLog(@"发表成功");
                                 }
                                 else if (state == SSPublishContentStateFail)
                                 {
                                     NSLog(@"发布失败!error code == %ld, error code == %@",(unsigned long)[error errorCode], [error errorDescription]);
                                 }
                             }];
}



@end
