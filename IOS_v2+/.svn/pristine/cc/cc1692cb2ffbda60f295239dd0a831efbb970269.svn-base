//
//  PublishViewController.m
//  Love
//
//  Created by lee wei on 15/3/16.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "PublishViewController.h"
#import "PublishShareViewController.h"
#import "PublishProductViewController.h"
#import "LOVNavigationController.h"
#import "SellerCenterViewController.h"
#import "JudgeIsDresserModel.h"

@interface PublishViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

typedef NS_ENUM(NSInteger, PublishButtonTag)
{
    PublishButtonTagWithCommission = 100,
    PublishButtonTagWithDresser = 101,
    PublishButtonTagWithShare = 102
};

@implementation PublishViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.navigationController.navigationBarHidden = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorRGBWithRed:255.f green:255.f blue:255.f alpha:1];
    
//    if (VersionNumber_iOS_7) {
//        self.edgesForExtendedLayout = UIRectEdgeNone;//view在导航栏下方
//    }
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0, kScreenHeight - 40.f, kScreenWidth, 40.f);
    closeButton.backgroundColor = [UIColor colorRGBWithRed:249.f green:249.f blue:249.f alpha:1.f];
    [closeButton setImage:[UIImage imageNamed:@"icon_x"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 120.f, kScreenWidth, 60.f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = MyLocalizedString(@"随时随地\n        分享美好");
    titleLabel.textColor = [UIColor darkGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:20.f];
    titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 300.f)/2, CGRectGetMaxY(titleLabel.frame) + 80.f, 300.f, 105.f)];
    btnView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btnView];
    
    NSArray *btnTitle = @[MyLocalizedString(@"商品"), MyLocalizedString(@"美妆师"), MyLocalizedString(@"分享")];
    NSArray *btnImage = @[@"icon_product", @"icon_artist", @"icon_share"];
    UIButton *button = nil;
    for (int i = 0; i < 3; i++) {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(80.f * i + 30.f * i, 0, 80.f, btnView.frame.size.height);
        button.backgroundColor = [UIColor clearColor];
        button.tag = 100 + i;
        [button setImage:[UIImage imageNamed:btnImage[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(puslishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:button];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90.f, button.frame.size.width, 25.f)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = btnTitle[i];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:15.f];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [button addSubview:titleLabel];
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button
- (void)closeButtonAction
{
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.selectedIndex = 0;
}

- (void)puslishButtonAction:(id)sender
{
    NSInteger tag = [sender tag];
    if (tag == PublishButtonTagWithCommission) {
        [JudgeIsDresserModel judgeIsDresserBlock:^(int code) {
            if (code == 1) {
                PublishProductViewController *productController = [[PublishProductViewController alloc] init];
                LOVNavigationController *productNav = [[LOVNavigationController alloc] initWithRootViewController:productController];
                [self presentViewController:productNav animated:YES completion:^{}];
            }else{
                SellerCenterViewController *productController = [[SellerCenterViewController alloc] init];
                productController.productpush = YES;
                productController.isPublish = YES;
                [self presentViewController:productController animated:YES completion:^{}];
            }
        }];
    }
    if (tag == PublishButtonTagWithDresser) {
        SellerCenterViewController *sellerCenter = [[SellerCenterViewController alloc] init];
        sellerCenter.publishisSeller = YES;
        sellerCenter.isPublish = YES;
        [self presentViewController:sellerCenter animated:YES completion:nil];
    }
    if (tag == PublishButtonTagWithShare) {
        PublishProductViewController *productController = [[PublishProductViewController alloc] init];
        productController.isShare = YES;
        LOVNavigationController *productNav = [[LOVNavigationController alloc] initWithRootViewController:productController];
        [self presentViewController:productNav animated:YES completion:^{}];
        
    }
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.selectedIndex = 0;
}

@end
