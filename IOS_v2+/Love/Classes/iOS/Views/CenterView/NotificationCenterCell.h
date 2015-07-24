//
//  NotificationCenterCell.h
//  Love
//
//  Created by use on 14-11-25.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCenterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UILabel *dataTime;

@end
