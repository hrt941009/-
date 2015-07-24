//
//  SKUValueCell.h
//  Love
//
//  Created by lee wei on 15/1/1.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SKUValueCell;
@protocol SKUCollectionCellDelegate <NSObject>

- (void)choiceColorOrSize:(NSString *)colorOrSize andCell:(SKUValueCell *)cell;

@end


@interface SKUCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@interface SKUValueCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) id<SKUCollectionCellDelegate>delegate;

- (CGFloat)cellHeight;

@end
