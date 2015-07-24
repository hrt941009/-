//
//  LOVWebViewController.m
//  Love
//
//  Created by use on 15-4-9.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "LOVWebViewController.h"
#import "APPNetworkClient.h"
#import "UserManager.h"
#import "JudgeIsDresserModel.h"
static NSString * const kDresserCenter = @"seller/HTML/hzs/rz/MyHzs_Rz.html";
@interface LOVWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LOVWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.9137 green:0.2352 blue:0.4039 alpha:1];
    self.title = _myTitle;
    self.navigationController.navigationBarHidden = YES;
    _webView = [[UIWebView alloc] init];
    _webView.frame = CGRectMake(0, 20, kScreenWidth, kScreenHeight - 64);
    [self.view addSubview:_webView];
    NSString *userId = [UserManager readUid];
    __block int a = arc4random()%89999 + 10000;
    __block int b = arc4random()%89999 + 10000;
    __block NSString *UID = [NSString stringWithFormat:@"%d%@%d",a,userId,b];
    __block NSString *urlStr;
    [JudgeIsDresserModel judgeIsDresserBlock:^(int code) {
        if (code == 1) {
            urlStr = [NSString stringWithFormat:@"%@/%@?uid=%@&type=ios",[APPNetworkClient lovRequestADDR],_urlAddress,UID];
            NSURL *url = [NSURL URLWithString:urlStr];
            [_webView loadRequest:[NSURLRequest requestWithURL:url]];
            NSLog(@"%@",urlStr);
        }else{
            urlStr = [NSString stringWithFormat:@"%@/%@?uid=%@&type=ios",[APPNetworkClient lovRequestIP],kDresserCenter,UID];
            NSURL *url = [NSURL URLWithString:urlStr];
            [_webView loadRequest:[NSURLRequest requestWithURL:url]];
            NSLog(@"%@",urlStr);
        }
    }];
    
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
    
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    toolBar.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
    [toolBar setItems:myToolBarItems];
    [self.view addSubview:toolBar];

    
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
    if (_isPush == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)fouthButtonAction:(id)sender{
    [_webView reload];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
