//
//  FollowSubjectTableViewCell.h
//  Love
//
//  Created by lee wei on 14-9-22.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowViewDelegate.h"

@interface FollowSubjectTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView *subjectIconView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UITextView  *descTextView;
@property (nonatomic, strong) IBOutlet UIButton *cancelFollowButton;

@property (nonatomic, strong) IBOutlet UIButton *likeButton, *commentButton;

@property (nonatomic, weak) id<FollowViewDelegate> delegate;

- (IBAction)cancelFollowAction:(id)sender;

@end
