//
//  LOVTabBarController.m
//  Love
//
//  Created by 李伟 on 14-6-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//  TabBar控制器

#import "LOVTabBarController.h"

#import "CommissionViewController.h"
#import "FollowViewController.h"
#import "LOVMeViewController.h"
#import "DresserViewController.h"
#import "PublishViewController.h"
#import "LOVNavigationController.h"

#import "UIViewController+MMDrawerController.h"

#import <QuartzCore/QuartzCore.h>

#import "LOVGuardView.h"
#import "LOVPageConfig.h"
#import "UIImage+iPhone5.h"
#import "UserManager.h"

#import "WaterFLayout.h"

#import "DresserHomePageModel.h"


@interface LOVTabBarController () <UITabBarControllerDelegate, LOVGuardViewDelegate, CommissionViewControllerDelegate>

@property (nonatomic, strong) LOVNavigationController *loginNavController;
@property (nonatomic, strong) LOVNavigationController *haitaoNavController;

@property (nonatomic, strong) CommissionViewController *commissionController;
@property (nonatomic, strong) FollowViewController *followController;
@property (nonatomic, strong) LOVMeViewController *meController;

@property (nonatomic, strong) LOVGuardView *guideView;


@end

@implementation LOVTabBarController

#pragma mark - 
/**
 设置tab bar
 */
