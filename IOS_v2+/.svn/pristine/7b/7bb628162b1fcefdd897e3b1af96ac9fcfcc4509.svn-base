//
//  NewReciveAdressController.h
//  Love
//
//  Created by use on 14-12-3.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//新建收货地址

#import <UIKit/UIKit.h>

@protocol ReloadDataDelegate <NSObject>

- (void)reloadTableViewData;

@end

@interface NewReciveAdressController : LOVBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *reciveName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *postCode;
- (IBAction)choiceAddress:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *detailAddress;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (nonatomic ,strong) id <ReloadDataDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *line5;

@end
