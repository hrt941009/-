//
//  NotificationDetailController.h
//  Love
//
//  Created by use on 14-12-5.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//
//消息详情

#import <UIKit/UIKit.h>

@interface NotificationDetailController : LOVBaseViewController

@property (nonatomic ,strong) NSString *titleNameStr;
@property (nonatomic ,strong) NSString *introduceStr;
@property (nonatomic ,strong) NSString *createTimeStr;
@property (nonatomic ,strong) NSString *imageUrl;
@property (nonatomic ,strong) NSDictionary *from;
@property (nonatomic ,strong) NSDictionary *to;
@property (nonatomic ,strong) NSString *msg;



@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *introduce;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UILabel *toNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *replayLabel;
@property (weak, nonatomic) IBOutlet UIView *line;


@end
