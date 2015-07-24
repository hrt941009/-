//
//  FollowViewController.m
//  Love
//
//  Created by 李伟 on 14-6-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "FollowViewController.h"
#import "FollowSubjectViewController.h"
//#import "FollowSellerViewController.h"
//#import "FollowBrandViewController.h"
#import "FollowDresserLiveViewController.h"
#import "FollowDresserViewController.h"
#import "LoginViewController.h"

#import "SubjectViewController.h"
#import "ShoppViewController.h"
#import "DresserHomePageViewController.h"
#import "DresserDetailViewController.h"
#import "FollowTagViewController.h"
#import "FollowTagDetailViewController.h"
#import "UserHomeViewController.h"

#import "MyFollowModel.h"
#import "SellerHomePageModel.h"
#import "DresserDetailModel.h"
#import "BrandModel.h"
#import "DresserDetailModel.h"

#import "LOVSegmentControl.h"

typedef NS_ENUM(NSInteger, FollowCatagoryButtonTag)
{
    FollowCatagoryButtonTagWithSubject = 100,
    FollowCatagoryButtonTagWithSeller,
    FollowCatagoryButtonTagWithDresser,
    FollowCatagoryButtonTagWithBrand
};


@interface FollowViewController ()<UIAlertViewDelegate, FollowMasterDelegate, FollowDresserLiveControllerDelegate, FollowDresserControllerDelegate>//FollowSellerControllerDelegate

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) FollowSubjectViewController *subjectViewController;
//@property (nonatomic, strong) FollowSellerViewController *sellerViewController;
//@property (nonatomic, strong) FollowBrandViewController *brandViewController;

@property (nonatomic, strong) FollowDresserLiveViewController *dresserLiveViewController;
@property (nonatomic, strong) FollowDresserViewController *dresserViewController;

@property (nonatomic, strong) ShoppViewController *shopVC;
@property (nonatomic, strong) DresserHomePageViewController *dresserHomePageController;
@property (nonatomic, strong) DresserDetailViewController *detailViewController;

@property (nonatomic, strong) FollowTagViewController *followTagViewController;

@property (nonatomic, strong) FollowTagDetailViewController *tagDetailViewController;
@property (nonatomic, strong) UserHomeViewController *userHomeVC;

@property (nonatomic, strong) UIButton *subjectButton, *sellerButton, *brandButton, *dresserButton;


@end

