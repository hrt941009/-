//
//  QREncoderViewController.m
//  Love
//
//  Created by lee wei on 14-10-4.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "QREncoderViewController.h"
#import "QRCodeGenerator.h"
#import "LOVShareActivityView.h"

@interface QREncoderViewController ()
@property (nonatomic, strong) LOVShareActivityView *shareActivetyView;
@end

@implementation QREncoderViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = MyLocalizedString(@"我的优惠码");
    }
    return self;
}

- (void)shareButtonAction{
    LOVShareActivityView *shareView = [[LOVShareActivityView alloc] initWithShareType:LOVShareTypeSinaWeibo shareTitle:@"八爱美妆优惠码" shareDesc:_couponCode shareURL:@"myEncode" shareImageURL:nil];
    [shareView show];
        
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(0, 0, 20, 20.f);
    shareButton.backgroundColor = [UIColor clearColor];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"commission_share_select"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *shareBarButton = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    self.navigationItem.rightBarButtonItem = shareBarButton;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 125)/2, (kScreenHeight - 380)/2, 125, 125)];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.image = [UIImage imageNamed:@"coupon"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, CGRectGetMaxY(imageView.frame) + 20, 100, 20)];
    label.text = @"分享八爱美妆";
    label.font = [UIFont systemFontOfSize:15.f];
    [self.view addSubview:label];
    
    UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) + 20, kScreenWidth, 40)];
    NSString *myStr = [NSString stringWithFormat:@"将您的优惠码%@分享给朋友，当他们下载注册成功输入您\n分享的优惠码，您也将自动获得购买优惠（100返利八爱币）\n方便您下次购买使用",_couponCode];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:myStr];
    [str setAttributes:@{NSForegroundColorAttributeName:[UIColor colorRGBWithRed:223 green:175 blue:188 alpha:1]} range:NSMakeRange(6, 6)];
    myLabel.attributedText = str;
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.numberOfLines = 3;
    myLabel.font = [UIFont systemFontOfSize:10.f];
    [self.view addSubview:myLabel];
    
}
@end
