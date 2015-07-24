//
//  ChangeAddressController.h
//  Love
//
//  Created by use on 14-12-5.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

//编辑修改收货地址


#import <UIKit/UIKit.h>

@protocol ReloadChangeAddressDataDelegate <NSObject>

- (void)reloadChangeAddressData;

@end

@interface ChangeAddressController : LOVBaseViewController

@property (nonatomic ,strong) NSString *addressId;
@property (nonatomic ,strong) NSString *provinceId;
@property (nonatomic ,strong) NSString *cityId;
@property (nonatomic ,strong) NSString *districtId;
@property (nonatomic ,strong) NSString *addressStr;
@property (nonatomic ,strong) NSString *addrStr;
@property (nonatomic ,strong) NSString *getNameStr;
@property (nonatomic ,strong) NSString *phoneNumStr;
@property (nonatomic ,strong) NSString *zipcodeStr;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
- (IBAction)choiceAddress:(id)sender;

@property (nonatomic ,strong) id <ReloadChangeAddressDataDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *detailAddress;
@property (weak, nonatomic) IBOutlet UITextField *getName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *zipcode;

@end
