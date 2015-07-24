//
//  SellerCenterViewController.m
//  Love
//
//  Created by use on 14-12-19.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "SellerCenterViewController.h"
#import "UserManager.h"
#import "JudgeIsDresserModel.h"
#import "SVProgressHUD.h"
#import "APPNetworkClient.h"
#import "LOVNavigationController.h"
#import "PublishViewController.h"
#import "PublishProductViewController.h"


static NSString * const kSellerCenter = @"seller/HTML/SailerCenter.html";
static NSString * const kDresserCenter = @"http://m.baai.com/baai2/apphtml/Manage.html";
static NSString * const kRebateAndIcon = @"ht_app/HTML/PersonCenter/Benefit.html";

@interface SellerCenterViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation SellerCenterViewController

- (id)init
{
    self = [super init];
    if (self) {
//        self.view.backgroundColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:0.9137 green:0.2352 blue:0.4039 alpha:1];
    self.navigationController.navigationBarHidden = YES;
    _webView.frame = CGRectMake(0, 20, kScreenWidth, kScreenHeight - 64);
    NSString *userId = [UserManager readUid];
    
    __block int a = arc4random()%89999 + 10000;
    __block int b = arc4random()%89999 + 10000;
    __block NSString *UID = [NSString stringWithFormat:@"%d%@%d",a,userId,b];
//商品发布判断
    if (_productpush) {
        [JudgeIsDresserModel judgeIsDresserBlock:^(int code) {
            NSString *urlStr = nil;
            if (code == 1) {
                _webView.alpha = 0;
                PublishProductViewController *productController = [[PublishProductViewController alloc] init];
                LOVNavigationController *productNav = [[LOVNavigationController alloc] initWithRootViewController:productController];
                [self presentViewController:productNav animated:YES completion:^{}];
            }else if(code==0){
                //                urlStr = [NSString stringWithFormat:@"%@%@?uid=%@&type=ios",[APPNetworkClient lovRequestIP],kDresserCenter,UID];
                urlStr = [NSString stringWithFormat:@"%@?uid=%@&type=ios",@"http://m.baai.com/baai2/apphtml/MyHzs_Rz.html",UID];
            }else{
                urlStr = [NSString stringWithFormat:@"%@?uid=%@&type=ios",@"http://m.baai.com/baai2/apphtml/Auditing.html",UID];
            }
            
            if (code !=1){
            NSURL *url = [NSURL URLWithString:urlStr];
            [_webView loadRequest:[NSURLRequest requestWithURL:url]];
            //                不是美妆师跳转美妆师认证页面
            
            _webView.delegate = self;
            _webView.backgroundColor = [UIColor clearColor];
            NSMutableArray *myToolBarItems = [[NSMutableArray alloc] init];
            
            UIBarButtonItem *firstButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_back_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(firstButtonAction:)];
            firstButton.width = kScreenWidth/5;
            [myToolBarItems addObject:firstButton];
            
            UIBarButtonItem *secondButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_forward_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(secondButtonAction:)];
            secondButton.width = kScreenWidth/5;
            [myToolBarItems addObject:secondButton];
            
            UIBarButtonItem *thirdButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_stop_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(thirdButtonAction:)];
            thirdButton.width = kScreenWidth/5;
            [myToolBarItems addObject:thirdButton];
            
            UIBarButtonItem *fouthButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_refresh_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(fouthButtonAction:)];
            fouthButton.width = kScreenWidth/5;
            [myToolBarItems addObject:fouthButton];
            
            _toolBar.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
            
            [_toolBar setItems:myToolBarItems];
            }
        }];
    }

