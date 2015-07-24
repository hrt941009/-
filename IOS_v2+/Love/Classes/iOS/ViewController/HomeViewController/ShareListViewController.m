//
//  ShareListViewController.m
//  Love
//
//  Created by use on 15-3-26.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ShareListViewController.h"
#import "ShareProductDetailViewController.h"

#import "ShareTagProductModel.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface ShareListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int nextPage;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ShareListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@系列",_tagName];
    _dataArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getTagShareData:)
                                                 name:kShareTagProductDataListNotificationName object:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
}

- (void)addHeaderRefresh{
    // 添加下拉刷新头部控件
    __unsafe_unretained typeof(self) mySelf = self;
    [self.tableView addHeaderWithCallback:^{
        nextPage = 1;
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        [ShareTagProductModel getShareTagProductDataListWithPage:@"1" pageNum:@"10" tagId:mySelf.tagId];
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
    [ShareTagProductModel getShareTagProductDataListWithPage:[NSString stringWithFormat:@"%d",nextPage] pageNum:@"10" tagId:_tagId];
}

- (void)getTagShareData:(NSNotification*)noti{
    [_dataArray addObjectsFromArray:noti.object];
    [self.tableView reloadData];
    
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_dataArray count] > 0) {
        return [_dataArray count];
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    static NSString *cellID1 = @"cellID1";
    if ([_dataArray count] > 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        for (UIView *theView in [cell.contentView subviews]) {
            [theView removeFromSuperview];
        }
        ShareTagProductModel *model = _dataArray[indexPath.row];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 100, 100)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        imageView.layer.borderWidth = 1.f;
        imageView.layer.cornerRadius = 6.f;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        [cell.contentView addSubview:imageView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(130, 15, kScreenWidth - 140, 20)];
        title.text = model.productName;
        [cell.contentView addSubview:title];
        
        UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 35, kScreenWidth - 140, 40)];
        introLabel.text = model.intro;
        introLabel.font = [UIFont systemFontOfSize:12.f];
        introLabel.numberOfLines = 0;
        [cell.contentView addSubview:introLabel];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 75, kScreenWidth - 140, 20)];
        NSString *str = [model.createTime substringToIndex:10];
        timeLabel.text = str;
        timeLabel.font = [UIFont systemFontOfSize:12.f];
        [cell.contentView addSubview:timeLabel];
        
        UIImageView *locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(130, 98, 12, 15)];
        locationIcon.backgroundColor = [UIColor clearColor];
        locationIcon.image = [UIImage imageNamed:@"icon_location"];
        [cell.contentView addSubview:locationIcon];
        
        UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 95, kScreenWidth - 155, 20)];
        locationLabel.text = model.location;
        locationLabel.font = [UIFont systemFontOfSize:13.f];
        [cell.contentView addSubview:locationLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(130, 114, kScreenWidth - 130, 1)];
        lineView.backgroundColor = [UIColor colorRGBWithRed:1 green:1 blue:1 alpha:0.3];
        [cell.contentView addSubview:lineView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.textLabel.text = @"还没有数据";
        cell.textLabel.font = [UIFont systemFontOfSize:12.f];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_dataArray count] > 0) {
        return 115;
    }else{
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShareTagProductModel *model = _dataArray[indexPath.row];
    ShareProductDetailViewController *shareProductVC = [[ShareProductDetailViewController alloc] init];
    shareProductVC.productId = model.productId;
    shareProductVC.productName = model.productName;
    [shareProductVC reloadTheDataWithShare:YES];
    [self.navigationController pushViewController:shareProductVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
