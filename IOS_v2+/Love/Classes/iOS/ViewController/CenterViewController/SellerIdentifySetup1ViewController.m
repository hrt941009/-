//
//  SellerIdentifySetup1ViewController.m
//  Love
//
//  Created by lee wei on 14-10-3.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SellerIdentifySetup1ViewController.h"
#import "SellerIdentifySetup2ViewController.h"
#import "LOVCircle.h"

@interface SellerIdentifySetup1ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIView *bgView;
@property (nonatomic, strong) IBOutlet UITextField *addressTextField;
@property (nonatomic, strong) IBOutlet UITextField *abroadAddressTextField;

@end

@implementation SellerIdentifySetup1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"我的个人资料");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    LOVCircle *header = [[LOVCircle alloc] initWithFrame:CGRectMake(55, 15, 100, 100) imageWithPath:_imgUrl placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    [self.view addSubview:header];
    
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = 3.f;
    
    
//    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    nextButton.frame = CGRectMake(0, 0, 80, 36.f);
//    nextButton.backgroundColor = [UIColor clearColor];
//    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
//    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    nextButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
//    [nextButton addTarget:self action:@selector(identify1NextAction: withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *nextBarButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
//    self.navigationItem.rightBarButtonItem = nextBarButton;
    
    _addressTextField.delegate = self;
    
    _abroadAddressTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button
//- (void)identify1NextAction:(id)sender withEvent:(UIEvent *)event
//{
//    UITouch *touch = [[event allTouches] anyObject];
//    if (touch.tapCount == 1) {
//        SellerIdentifySetup2ViewController *identifyViewController = [[SellerIdentifySetup2ViewController alloc] initWithNibName:@"SellerIdentifySetup2ViewController" bundle:nil];
//        [self.navigationController pushViewController:identifyViewController animated:YES];
//    }
//    
//}

#pragma mark - text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (IBAction)nextButtonAction:(id)sender {
        SellerIdentifySetup2ViewController *identifyViewController = [[SellerIdentifySetup2ViewController alloc] initWithNibName:@"SellerIdentifySetup2ViewController" bundle:nil];
        [self.navigationController pushViewController:identifyViewController animated:YES];
}
@end
