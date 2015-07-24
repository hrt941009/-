//
//  BrandViewController.m
//  Love
//
//  Created by 李伟 on 14/11/10.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "BrandViewController.h"
#import "BrandHeaderView.h"
#import "BrandProductTableViewCell.h"

#import "BrandModel.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

#import "LOVCircle.h"
#import "LOVPageConfig.h"

static CGFloat const kImageOriginHight = 180.f;


@interface BrandViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CGRect headerRect;
    CGRect tableViewRect;
    int nextPage;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BrandHeaderView *headerView;

@property (nonatomic, strong) UINib *nib;

@property (nonatomic, strong) UIImageView *zoomImageView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *tempDataArray;


@end

@implementation BrandViewController

#pragma mark - 刷新
- (void)addMySubjectDataFooter
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf moreMySubjectDataAciton];
        
    }];
}

- (void)moreMySubjectDataAciton
{
    nextPage = nextPage + 1;

    [BrandModel getBrandProductListWithID:_brandId page:[NSString stringWithFormat:@"%d", nextPage] pageNumber:kLovPageNumber];
    [_tableView reloadData];
}

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
        nextPage = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = _brandName;
    
    [BrandModel getBrandProductListWithID:_brandId page:kLovStartPage pageNumber:kLovPageNumber];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(brandProductDataNotice:)
                                                 name:kBrandProductListNoticefationName
                                               object:nil];
//
    //---
    self.view.backgroundColor = [UIColor whiteColor];
    
    //--
    self.title = @"";
    
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    //------- 顶部个人信息背景效果
    _zoomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper6.jpg"]];
    _zoomImageView.frame = CGRectMake(0, -kImageOriginHight, self.tableView.frame.size.width, kImageOriginHight);
    _zoomImageView.userInteractionEnabled = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(kImageOriginHight, 0, 0, 0);
    [self.tableView addSubview:_zoomImageView];
    
    _headerView = [[BrandHeaderView alloc] initWithFrame:CGRectMake(0, 0, _zoomImageView.frame.size.width, kImageOriginHight)];
    [_zoomImageView addSubview:_headerView];
    
    LOVCircle *iconView = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, 75.f, 75.f)
                                             imageWithPath:_brandHeader
                                          placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    [_headerView.iconView addSubview:iconView];
    _headerView.nameLabel.text = _brandName;
    _headerView.introLabel.text = _introString;
    _headerView.followNumLabel.text = _followNum;
    _headerView.pushNumLabel.text = _pushNum;
    
    //-------
    [self addMySubjectDataFooter];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMySubjectNotificationName object:nil];
}

#pragma mark -
#pragma mark -  scrollViewDidScroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -kImageOriginHight) {
        CGRect f = _zoomImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        _zoomImageView.frame = f;
    }
}

#pragma mark - notice
- (void)brandProductDataNotice:(NSNotification *)notice
{
    [_dataArray addObjectsFromArray:[notice object]];
    NSLog(@"brandProductDataNotice data array = %@", _dataArray);
    
    [_tableView reloadData];
    
    [self.tableView footerEndRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_dataArray count] > 0)
    {
        return [_dataArray count];
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"kBrandProductCell";
    static NSString *CellIdentifier2 = @"Cell2";
    
    if ([_dataArray count] > 0) {
        
        if (!_nib) {
            _nib = [UINib nibWithNibName:@"BrandProductTableViewCell" bundle:nil];
            [tableView registerNib:_nib forCellReuseIdentifier:CellIdentifier1];
        }
        BrandProductTableViewCell *cell = (BrandProductTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        BrandModel *bmodel = _dataArray[indexPath.row];
        
        [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:bmodel.thumbPath]
                                 placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        
        cell.nameLabel.text = bmodel.productName;
        cell.introTextView.text = bmodel.introString;
        [cell.commentButton setTitle:bmodel.commentNum forState:UIControlStateNormal];
        [cell.favButton setTitle:bmodel.saveNum forState:UIControlStateNormal];
        [cell.likeButton setTitle:bmodel.loveNum forState:UIControlStateNormal];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier2];
        }
        cell.detailTextLabel.text = MyLocalizedString(@"数据为空");
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray count] > 0) {
        return 124.f;
    }else{
        return 40.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


@end
