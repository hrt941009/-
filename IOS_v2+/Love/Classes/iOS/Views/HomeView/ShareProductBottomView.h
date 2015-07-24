//
//  ShareProductBottomView.h
//  Love
//
//  Created by use on 15-3-21.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareProductBottomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *addCart;
@property (weak, nonatomic) IBOutlet UIButton *buyNow;

@end
