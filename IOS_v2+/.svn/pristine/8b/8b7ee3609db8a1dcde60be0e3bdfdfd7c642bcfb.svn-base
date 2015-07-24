//
//  PayViewController.m
//  Love
//
//  Created by use on 15-1-15.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "PayViewController.h"
#import "SVProgressHUD.h"
#import "APPNetworkClient.h"

@interface PayViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIToolbar *toolBar;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *urlStr = [NSString stringWithFormat:@"%@ht_dev/index.php/index/alipay/api?code=%@", [APPNetworkClient lovRequestIP], _code];
    NSURL *url = [NSURL URLWithString:urlStr];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight - 70)];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    _webView.delegate = self;
//    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    [_webView reload];
    
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50, kScreenWidth, 50)];
    [self.view addSubview:_toolBar];
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
    
    [_toolBar setItems:myToolBarItems];
    
}
- (void)firstButtonAction:(id)sender{
    [_webView goBack];
}

- (void)secondButtonAction:(id)sender{
    [_webView goForward];
}

- (void)thirdButtonAction:(id)sender{
    [_webView stopLoading];
    [self dismissViewControllerAnimated:YES completion:nil];
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
