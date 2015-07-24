//
//  MyCartTableViewForHeaderView.h
//  Love
//
//  Created by lee wei on 15/1/11.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCartTableViewForHeaderViewDelegate <NSObject>

- (void)selectSectionHeader:(BOOL)select inSection:(NSInteger)section;

@end

@interface MyCartTableViewForHeaderView : UIView

@property (nonatomic, strong) UIButton *allSectionSelectButton;
@property (nonatomic, strong) UILabel  *shopNameLabel;
@property (nonatomic, weak) id<MyCartTableViewForHeaderViewDelegate> delegate;

- (void)commitInitInSection:(NSInteger)section;
- (void)headerViewButtonSelected:(BOOL)select;

@end
