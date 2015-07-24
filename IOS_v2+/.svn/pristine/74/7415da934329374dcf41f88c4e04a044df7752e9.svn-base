//
//  BrandTableViewCell.h
//  Love
//
//  Created by lee wei on 14-9-22.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowViewDelegate.h"

@interface BrandTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView *brandIconView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UITextView  *descTextView;
@property (nonatomic, strong) IBOutlet UIButton *cancelFollowButton;
@property (nonatomic, strong) IBOutlet UIImageView *levelImageView;
@property (nonatomic, strong) IBOutlet UIButton *likeButton, *publishButton;// 关注数量button， 产品数量button
@property (weak, nonatomic) IBOutlet UIImageView *locationImage;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic, weak) id<FollowViewDelegate> delegate;

- (IBAction)cancelFollowBrandAction:(id)sender;

@end
