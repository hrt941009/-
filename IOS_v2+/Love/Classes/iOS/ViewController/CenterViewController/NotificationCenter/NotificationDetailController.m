//
//  NotificationDetailController.m
//  Love
//
//  Created by use on 14-12-5.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "NotificationDetailController.h"
#import "UIImageView+WebCache.h"

@interface NotificationDetailController ()

@end

@implementation NotificationDetailController

- (id)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyLocalizedString(@"消息详情");
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _line.frame = CGRectMake(0, 145, kScreenWidth, 1);
    
    _iconImageView.frame = CGRectMake(kScreenWidth - 114, 15, 104, 116);
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 4.f;
    self.iconImageView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.iconImageView.layer.borderWidth = 1.f;
    
    self.headerImgView.layer.masksToBounds = YES;
    self.headerImgView.layer.cornerRadius = 30.f;
    
    _titleName.frame = CGRectMake(8, 8, kScreenWidth - 125, 44);
    self.titleName.text = self.titleNameStr;
    self.titleName.numberOfLines = 0;
    self.titleName.font = [UIFont systemFontOfSize:15.f];
    
    _introduce.frame = CGRectMake(8, 60, kScreenWidth - 125, 48);
    self.introduce.text = self.introduceStr;
    self.introduce.adjustsFontSizeToFitWidth = YES;
    self.introduce.numberOfLines = 0;
    
    self.createTime.text = self.createTimeStr;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    
    NSString *headerUrl = [self.from objectForKey:@"header"];
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    self.message.text = self.msg;
    
//    NSString *toUserId = [self.to objectForKey:@"user_id"];
    NSString *fromName = [self.from objectForKey:@"name"];
    NSString *toName = [self.to objectForKey:@"name"];
    NSString *userID = [self.to objectForKey:@"user_id"];
    if ([userID length] != 0) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@",fromName];
        self.nameLabel.textColor = [UIColor GoogleRed];
        self.toNameLabel.text = [NSString stringWithFormat:@"%@",toName];
        self.toNameLabel.textColor = [UIColor GoogleRed];
    }else{
        self.nameLabel.text = fromName;
        self.nameLabel.textColor = [UIColor GoogleRed];
        self.replayLabel.hidden = YES;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
