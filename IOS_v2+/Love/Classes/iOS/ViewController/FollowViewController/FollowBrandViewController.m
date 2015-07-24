//
//  FollowBrandViewController.m
//  Love
//
//  Created by lee wei on 14-9-22.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "FollowBrandViewController.h"
#import "BrandTableViewCell.h"

#import "FollowModel.h"
#import "FollowMeModel.h"

#import "LOVPageConfig.h"
#import "LOVCircle.h"

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface FollowBrandViewController ()<UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    int nextPage;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *tempDataArray;

@end

@implementation FollowBrandViewController

- (void)setFollowView
{
    for (id view in [self.view subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    //--正在直播
    CGRect tvRect = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}


#pragma mark -
#pragma mark - 刷新
- (void)addFollowBrandDataHeader
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加下拉刷新头部控件
    [self.tableView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        //----- get data
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        
        // 增加数据
        [FollowShopModel getFollowShopWithPage:kLovStartPage pnum:kLovPageNumber];
        
    }];
    
    //自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
}

- (void)addFollowBrandDataFooter
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf moreBrandDataAciton];
        
    }];
}

- (void)moreBrandDataAciton
{
    nextPage = nextPage + 1;
    [FollowShopModel getFollowShopWithPage:[NSString stringWithFormat:@"%d", nextPage] pnum:kLovPageNumber];
    [_tableView reloadData];
}

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        
        nextPage = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getBrandDataNotice:)
                                                 name:kFollowShopNotificationName
                                               object:nil];
    
    self.view.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - connect
- (void)isConnect:(BOOL)connect
{
    if (connect) {
        [self setFollowView];
//        if ([_dataArray count] == 0) {
//            
//            
//        }else{
//            [_tableView reloadData];
//        }
        [self addFollowBrandDataHeader];
        [self addFollowBrandDataFooter];
    }
}


#pragma mark - notice
- (void)getBrandDataNotice:(NSNotification *)notice
{
    _tempDataArray = [notice object];
    [_dataArray addObjectsFromArray:_tempDataArray];
    [_tableView reloadData];
    
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    BrandTableViewCell *cell = (BrandTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BrandTableViewCell" owner:self options:nil];
        for (id object in  nib) {
            if ([object isKindOfClass:[BrandTableViewCell class]]) {
                cell = (BrandTableViewCell *)object;
            }
        }
    }
    
//    cell.delegate = self;
    
    FollowShopModel *model = (FollowShopModel *)_dataArray[(NSUInteger)indexPath.row];
    cell.titleLabel.text = model.shopName;
    cell.descTextView.text = model.shopIntro;
  
    LOVCircle *iconView = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, cell.brandIconView.frame.size.width, cell.brandIconView.frame.size.height) imageWithPath:model.shopLogo placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    [cell.brandIconView addSubview:iconView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115.f;
}

/**
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 32.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *moreDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreDataButton.backgroundColor = [UIColor clearColor];
    if ([_tempDataArray count] > 0) {
        [moreDataButton setTitle:MyLocalizedString(@"查看更多") forState:UIControlStateNormal];
    }else{
        [moreDataButton setTitle:MyLocalizedString(@"已是最后一条") forState:UIControlStateNormal];
    }
    
    [moreDataButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    moreDataButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    moreDataButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [moreDataButton addTarget:self action:@selector(moreBrandDataAciton) forControlEvents:UIControlEventTouchUpInside];
    if ([_dataArray count] > 0) {
        return moreDataButton;
    }
    return nil;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowShopModel *model = (FollowShopModel *)_dataArray[(NSUInteger)indexPath.row];
    [_delegate pushBrandViewControllerWithBrandID:model.shopId];
}

#pragma mark - 取消关注delegate
//- (void)cancelFollowBrandButton:(UIButton *)button
//{
//    NSIndexPath *indexPath = nil;
//    if (VersionNumber_iOS_8) {
//        indexPath = [_tableView indexPathForCell:(BrandTableViewCell *)[[button superview] superview]];
//    }else{
//        indexPath = [_tableView indexPathForCell:(BrandTableViewCell *)[[[button superview] superview] superview]];
//    }
//    NSInteger row = [indexPath  row];
//
//    FollowShopModel *model = (FollowShopModel *)_dataArray[(NSUInteger)row];
//    [FollowMeModel doFollowWithId:model.shopId type:FollowModelTypeWithBrand block:^(int code) {
//        if (code == 0) {
//            [self addFollowBrandDataHeader];
//        }
//    }];
//}




@end