//美妆师发布判断
    if (_publishisSeller) {
        [JudgeIsDresserModel judgeIsDresserBlock:^(int code) {
            NSString *urlStr = nil;
            if (code == 1) {
                //                urlStr = [NSString stringWithFormat:@"%@%@?uid=%@&type=ios",[APPNetworkClient lovRequestIP],kSellerCenter,UID];
                urlStr = [NSString stringWithFormat:@"%@?uid=%@&type=ios",@"http://m.baai.com/baai2/apphtml/CreateTheme.html",UID];
            }else if(code==0){
                //                urlStr = [NSString stringWithFormat:@"%@%@?uid=%@&type=ios",[APPNetworkClient lovRequestIP],kDresserCenter,UID];
                urlStr = [NSString stringWithFormat:@"%@?uid=%@&type=ios",@"http://m.baai.com/baai2/apphtml/MyHzs_Rz.html",UID];
            }else{
                urlStr = [NSString stringWithFormat:@"%@?uid=%@&type=ios",@"http://m.baai.com/baai2/apphtml/Auditing.html",UID];
            }
            NSURL *url = [NSURL URLWithString:urlStr];
            [_webView loadRequest:[NSURLRequest requestWithURL:url]];
            //                不是美妆师跳转美妆师认证页面
            
            _webView.delegate = self;
            _webView.backgroundColor = [UIColor clearColor];
            NSMutableArray *myToolBarItems = [[NSMutableArray alloc] init];
            
            UIBarButtonItem *firstButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_back_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(firstButtonAction:)];
            firstButton.width = kScreenWidth/5;
            [myToolBarItems addObject:firstButton];
            
            UIBarButtonItem *secondButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_forward_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(secondButtonAction:)];
            secondButton.width = kScreenWidth/5;
            [myToolBarItems addObject:secondButton];
            
            UIBarButtonItem *thirdButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_stop_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(thirdButtonAction:)];
            thirdButton.width = kScreenWidth/5;
            [myToolBarItems addObject:thirdButton];
            
            UIBarButtonItem *fouthButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_refresh_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(fouthButtonAction:)];
            fouthButton.width = kScreenWidth/5;
            [myToolBarItems addObject:fouthButton];
            
            _toolBar.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
            
            [_toolBar setItems:myToolBarItems];
        }];
    }
    
    if (_isSeller) {
        [JudgeIsDresserModel judgeIsDresserBlock:^(int code) {
            NSString *urlStr = nil;
            if (code == 1) {
//                urlStr = [NSString stringWithFormat:@"%@%@?uid=%@&type=ios",[APPNetworkClient lovRequestIP],kSellerCenter,UID];
                urlStr = [NSString stringWithFormat:@"%@?uid=%@&type=ios",@"http://m.baai.com/baai2/apphtml/BargainingManage.html",UID];
            }else{
//                urlStr = [NSString stringWithFormat:@"%@%@?uid=%@&type=ios",[APPNetworkClient lovRequestIP],kDresserCenter,UID];
                urlStr = [NSString stringWithFormat:@"%@?uid=%@&type=ios",@"http://m.baai.com/baai2/apphtml/MyHzs_Rz.html",UID];
            }
            NSURL *url = [NSURL URLWithString:urlStr];
            [_webView loadRequest:[NSURLRequest requestWithURL:url]];
//                不是美妆师跳转美妆师认证页面
               
            _webView.delegate = self;
            _webView.backgroundColor = [UIColor clearColor];
            NSMutableArray *myToolBarItems = [[NSMutableArray alloc] init];
                
            UIBarButtonItem *firstButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_back_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(firstButtonAction:)];
            firstButton.width = kScreenWidth/5;
            [myToolBarItems addObject:firstButton];
                
            UIBarButtonItem *secondButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_forward_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(secondButtonAction:)];
            secondButton.width = kScreenWidth/5;
            [myToolBarItems addObject:secondButton];
                
            UIBarButtonItem *thirdButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_stop_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(thirdButtonAction:)];
            thirdButton.width = kScreenWidth/5;
            [myToolBarItems addObject:thirdButton];
                
            UIBarButtonItem *fouthButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_refresh_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(fouthButtonAction:)];
            fouthButton.width = kScreenWidth/5;
            [myToolBarItems addObject:fouthButton];
            
            _toolBar.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
            
            [_toolBar setItems:myToolBarItems];
        }];
    }
    
    if (_RebateAndCoin){
//        NSString *urlStr = [NSString stringWithFormat:@"%@%@?uid=%@&type=ios",[APPNetworkClient lovRequestIP],kRebateAndIcon,UID];
       NSString *urlStr = [NSString stringWithFormat:@"%@?uid=%@&type=ios",@"http://m.baai.com/baai2/apphtml/Benefit.html",UID];
        NSURL *url = [NSURL URLWithString:urlStr];
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor clearColor];
        NSMutableArray *myToolBarItems = [[NSMutableArray alloc] init];
        
        UIBarButtonItem *firstButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_back_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(firstButtonAction:)];
        firstButton.width = kScreenWidth/5;
        [myToolBarItems addObject:firstButton];
        
        UIBarButtonItem *secondButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_forward_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(secondButtonAction:)];
        secondButton.width = kScreenWidth/5;
        [myToolBarItems addObject:secondButton];
        
        UIBarButtonItem *thirdButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_stop_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(thirdButtonAction:)];
        thirdButton.width = kScreenWidth/5;
        [myToolBarItems addObject:thirdButton];
        
        UIBarButtonItem *fouthButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"web_refresh_unable"] style:UIBarButtonItemStylePlain target:self action:@selector(fouthButtonAction:)];
        fouthButton.width = kScreenWidth/5;
        [myToolBarItems addObject:fouthButton];
        
        _toolBar.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
        
        [_toolBar setItems:myToolBarItems];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)firstButtonAction:(id)sender{
    [_webView goBack];
}

- (void)secondButtonAction:(id)sender{
    [_webView goForward];
}

- (void)thirdButtonAction:(id)sender{
    [SVProgressHUD dismiss];
    [_webView stopLoading];
//    NSString *uis = [UserManager readUid];
//    NSLog(@"%@",uis);
    if (_isPublish == YES) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)fouthButtonAction:(id)sender{
    [_webView reload];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -- UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:MyLocalizedString(@"加载中...")];
    NSLog(@"webViewDidStartLoad");
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    NSLog(@"webViewDidFinishLoad");

//    NSString *uis = [UserManager readUid];
//    NSLog(@"%@",uis);
}

-(void)webView:(UIWebView*)webView  DidFailLoadWithError:(NSError*)error{
    [SVProgressHUD dismiss];
    NSLog(@"DidFailLoadWithError");
//    [webView reload];
    [SVProgressHUD showErrorWithStatus:MyLocalizedString(@"加载失败，请重试!")];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
