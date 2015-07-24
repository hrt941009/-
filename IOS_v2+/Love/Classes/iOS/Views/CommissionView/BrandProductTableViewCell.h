//
//  BrandTableViewCell.h
//  Love
//
//  Created by 李伟 on 14/11/10.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BrandProductTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *productImageView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UITextView *introTextView;
@property (nonatomic, strong) IBOutlet UIButton *commentButton, *likeButton, *favButton;

@end
