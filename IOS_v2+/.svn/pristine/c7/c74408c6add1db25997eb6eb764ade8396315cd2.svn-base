//
//  PublishMainViewController.h
//  Love
//
//  Created by use on 15-3-30.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@protocol DismissViewControllerDelegate <NSObject>

- (void)dismissTheViewController;

@end

@interface PublishMainViewController : LOVBaseViewController<CLLocationManagerDelegate>

@property (nonatomic, assign) BOOL isShare;

@property (nonatomic, strong) UIImage *choiceImage;

@property (nonatomic, strong) NSString *imgUrl;

@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UIView *centerBgView;
@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@property (weak, nonatomic) IBOutlet UITextView *topTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *locationImageView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UISwitch *topSwitch;
@property (weak, nonatomic) IBOutlet UILabel *productLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UITextField *productTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextField *stockTextField;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

@property (nonatomic, weak) id<DismissViewControllerDelegate>delegate;

@end
