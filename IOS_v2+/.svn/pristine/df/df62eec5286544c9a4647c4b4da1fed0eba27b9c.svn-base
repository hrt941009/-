//
//  MeView.h
//  Love
//
//  Created by lee wei on 14-10-1.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeViewDelegate <NSObject>

- (void)tapHeaderView;
- (void)meViewButtonActionWithTag:(NSInteger)tag;

@end

typedef NS_ENUM(NSInteger, MyViewButtonTag)
{
    MyViewButtonTagWithOrder = 1,
    MyViewButtonTagWithSubject,
    MyViewButtonTagWithLike,
    MyViewButtonTagWithRebateAndCoin,
    MyViewButtonTagWithNotifacitionCenter,
    MyViewButtonTagWithSetting,
    MyViewButtonTagWithFriend,
    MyViewButtonTagWithCart,
    MyViewButtonTagWithSellerCenter,
    MyViewButtonTagWithCoupon
};

@interface MeView : UIView

@property (nonatomic, strong) IBOutlet UIView  *headerView;
@property (nonatomic, strong) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) IBOutlet UILabel *userNameLabel, *accountLabel;
@property (nonatomic, strong) IBOutlet UILabel *couponLabel, *baaiCoinLabel, *discountLabel;
@property (nonatomic, strong) IBOutlet UIButton *orderButton, *subjectButton, *likeButton, *discountAndCoinButton, *couponButton, *settingButton, *friendButton, *cartButton, *sellerCenterButton;

@property (nonatomic, weak) id<MeViewDelegate> delegate;

- (IBAction)meButtonAction:(id)sender;

@end
