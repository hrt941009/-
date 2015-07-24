//
//  HaiTaoNavigationController.m
//  Love
//
//  Created by 李伟 on 14-8-23.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "HaiTaoNavigationController.h"

@implementation HaiTaoNavigationController


- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
	if (self) {
        
        
        UIColor *barColor = [UIColor colorRGBWithRed:191.f green:30.f blue:39.f alpha:1];//[UIColor Designmoo];//GoogleRed
        if (VersionNumber_iOS_7) {
            self.navigationBar.barTintColor = barColor;
        }else{
            self.navigationBar.tintColor = barColor;
        }
        
//        self.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor googleWhite]};
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor googleWhite]};
        
	}
	return self;
}


@end
