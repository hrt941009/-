//
//  MyLikeCell.h
//  Love
//
//  Created by lee wei on 14-10-6.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyLikeCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *previewImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel, *descLabel;
@property (nonatomic, strong) IBOutlet UILabel *stateLabel;


@end
