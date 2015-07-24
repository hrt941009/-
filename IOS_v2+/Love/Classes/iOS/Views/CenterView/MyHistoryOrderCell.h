//
//  MyHistoryOrderCell.h
//  Love
//
//  Created by lee wei on 14-10-5.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHistoryOrderCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *previewImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel, *descLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UILabel *stateLabel;


@end