@implementation FollowViewController


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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessed) name:LoginSuccessNotificationName object:nil];

    //MyLocalizedString(@"店铺") MyLocalizedString(@"买手"),
    NSArray *titleArray = @[MyLocalizedString(@"标签"), MyLocalizedString(@"美妆师"), MyLocalizedString(@"达人")];
    LOVSegmentControl *segmentControl = [[LOVSegmentControl alloc] initWithItems:titleArray];
    segmentControl.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 32.f);
    segmentControl.backgroundColor = [UIColor whiteColor];
    segmentControl.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    segmentControl.layer.borderWidth = 0.4;
    [segmentControl addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
    
    CGFloat viewWidth = kScreenWidth;
    CGFloat viewHeight = kScreenHeight - 64.f - 44.f - 37.f;
    _contentView = [[UIView alloc] initWithFrame: CGRectMake(0, CGRectGetMaxY(segmentControl.frame), viewWidth, viewHeight)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    //关注标签
    _followTagViewController = [[FollowTagViewController alloc] init];
    _followTagViewController.view.frame = _contentView.bounds;
    _followTagViewController.view.alpha = 1.f;
    _followTagViewController.delegate = self;
    [_contentView addSubview:_followTagViewController.view];
    
//    _subjectViewController = [[FollowSubjectViewController alloc] init];
//    _subjectViewController.view.frame = _contentView.bounds;
//    _subjectViewController.view.alpha = 1.f;
//    _subjectViewController.delegate = self;
//    [_contentView addSubview:_subjectViewController.view];
    
    /*---关注买手
    _sellerViewController = [[FollowSellerViewController alloc] init];
    _sellerViewController.view.frame = _contentView.bounds;
    _sellerViewController.delegate = self;
    */
    //关注美妆师
    _dresserViewController = [[FollowDresserViewController alloc] init];
    _dresserViewController.view.frame = _contentView.bounds;
    _dresserViewController.delegate = self;
    
    //关注达人
    _dresserLiveViewController = [[FollowDresserLiveViewController alloc] init];
    _dresserLiveViewController.view.frame = _contentView.bounds;
    _dresserLiveViewController.delegate = self;
    
    

    //[self setHeaderView];
    //[self setContentView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    _shopVC = nil;
    _dresserHomePageController = nil;
    _detailViewController = nil;
    
    _tagDetailViewController = nil;
    _userHomeVC = nil;
    if (_isLogin) {
//        [self setViewControllerConnectWithSuject:YES seller:NO brand:NO dresser:NO];
        [self setViewControllerConnectWithSubject:YES dresser:NO master:NO];
    }else{
//        [self setViewControllerConnectWithSuject:NO seller:NO brand:NO dresser:NO];
        [self setViewControllerConnectWithSubject:NO dresser:NO master:NO];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"登陆后可以看到关注的内容"
                                                           delegate:self
                                                  cancelButtonTitle:MyLocalizedString(@"OK")
                                                  otherButtonTitles:@"登录", nil];
        [alertView show];
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)loadFollowSubViews:(UIView *)view
{
    for (id view in [_contentView subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            [(UIView *)view removeFromSuperview];
        }
    }
    
    view.frame = _contentView.bounds;
    [_contentView addSubview:view];
    
}

- (void)changeAction:(LOVSegmentControl *)segmentControl
{
    NSUInteger idx = segmentControl.selectedSegmentIndex;
    switch (idx) {
        case 0:
            [self loadFollowSubViews:_followTagViewController.view];
//            [self setViewControllerConnectWithSuject:YES seller:NO brand:NO dresser:NO];
            [self setViewControllerConnectWithSubject:YES dresser:NO master:NO];
            break;
            
        case 1:
            [self loadFollowSubViews:_dresserViewController.view];
//            [self setViewControllerConnectWithSuject:NO seller:NO brand:NO dresser:YES];
            [self setViewControllerConnectWithSubject:NO dresser:YES master:NO];
            break;
            
        case 2:
            [self loadFollowSubViews:_dresserLiveViewController.view];
//            [self setViewControllerConnectWithSuject:NO seller:NO brand:YES dresser:NO];
            [self setViewControllerConnectWithSubject:NO dresser:NO master:YES];
            break;
            
        default:
            break;
    }
    
    /*-- 关注买手
     case 1:
     [self loadFollowSubViews:_sellerViewController.view];
     [self setViewControllerConnectWithSuject:NO seller:YES brand:NO dresser:NO];
     break;
     */
}


#pragma mark - set
//- (void)setViewControllerConnectWithSuject:(BOOL)subjectConnect seller:(BOOL)sellerConnect brand:(BOOL)brandConnect dresser:(BOOL)dresserConnect
//{
//    [_subjectViewController isConnect:subjectConnect];
//    //[_sellerViewController isConnect:sellerConnect];
//    [_dresserViewController isConnect:dresserConnect];
//    [_dresserLiveViewController isConnect:brandConnect];
//}

- (void)setViewControllerConnectWithSubject:(BOOL)tagConnect dresser:(BOOL)dresserConnect master:(BOOL)masterConnect{
    if (tagConnect) {
        [_followTagViewController isConnect:tagConnect];
    }
    if (dresserConnect) {
        [_dresserViewController isConnect:dresserConnect];
    }
    if (masterConnect) {
        [_dresserLiveViewController isConnect:masterConnect];
    }
}

#pragma mark - 跳转到标签详情
- (void)pushFollowTagDetailDelegateWithTagId:(NSString *)tagId tagName:(NSString *)tagName{
    if (_tagDetailViewController == nil) {
        _tagDetailViewController = [[FollowTagDetailViewController alloc] init];
        _tagDetailViewController.tagId = tagId;
        _tagDetailViewController.tagName = tagName;
        [self.navigationController pushViewController:_tagDetailViewController animated:YES];
    }
}

#pragma mark - 跳转到专辑
- (void)pushSubjectViewControllerWithTitle:(NSString *)title subjectId:(NSString *)subjectId subjectDesc:(NSString *)subjectDesc thumPath:(NSString *)thumPath
{
    SubjectViewController *subViewController = [[SubjectViewController alloc] initWithNibName:@"SubjectViewController" bundle:nil];
//    subViewController.subjectId = subjectId;//@"96";
//    subViewController.titleStr = title;
//    subViewController.infoStr = subjectDesc;
    [self.navigationController pushViewController:subViewController animated:YES];
}

#pragma mark - 跳转店铺
- (void)pushBrandViewControllerWithBrandID:(NSString *)bid
{
    if (_shopVC == nil) {
        _shopVC = [[ShoppViewController alloc] init];
        _shopVC.shopId = bid;
        [self.navigationController pushViewController:_shopVC animated:YES];
    }
}

#pragma mark - 跳转美妆师
- (void)pushDresserViewControllerWithDresserID:(NSString *)did Title:(NSString *)title
{
    if (_dresserHomePageController == nil) {
        _dresserHomePageController = [[DresserHomePageViewController alloc] init];
        _dresserHomePageController.sellerId = did;
        _dresserHomePageController.myTitle = title;
        [self.navigationController pushViewController:_dresserHomePageController animated:YES];
    }
}

#pragma mark -- 跳转美妆师直播详情
-(void)pushDresserDetailViewControllerWithUserID:(NSString *)userId userName:(NSString *)userName
{
    if (_userHomeVC == nil) {
        _userHomeVC = [[UserHomeViewController alloc] init];
        _userHomeVC.userId = userId;
        _userHomeVC.userName = userName;
        [self.navigationController pushViewController:_userHomeVC animated:YES];
    }
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




@end
