//
//  FollowTableViewCell.h
//  Love
//
//  Created by lee wei on 14-7-15.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowViewDelegate.h"

@class MyFollowModel;
@interface FollowTableViewCell : UITableViewCell

@property (nonatomic, strong) MyFollowModel *myFollow;
@property (nonatomic, strong) IBOutlet UIView *iconView;
@property (nonatomic, strong) IBOutlet UIImageView *flagImageView;
@property (nonatomic, strong) IBOutlet UIButton *cancelFollowButton;
@property (nonatomic, strong) IBOutlet UILabel *sellerNameLabel, *infoLabel, *liveTimeLabel, *likeLabel, *liveLabel, *photoLabel, *statusLabel;

@property (nonatomic, weak) id<FollowViewDelegate> delegate;

- (IBAction)cancelFollowSellerAction:(id)sender;


@end
