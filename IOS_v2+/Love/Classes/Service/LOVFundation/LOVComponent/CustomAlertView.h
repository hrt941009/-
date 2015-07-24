//
//  CustomAlertView.h
//  CSLCLottery
//
//  Created by 李伟 on 13-4-26.
//  Copyright (c) 2013年 CSLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIAlertView

@property (nonatomic, assign) NSInteger textFieldCount;



- (void)addTextField:(UITextField *)aTextField placeHolder:(NSString *)placeHolder;

@end
