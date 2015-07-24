//
//  ShopHeaderCell.h
//  Love
//
//  Created by lee wei on 14/12/18.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopHeaderCellDelegate <NSObject>

- (void)followButtonAction;
- (void)allProductButtonAction;
- (void)shopNewButtonProduct;
- (void)discountButtonAction;

@end

@interface ShopHeaderCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *funsNumLabel;
@property (nonatomic, strong) IBOutlet UIImageView *levelImageView;
@property (nonatomic, strong) IBOutlet UIButton *followButton;
@property (nonatomic, strong) IBOutlet UIButton *allProductButton, *shopNewButton, *discountButton;
@property (nonatomic, strong) IBOutlet UILabel *allProductNumLabel, *shopNewNumLabel, *discountNumLabel;
@property (nonatomic, strong) IBOutlet UILabel *allProductLabel, *shopNewLabel, *discountLabel;

@property (nonatomic, weak) id<ShopHeaderCellDelegate> delegate;

- (IBAction)followAction:(id)sender;
- (IBAction)allProductAction:(id)sender;
- (IBAction)shopNewProductAction:(id)sender;
- (IBAction)discountAction:(id)sender;

@end
