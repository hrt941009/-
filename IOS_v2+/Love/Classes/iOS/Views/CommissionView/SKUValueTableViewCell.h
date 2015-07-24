//
//  SKUValueTableViewCell.h
//  Love
//
//  Created by lee wei on 14/11/12.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SKUValueCellDelegate <NSObject>

- (void)skuValueButton:(UIButton *)button;

@end

@interface SKUValueTableViewCell : UITableViewCell
{
    CGFloat tempWidth;
}

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *valueArray;

@property (nonatomic, weak) id<SKUValueCellDelegate> delegate;

@end
