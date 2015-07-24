//
//  SKUImageViewTableViewCell.h
//  Love
//
//  Created by lee wei on 14/11/12.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKUImageViewTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *photoView;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel, *stockLabel;

- (void)getStockLabelTextWithNumbers:(NSString *)numbers;

@end
