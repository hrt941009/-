//
//  PublishShareViewController.m
//  Love
//
//  Created by lee wei on 15/3/18.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "PublishShareViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface PublishShareViewController ()

@property (nonatomic, strong) IBOutlet UIView *bgView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIButton *timeLineButton, *weixinButton, *qqButton, *qzoneButton, *weiboButton;

- (IBAction)shareToWeixin;
- (IBAction)shareToWeixinTimeline;
- (IBAction)shareToQQ;
- (IBAction)shareToQzone;
- (IBAction)shareToSinaWeibo;

@end

@implementation PublishShareViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"share_bg"]];
    bgImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    bgImageView.userInteractionEnabled = YES;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    
    UITapGestureRecognizer *tapImgView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgViewAction)];
    [bgImageView addGestureRecognizer:tapImgView];
    
    UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewAction)];
    [_bgView addGestureRecognizer:tapView];
    
    _titleLabel.text = MyLocalizedString(@"快和小伙伴们分享吧");
    _titleLabel.textColor = [UIColor whiteColor];
    
    _bgView.frame = CGRectMake((kScreenWidth - 300.f)/2, 120.f, 300.f, 370.f);
    _bgView.backgroundColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
- (void)tapImgViewAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapViewAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 分享
- (IBAction)shareToWeixin
{
    [self shareSDKType:ShareTypeWeixiSession];
}

- (IBAction)shareToWeixinTimeline
{
    [self shareSDKType:ShareTypeWeixiTimeline];
}

- (IBAction)shareToQQ
{
    [self shareSDKType:ShareTypeQQ];
}

- (IBAction)shareToQzone
{
    [self shareSDKType:ShareTypeQQSpace];
}

- (IBAction)shareToSinaWeibo
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
