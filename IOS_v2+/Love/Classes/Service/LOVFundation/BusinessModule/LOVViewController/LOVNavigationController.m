//
//  LOVNavigationController.m
//  Love
//
//  Created by 李伟 on 14-6-27.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LOVNavigationController.h"


@implementation LOVNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
	if (self) {
        
       
                
        UIColor *barColor = barColor = [UIColor colorRGBWithRed:233.f green:60.f blue:103.f alpha:1.f];
//        UIColor *barColor = barColor = [UIColor colorWithHexString:@"#e93c67"];
        if (VersionNumber_iOS_7) {
            self.navigationBar.barTintColor = barColor;
        }else{
            self.navigationBar.tintColor = barColor;
        }
        
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        
	}
	return self;
}


@end
