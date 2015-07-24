//
//  AboutBaaiAppViewController.m
//  Love
//
//  Created by use on 15-1-6.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "AboutBaaiAppViewController.h"

@interface AboutBaaiAppViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *baaiIcon;
@property (weak, nonatomic) IBOutlet UIImageView *erWeiMa;

@end

@implementation AboutBaaiAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = MyLocalizedString(@"关于8爱");
    
    _baaiIcon.layer.masksToBounds = YES;
    _baaiIcon.layer.cornerRadius = 4.f;
    
    
    _erWeiMa.frame = CGRectMake(35, 70, kScreenWidth -90, 220);
    _erWeiMa.layer.masksToBounds = YES;
    _erWeiMa.layer.cornerRadius = 4.f;
    _erWeiMa.contentMode = UIViewContentModeCenter;
    
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
