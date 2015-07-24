//
//  LikeShareViewController.m
//  Love
//
//  Created by use on 15-4-3.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "LikeShareViewController.h"

#import "MyLikeModel.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface LikeShareViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int nextPage;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LikeShareViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        nextPage = 1;
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        MyLikeModel *model = _dataArray[indexPath.row];
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 103, 82)];
        iconImageView.backgroundColor = [UIColor lightGrayColor];
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.cornerRadius = 3.f;
        NSString *urlString = model.header;
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        [cell.contentView addSubview:iconImageView];
        
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 10, kScreenWidth - 135, 25)];
        tagLabel.text = [NSString stringWithFormat:@"# %@",model.tagName];
        [cell.contentView addSubview:tagLabel];
        
        UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 30, kScreenWidth - 135, 50)];
        introLabel.text = [NSString stringWithFormat:@"%@",model.shareContent];
        introLabel.font = [UIFont systemFontOfSize:15.f];
        introLabel.numberOfLines = 0;
        introLabel.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.6];
        [cell.contentView addSubview:introLabel];
        }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyLikeModel *model = _dataArray[indexPath.row];
    if ([_delegate respondsToSelector:@selector(cellSelectedActionWithShareId:)]) {
        [_delegate cellSelectedActionWithShareId:model.shareId];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getShareListData:) name:kShareLikeNotificationName
                                               object:nil];
    
}

- (void)reloadShareListData{
    for (id view in [self.view subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
}

- (void)addHeaderRefresh{
    // 添加下拉刷新头部控件
    __unsafe_unretained typeof(self) mySelf = self;
    [self.tableView addHeaderWithCallback:^{
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        [MyLikeModel getShareLikeDataPage:@"1" andPageNum:@"10"];
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
    [MyLikeModel getShareLikeDataPage:[NSString stringWithFormat:@"%d",nextPage] andPageNum:@"10"];
}

- (void)getShareListData:(NSNotification *)noti{
    [_dataArray addObjectsFromArray:noti.object];
    [self.tableView reloadData];
    
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
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
