//
//  AfterSaleViewController.m
//  Love
//
//  Created by use on 14-11-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "AfterSaleViewController.h"
#import "AfterSaleCell.h"
#import "AfterSaleDetailViewController.h"

#import "AllOrderModel.h"
#import "AfterSaleOrderListModel.h"
#import "LOVPageConfig.h"
#import "GlobalConfig.h"

#import "UIScrollView+MJRefresh.h"
#import "UIImageView+WebCache.h"
@interface AfterSaleViewController ()<UITableViewDataSource,UITableViewDelegate,pushDelegate>
{
    int nextPage;
}
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableArray *statusArray;
@property (nonatomic ,strong) UINib *nib;
@end

@implementation AfterSaleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
        nextPage = 1;
    }
    return self;
}

//进入后续页面
- (void)pushComplainPage:(UIButton*)button{
    AfterSaleCell *cell = (AfterSaleCell*)[[button superview] superview];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSInteger row = [indexPath row];
    AfterSaleDetailViewController *afterSaleVC = [[AfterSaleDetailViewController alloc] init];
    AfterSaleOrderListModel *model = (AfterSaleOrderListModel*)_dataArray[row];
    afterSaleVC.orderNumber = model.code;
    afterSaleVC.orderStatus = model.status;
    afterSaleVC.orderMoney = model.price;
    afterSaleVC.title = self.title;
    [self.navigationController pushViewController:afterSaleVC animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(afterSaleDataNotice:)
                                                 name:kAfterSaleOrderListNoticefationName
                                               object:nil];
    
    _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f)];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self addHeader];
    [self addFooter];
    
}

- (void)addHeader{
    // 添加下拉刷新头部控件
    __unsafe_unretained typeof(self) mySelf = self;
    [self.tableView addHeaderWithCallback:^{
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        [AfterSaleOrderListModel getAfterSaleOrderListWithPage:kLovStartPage pageNumber:kLovPageNumber];
    }];
    [self.tableView headerBeginRefreshing];
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf heardingDataAction];
    }];
}

- (void)heardingDataAction{
    
    nextPage = nextPage + 1;
    
    [AfterSaleOrderListModel getAfterSaleOrderListWithPage:[NSString stringWithFormat:@"%d",nextPage] pageNumber:kLovPageNumber];
    
}

- (void)afterSaleDataNotice:(NSNotification*)noti{
    [_dataArray addObjectsFromArray:noti.object];
    [self.tableView reloadData];
    
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
    
}


#pragma mark -- dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_dataArray count] > 0) {
        return [_dataArray count];
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIdentifier = @"kAfterSaleCellIdentifier";
    static NSString *noDataCellIdentifier = @"noDataCellIdentifier";
    
    if ([_dataArray count] > 0) {
        if (!_nib) {
            _nib = [UINib nibWithNibName:@"AfterSaleCell" bundle:nil];
            [tableView registerNib:_nib forCellReuseIdentifier:kCellIdentifier];
        }
        AfterSaleCell *cell = (AfterSaleCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        
        cell.delegate = self;
        AfterSaleOrderListModel *model = (AfterSaleOrderListModel*)_dataArray[indexPath.row];
        
        cell.orderNumber.text = model.code;
        cell.introduce.text = model.product_name;
        if ([model.status isEqual:@"1"]) {
            cell.status.text = MyLocalizedString(@"待发货");
        }
        if ([model.status isEqual:@"2"]) {
            cell.status.text = MyLocalizedString(@"已发货");
        }
        if ([model.status isEqual:@"3"]) {
            cell.status.text = MyLocalizedString(@"已收货");
        }
        //    cell.status.text = model.status;
        cell.money.text = [NSString stringWithFormat:@"￥%@",model.price];
        cell.dateTime.text = model.create_time;
        NSString *imgUrl = model.product_thumb;
        [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        //    cell.status.text = _statusArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:noDataCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:noDataCellIdentifier];
        }
        cell.detailTextLabel.text = MyLocalizedString(@"还没有商品");
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}

#pragma mark -- delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 131.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAfterSaleOrderListNoticefationName object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
