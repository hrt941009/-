//
//  LOVMeViewController.m
//  Love
//
//  Created by lee wei on 14-10-1.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LOVMeViewController.h"
#import "LoginViewController.h"
#import "CenterViewController.h"
#import "MySubjectViewController.h"
#import "SettingViewController.h"
#import "MyCartViewController.h"
#import "OrderCenterViewController.h"
#import "BirthdayViewController.h"
//#import "MyLikeViewController.h"
#import "LikeMainViewController.h"
#import "SellerCenterViewController.h"
#import "LOVCircle.h"
#import "UserManager.h"
#import "MeView.h"
#import "UserInfoModel.h"
#import "CouponViewController.h"
#import "NotificationCenterViewController.h"
#import "LOVWebViewController.h"

@interface LOVMeViewController ()<MeViewDelegate, UIAlertViewDelegate, RemoveMeViewSubviewsDelegate,BackMainViewDelegate>

@property (nonatomic, strong) MeView *meView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSString *myTag;//判断是否进入首页

@end

@implementation LOVMeViewController
#pragma mark -- BackMainViewDelegate
- (void)backMainViewWithTag:(NSString *)tag{
    _myTag = tag;
}
#pragma mark -- RemoveMeViewSubviewsDelegate
- (void)removeMeViewSubviews{
    for (UIView *view in _meView.subviews) {
        [view removeFromSuperview];
    }
    _meView = nil;
}


- (void)setMyCenterView
{
    //-----
//    for (UIView *view in _meView.subviews) {
//        [view removeFromSuperview];
//    }
    if (_meView == nil) {
        _meView = [[MeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _meView.backgroundColor = [UIColor clearColor];
        _meView.delegate = self;
        [self.view addSubview:_meView];
        
        //添加背景图片
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
        bgImageView.image = [UIImage imageNamed:@"bg_my"];
        [self.view addSubview:bgImageView];
        [self.view sendSubviewToBack:bgImageView];
        
        NSString *uid = [UserManager readUid];
        [UserInfoModel getUserInfoWithUserID:uid];
        
    }
}

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    _meView = nil;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userInfoNotice:) name:kUserInfoNotificationName object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginSuccessed)
                                                 name:LoginSuccessNotificationName
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if ([_myTag isEqualToString:kAllAddressKey]) {
        self.tabBarController.selectedIndex = 0;
    }
    _myTag = nil;
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if (_isLogin) {
//        _meView = nil;
        [self setMyCenterView];
    }else{
//        _meView = nil;
//        for (UIView *view in _meView.subviews) {
//            [view removeFromSuperview];
//        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:MyLocalizedString(@"请登录")
                                                           delegate:self
                                                  cancelButtonTitle:MyLocalizedString(@"Cancel")
                                                  otherButtonTitles:MyLocalizedString(@"登录"), nil];
        alertView.delegate = self;
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUserInfoNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LoginSuccessNotificationName object:nil];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        self.tabBarController.selectedIndex = 0;
    }
    if (buttonIndex == 1) {
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}

#pragma mark - notice
- (void)loginSuccessed
{
    _isLogin = YES;
}

- (void)userInfoNotice:(NSNotification *)notice
{
    NSArray *array = [notice object];
    _dataArray = array;
    UserInfoModel *model = (UserInfoModel *)[array lastObject];
    _meView.userNameLabel.text = model.userName;
    _meView.accountLabel.numberOfLines = 0;
    _meView.accountLabel.text = model.userIntro;
    _meView.couponLabel.text = [NSString stringWithFormat:@"%@:%@", MyLocalizedString(@"优惠券"), model.couponNum];
    _meView.baaiCoinLabel.text = [NSString stringWithFormat:@"%@:%@", MyLocalizedString(@"八爱币"), model.baaiMonney];;
    _meView.discountLabel.text = [NSString stringWithFormat:@"%@:%@", MyLocalizedString(@"返利"), model.rebatePrice];;
    LOVCircle *header = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, _meView.iconImageView.frame.size.width, _meView.iconImageView.frame.size.height)
                                           imageWithPath:model.headerPath
                                        placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    [_meView.iconImageView addSubview:header];
}

- (void)editBirthdaySuccessNotice:(NSNotification *)notice
{
    NSString *uid = [UserManager readUid];
    [UserInfoModel getUserInfoWithUserID:uid];
}


#pragma mark - me view delegate
- (void)tapHeaderView
{
    CenterViewController *viewController = [[CenterViewController alloc] init];
    viewController.dataList = _dataArray;
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)meViewButtonActionWithTag:(NSInteger)tag
{
    if (tag == MyViewButtonTagWithOrder) {
        OrderCenterViewController *orderCenterViewController = [[OrderCenterViewController alloc] init];
        [self.navigationController pushViewController:orderCenterViewController animated:YES];
    }
    if (tag == MyViewButtonTagWithSubject) {
        MySubjectViewController *mySubjectViewController = [[MySubjectViewController alloc] init];
        UserInfoModel *model = (UserInfoModel*)[_dataArray lastObject];
        mySubjectViewController.userID = model.userID;
        mySubjectViewController.titleStr = model.userName;
        mySubjectViewController.signStr = model.userIntro;
        mySubjectViewController.userHeader = model.headerPath;
        [self.navigationController pushViewController:mySubjectViewController animated:YES];
    }
    if (tag == MyViewButtonTagWithLike) {
//        MyLikeViewController *likeViewController = [[MyLikeViewController alloc] init];
//        [self.navigationController pushViewController:likeViewController animated:YES];
        LikeMainViewController *likeMainVC = [[LikeMainViewController alloc] init];
        likeMainVC.delegate = self;
        [self.navigationController pushViewController:likeMainVC animated:YES];
    }
    if (tag == MyViewButtonTagWithRebateAndCoin) {
        SellerCenterViewController *sellerVC = [[SellerCenterViewController alloc] init];
        sellerVC.RebateAndCoin = YES;
//        RebateAndCoinViewController *rebateCoinViewController = [[RebateAndCoinViewController alloc] init];
//        [self.navigationController presentViewController:sellerVC animated:YES completion:nil];
        [self.navigationController pushViewController:sellerVC animated:YES];
//        [self.navigationController pushViewController:rebateCoinViewController animated:YES];
    }
    if (tag == MyViewButtonTagWithNotifacitionCenter) {
        NotificationCenterViewController *NotiCenterVC = [[NotificationCenterViewController alloc] init];
        [self.navigationController pushViewController:NotiCenterVC animated:YES];
    }
    if (tag == MyViewButtonTagWithSetting) {
        SettingViewController *settingViewController = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:settingViewController animated:YES];
    }
    if (tag == MyViewButtonTagWithCart) {
        MyCartViewController *cartViewController = [[MyCartViewController alloc] init];
        [self.navigationController pushViewController:cartViewController animated:YES];
    }
    if (tag == MyViewButtonTagWithSellerCenter) {
        SellerCenterViewController *sellerCenter = [[SellerCenterViewController alloc] init];
        sellerCenter.isSeller = YES;
        [self.navigationController pushViewController:sellerCenter animated:YES];
//        self.tabBarController.selectedIndex = 0;
    }
//  美妆师
    if (tag == MyViewButtonTagWithFriend) {
        LOVWebViewController *webView = [[LOVWebViewController alloc] init];
        webView.urlAddress = @"Manage/Manage_Hzs.html";
        webView.isPush = YES;
        webView.myTitle = @"美妆师";
//        [self presentViewController:webView animated:YES completion:nil];
        [self.navigationController pushViewController:webView animated:YES];
    }
}

@end