- (void)setLovTabBarController
{
    
    CommissionViewController *commissionController = [[CommissionViewController alloc] init];
    commissionController.delegate = self;
    commissionController.title = MyLocalizedString(@"首页");
    _commissionController = commissionController;
    
//------ 海淘 ------
    PublishViewController *publishController = [[PublishViewController alloc] init];

    WaterFLayout* flowLayout = [[WaterFLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);

//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    DresserViewController *dresserController = [[DresserViewController alloc] initWithCollectionViewLayout:flowLayout];
    [DresserHomePageModel getDresserListPage:kLovStartPage pageNum:kLovPageNumber block:^(NSArray *array) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([array count] > 0) {
                    dresserController.firstData = array;
                }
            });
        });
        
    }];
    dresserController.title = MyLocalizedString(@"美妆师");
    
    FollowViewController *followController = [[FollowViewController alloc] init];
    followController.title = MyLocalizedString(@"关注");
    _followController = followController;
    
    LOVMeViewController *meController = [[LOVMeViewController alloc] init];
    meController.title = MyLocalizedString(@"我");
    _meController = meController;
    
    //-------- 导航 ------
        
    //-返利
    LOVNavigationController *commissionNavController = [[LOVNavigationController alloc] initWithRootViewController:commissionController];
    
    UIImage *item1Image = [UIImage imageNamed:@"tabbar_home"];
    UIImage *item1SelectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    //声明图片用原图 不渲染。否则返回后显示默认的蓝色
    if (VersionNumber_iOS_7) {
        item1SelectedImage = [item1SelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:MyLocalizedString(@"首页") image:item1Image selectedImage:item1SelectedImage];
    item1.tag = 1;
//    [[UITabBarItem alloc] initWithTitle:MyLocalizedString(@"Home") image:item1Image tag:1];
//    [item1 setFinishedSelectedImage:item1SelectedImage withFinishedUnselectedImage:item1Image];
    commissionNavController.tabBarItem = item1;
    
    //-美妆师
    LOVNavigationController *dresserNavController = [[LOVNavigationController alloc] initWithRootViewController:dresserController];

    UIImage *item2Image = [UIImage imageNamed:@"tabbar_dresser"];
    UIImage *item2SelectedImage = [UIImage imageNamed:@"tabbar_dresser_selected"];
    if (VersionNumber_iOS_7) {
        item2SelectedImage = [item2SelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:MyLocalizedString(@"美妆师") image:item2Image selectedImage:item2SelectedImage];
    item2.tag = 2;
//    [[UITabBarItem alloc] initWithTitle:MyLocalizedString(@"Dresser") image:item2Image tag:2];
//    [item2 setFinishedSelectedImage:item2SelectedImage withFinishedUnselectedImage:item2Image];
    dresserNavController.tabBarItem = item2;

//--------发布--------
    UIImage *publishImg = [UIImage imageNamed:@"tabbar_share"];
    CGFloat imgX = (kScreenWidth - publishImg.size.width)/2;
    CGFloat imgY = (self.tabBar.frame.size.height - publishImg.size.height)/2;
    UIImageView *imgView = [[UIImageView alloc] initWithImage:publishImg];
    imgView.frame = CGRectMake(imgX, imgY, publishImg.size.width, publishImg.size.height);
    
//    UIImage *item3Image = [UIImage imageNamed:@"tabbar_share"];
//    UIImage *item3SelectedImage = [UIImage imageNamed:@"tabbar_share"];
//    if (VersionNumber_iOS_7) {
//        item3SelectedImage = [item3SelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    }
//    LOVNavigationController *publishNav = [[LOVNavigationController alloc] initWithRootViewController:publishController];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:nil image:nil selectedImage:nil];
    item3.tag = 3;
    
    publishController.tabBarItem = item3;
    
    [self.tabBar addSubview:imgView];
    
    //-关注买手
    LOVNavigationController *followNavController = [[LOVNavigationController alloc] initWithRootViewController:followController];
   
    UIImage *item4Image = [UIImage imageNamed:@"tabbar_follow"];
    UIImage *item4SelectedImage = [UIImage imageNamed:@"tabbar_follow_selected"];
    if (VersionNumber_iOS_7) {
        item4SelectedImage = [item4SelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:MyLocalizedString(@"关注") image:item4Image selectedImage:item4SelectedImage];
    item4.tag = 4;

//    [[UITabBarItem alloc] initWithTitle:MyLocalizedString(@"My Follow") image:item4Image tag:4];
//    [item4 setFinishedSelectedImage:item4SelectedImage withFinishedUnselectedImage:item4Image];
    followNavController.tabBarItem = item4;
    
    //-个人中心
    LOVNavigationController *centerNavController = [[LOVNavigationController alloc] initWithRootViewController:meController];
    
    UIImage *item5Image = [UIImage imageNamed:@"tabbar_me"];
    UIImage *item5SelectedImage = [UIImage imageNamed:@"tabbar_me_selected"];
    if (VersionNumber_iOS_7) {
        item5SelectedImage = [item5SelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UITabBarItem *item5 = [[UITabBarItem alloc] initWithTitle:MyLocalizedString(@"我") image:item5Image selectedImage:item5SelectedImage];
    item5.tag = 5;
//    [[UITabBarItem alloc] initWithTitle:MyLocalizedString(@"我") image:item5Image tag:5];
//    [item5 setFinishedSelectedImage:item5SelectedImage withFinishedUnselectedImage:item5Image];
    centerNavController.tabBarItem = item5;
    
    //----------------

    [self setViewControllers:@[commissionNavController, dresserNavController, publishController, followNavController, centerNavController]
                    animated:YES];// haitaoNavController

}


#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        [self setLovTabBarController];


    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
//-----

    UIColor *tabBarColor = [UIColor googleWhite];
    if (VersionNumber_iOS_7) {
        self.tabBar.barTintColor = tabBarColor;
    }else{
        self.tabBar.tintColor = tabBarColor;
    }

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor CodeSchool]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor Adobe]} forState:UIControlStateSelected];
    

}

#pragma mark -
- (void)toggleLeftDrawerSide
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)toggleRightDrawerSide
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

#pragma mark -
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSString *sessionKey = [UserManager readSig];
    NSUInteger selectedIndex = tabBarController.selectedIndex;
    
    if (selectedIndex == 0) {
        [_commissionController reloadCommissionView];
    }
    if (selectedIndex == 1) {

    }
    if (selectedIndex == 2) {
        self.tabBar.hidden = YES;
    }

    if (selectedIndex == 3) {
        if ([sessionKey length] == 0) {
            _followController.isLogin = NO;
        }else{
            _followController.isLogin = YES;
        }
    }

    
    if (selectedIndex == 4) {
        if ([sessionKey length] == 0) {
            _meController.isLogin = NO;
        }else{
            _meController.isLogin = YES;
        }
    }

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
