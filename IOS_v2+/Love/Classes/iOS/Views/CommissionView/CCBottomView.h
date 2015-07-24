//
//  CCBottomView.h
//  Love
//
//  Created by lee wei on 14-9-27.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCBottomViewDelegate <NSObject>

- (void)writeMyComment;
- (void)putCart;
- (void)buyNow;

@end

@interface CCBottomView : UIView

@property (nonatomic, weak)   id<CCBottomViewDelegate,UITextFieldDelegate> delgate;

//
@property (nonatomic, strong) UILabel *priceLabel;//优惠价
@property (nonatomic, strong) UILabel *originalPriceLabel;//原价
@property (nonatomic, strong) UILabel *discountLabel; //折扣值
@property (nonatomic, strong) UIButton *putCartButton;
@property (nonatomic, strong) UIButton *buyButton;
@property (nonatomic, strong) UIImageView *imageView;

//--
@property (nonatomic, strong) UIButton *wirteButton;

@property (nonatomic, strong) NSString *bottomPriceStr;
@property (nonatomic, strong) NSString *bottomOriginalPriceStr;
@property (nonatomic, strong) NSString *bottomDiscount;

- (void)setBottomViewForWirte:(BOOL)isWirte;

@end
