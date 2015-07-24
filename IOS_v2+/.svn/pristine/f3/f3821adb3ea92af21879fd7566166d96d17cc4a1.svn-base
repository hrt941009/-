//
//  ShareProductTableViewCell.h
//  Love
//
//  Created by use on 15-3-18.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol addCartActionDelegate <NSObject>

- (void)shareProductAddCartButton:(UIButton *)bnt;

@end


@interface ShareProductTableViewCell : UITableViewCell

@property (nonatomic, strong) id<addCartActionDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *tagName;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *addCartButton;
- (IBAction)addCartAction:(id)sender;

@end
