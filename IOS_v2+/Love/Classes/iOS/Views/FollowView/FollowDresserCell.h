//
//  FollowDresserCell.h
//  Love
//
//  Created by 李伟 on 14-10-16.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowViewDelegate.h"


@interface FollowDresserCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *photoView;
@property (nonatomic, strong) IBOutlet UILabel *dresserNameLabel;
@property (nonatomic, strong) IBOutlet UIImageView *levelImageView;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel *descLabel;
@property (nonatomic, strong) IBOutlet UIButton *cancelFollowButton;

@property (nonatomic, weak) id<FollowViewDelegate> delegate;

- (IBAction)cancelFollowAction:(id)sender;

@end
