//
//  MyCartFooterView.h
//  Love
//
//  Created by lee wei on 15/1/19.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCartFooterViewDelegate <NSObject>

- (void)deleteProductAction;
- (void)settleUpProductAction;

@end

@interface MyCartFooterView : UIView

@property (nonatomic, strong) UIButton *allSelectButton;
@property (nonatomic, strong) UIButton *delButton;
@property (nonatomic, strong) UIView *buyView;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UIButton *settleUpButton;

@property (nonatomic, weak) id<MyCartFooterViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setDeleteButton;
- (void)setBuyPriceView;

@end
