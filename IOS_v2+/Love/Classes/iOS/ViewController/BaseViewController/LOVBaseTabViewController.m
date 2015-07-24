//
//  LOVBaseTabViewController.m
//  Love
//
//  Created by lee wei on 14-10-6.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LOVBaseTabViewController.h"

@interface LOVBaseTabViewController ()

@end

@implementation LOVBaseTabViewController

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
   
    self.view.backgroundColor = [UIColor colorRGBWithRed:215.f green:215.f blue:215.f alpha:1];
    
    if (VersionNumber_iOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;//view在导航栏下方
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
