
//
//  NotificationCenterViewController.m
//  Love
//
//  Created by use on 14-11-25.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "NotificationCenterViewController.h"
#import "NotificationCenterCell.h"
#import "NotificationDetailController.h"
#import "NotificationCenterModel.h"
#import "UIScrollView+MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface NotificationCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int nextPage;
}
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) UINib *nib;
@end

@implementation NotificationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getNotiCenterData:)
                                                 name:kNotificationCenterNotificationName
                                               object:nil];
    
    
    self.title = MyLocalizedString(@"消息中心");
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
    
}
- (void)addHeaderRefresh{
    nextPage = 1;
    // 添加下拉刷新头部控件
    __unsafe_unretained typeof(self) mySelf = self;
    [self.tableView addHeaderWithCallback:^{
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        [NotificationCenterModel getNotificationCenterDataPage:@"1" andPageNum:@"10"];
    }];
    [self.tableView headerBeginRefreshing];
}

- (void)addFooterRefresh{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf loadingDataAction];
    }];
}

- (void)loadingDataAction{
    nextPage = nextPage + 1;
    [NotificationCenterModel getNotificationCenterDataPage:[NSString stringWithFormat:@"%d",nextPage] andPageNum:@"10"];
}

- (void)getNotiCenterData:(NSNotification*)noti{
    
    [_dataArray addObjectsFromArray:noti.object];
    
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

#pragma mark -- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_dataArray count] > 0) {
        return [_dataArray count];
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIdentifier = @"kNotificationCenterCellIdentifier";
    static NSString *noDataCellIdentifier = @"noDataCellIdentifier";
    if ([_dataArray count] > 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        }
        
        for (UIView *vi in cell.contentView.subviews) {
            [vi removeFromSuperview];
        }
        
        NotificationCenterModel *model = (NotificationCenterModel*)_dataArray[indexPath.row];
            
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 68, 60)];
        imageView.layer.borderWidth = 1.f;
        imageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [cell.contentView addSubview:imageView];
            
        UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 12, 22, 15)];
        statusLabel.backgroundColor = [UIColor colorRGBWithRed:230 green:65 blue:100 alpha:1];
        statusLabel.textColor = [UIColor whiteColor];
        statusLabel.text = model.msg_type;
        statusLabel.layer.masksToBounds = YES;
        statusLabel.layer.cornerRadius = 3.f;
        statusLabel.font = [UIFont systemFontOfSize:11.f];
        [cell.contentView addSubview:statusLabel];
            
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(118, 5, kScreenWidth - 128, 30)];
        nameLabel.font = [UIFont systemFontOfSize:13.f];
        nameLabel.adjustsFontSizeToFitWidth = YES;
        nameLabel.numberOfLines = 2;
        [cell.contentView addSubview:nameLabel];
            
        UILabel *inroLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 35, kScreenWidth - 98, 38)];
        inroLabel.font = [UIFont systemFontOfSize:14.f];
        inroLabel.adjustsFontSizeToFitWidth = YES;
        inroLabel.numberOfLines = 0;
        [cell.contentView addSubview:inroLabel];
            
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(169, 73, kScreenWidth - 179, 18)];
        timeLabel.font = [UIFont systemFontOfSize:12.f];
        timeLabel.textColor = [UIColor lightGrayColor];
        timeLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:timeLabel];
            
        if ([model.msg_type isEqual:@"0"]) {
                
            [imageView removeFromSuperview];
                
            CGRect statusRect = statusLabel.frame;
            statusRect.origin.x = statusRect.origin.x - 80;
            statusLabel.frame = statusRect;
            statusLabel.text = MyLocalizedString(@"系统");
                
                
            CGRect titleRect = nameLabel.frame;
            titleRect.origin.x = titleRect.origin.x - 80;
            nameLabel.frame = titleRect;
            nameLabel.text = model.content;
        }
        if ([model.msg_type isEqual:@"1"]) {
            statusLabel.text = MyLocalizedString(@"商品");
            nameLabel.text = model.product_name;
            inroLabel.text = model.msg;
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.product_thumb] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            timeLabel.text = model.create_time;
        }
        if ([model.msg_type isEqual:@"2"]) {
            statusLabel.text = MyLocalizedString(@"专辑");
            nameLabel.text = model.album_name;
            inroLabel.text = model.msg;
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.album_thum] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            timeLabel.text = model.create_time;
        }
        if ([model.msg_type isEqual:@"3"]) {
            statusLabel.text = MyLocalizedString(@"直播");
            nameLabel.text = model.live_name;
            inroLabel.text = model.msg;
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.live_thumb] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            timeLabel.text = model.create_time;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:noDataCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:noDataCellIdentifier];
        }
        cell.detailTextLabel.text = MyLocalizedString(@"还没有内容");
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}

#pragma mark -- tableViewDelegate
//删除消息
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationCenterModel *model = (NotificationCenterModel*)_dataArray[indexPath.row];
    NSString *notiId = model.comment_id;
    NSString *type = model.msg_type;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [NotificationCenterModel deleteNotificationNotiId:notiId type:type block:^(int code, NSString *msg) {
            if (code == 1) {
                [_dataArray removeObjectAtIndex:indexPath.row];
                [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
        
    }else{
        editingStyle = UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationDetailController *detailVC = [[NotificationDetailController alloc] init];
    NotificationCenterModel *model = (NotificationCenterModel*)_dataArray[indexPath.row];
    detailVC.msg = model.msg;
    detailVC.from = model.from;
    detailVC.to = model.to;
    if ([model.msg_type isEqual:@"1"]) {
        detailVC.titleNameStr = model.product_name;
        detailVC.introduceStr = model.productDescription;
        detailVC.createTimeStr = model.create_time;
        detailVC.imageUrl = model.product_thumb;
    }
    if ([model.msg_type isEqual:@"2"]) {
        detailVC.titleNameStr = model.album_name;
        detailVC.introduceStr = model.albumDescription;
        detailVC.createTimeStr = model.create_time;
        detailVC.imageUrl = model.album_thum;
    }
    if ([model.msg_type isEqual:@"3"]) {
        detailVC.titleNameStr = model.live_name;
        detailVC.introduceStr = model.liveDescription;
        detailVC.createTimeStr = model.create_time;
        detailVC.imageUrl = model.live_thumb;
    }
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationCenterNotificationName object:nil];
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
