//
//  FollowTagDetailViewController.m
//  Love
//
//  Created by use on 15-4-6.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "FollowTagDetailViewController.h"
#import "ShareProductDetailViewController.h"
#import "ProductDetailViewController.h"

#import "LOVSegmentControl.h"

#import "ShareLabelListModel.h"
#import "FollowTagProductModel.h"
#import "FollowMeModel.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"

@interface FollowTagDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int nextPage;
    CGPoint myContentOffset;
}
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isProduct;

@property (nonatomic, strong) ProductDetailViewController *productDetailVC;//分享详情
@property (nonatomic, strong) ShareProductDetailViewController *shareProductVC;//商品详情
@property (nonatomic, strong) LOVSegmentControl *segmentControl;

@end

@implementation FollowTagDetailViewController
-(instancetype)init{
    self = [super init];
    if (self) {
        nextPage = 1;
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    _productDetailVC = nil;
    _shareProductVC = nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@系列",_tagName];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTagListData:) name:kShareLabelListNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTagListData:) name:kFollowTagProductNotificationName object:nil];
    
    NSArray *titleArray = @[MyLocalizedString(@"分享"), MyLocalizedString(@"商品")];
    _segmentControl = [[LOVSegmentControl alloc] initWithItems:titleArray];
    _segmentControl.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 32.f);
    _segmentControl.backgroundColor = [UIColor whiteColor];
    _segmentControl.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _segmentControl.layer.borderWidth = 0.4;
    [_segmentControl addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentControl];
    
    [self reloadTableView];
}

- (void)reloadTableView{
    CGFloat viewWidth = kScreenWidth;
    CGFloat viewHeight = kScreenHeight - 64.f - 33.f;
    _contentView = [[UIView alloc] initWithFrame: CGRectMake(0, CGRectGetMaxY(_segmentControl.frame), viewWidth, viewHeight)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_contentView addSubview:_tableView];
    [ShareLabelListModel getShareLabelListWithTagId:_tagId page:@"1" pageNumber:@"10"];
    //    [self addHeaderRefresh];
    [self addFooterRefresh];
}

//- (void)addHeaderRefresh{
//    // 添加下拉刷新头部控件
//    __unsafe_unretained typeof(self) mySelf = self;
//    [self.tableView addHeaderWithCallback:^{
//        if ([mySelf.dataArray count] > 0) {
//            [mySelf.dataArray removeAllObjects];
//            [mySelf.tableView reloadData];
//        }
//        [ShareLabelListModel getShareLabelListWithTagId:mySelf.tagId page:@"1" pageNumber:@"10"];
//    }];
//    
//    [self.tableView headerBeginRefreshing];
//}

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
    if (_isProduct) {
        [FollowTagProductModel getFollowTagProductListDataWithTagId:_tagId Page:[NSString stringWithFormat:@"%d",nextPage] Pnum:@"10"];
    }else{
        [ShareLabelListModel getShareLabelListWithTagId:_tagId page:[NSString stringWithFormat:@"%d",nextPage] pageNumber:@"10"];
    }
}

- (void)getTagListData:(NSNotification *)noti{
//    _tableView.contentOffset = myContentOffset;
    [_dataArray addObjectsFromArray:noti.object];
    [self.tableView reloadData];
    
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

- (void)changeAction:(LOVSegmentControl *)sengment{
    NSUInteger idx = sengment.selectedSegmentIndex;
    switch (idx) {
        case 0:
            myContentOffset = CGPointMake(0, 0);
            nextPage = 1;
            _isProduct = NO;
            [_dataArray removeAllObjects];
            [ShareLabelListModel getShareLabelListWithTagId:_tagId page:@"1" pageNumber:@"10"];
//            [self.tableView footerBeginRefreshing];
            break;
            
        case 1:
            myContentOffset = CGPointMake(0, 0);
            nextPage = 1;
            _isProduct = YES;
            [_dataArray removeAllObjects];
            [FollowTagProductModel getFollowTagProductListDataWithTagId:_tagId Page:@"1" Pnum:@"10"];
//            [self.tableView footerBeginRefreshing];
            break;

    }
}

- (void)loadFollowSubViews:(UIView *)view{
    for (id view in [_contentView subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            [(UIView *)view removeFromSuperview];
        }
    }
    
    view.frame = _contentView.bounds;
    [_contentView addSubview:view];
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
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        for (UIView *vi in cell.contentView.subviews) {
            [vi removeFromSuperview];
        }
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 130, 103)];
        imageView.layer.borderColor = [[UIColor colorWithWhite:0 alpha:0.1] CGColor];
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.borderWidth = 1.f;
        imageView.layer.cornerRadius = 6.f;
        [cell.contentView addSubview:imageView];
    
        UIImageView *likeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 10, 10)];
        likeImageView.image = [UIImage imageNamed:@"icon_love"];
        [imageView addSubview:likeImageView];
    
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 30, 15)];
        numLabel.font = [UIFont systemFontOfSize:13.f];
        numLabel.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.6];
        [imageView addSubview:numLabel];
    
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 8, kScreenWidth - 160, 30)];
        nameLabel.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.6];
        nameLabel.font = [UIFont systemFontOfSize:18.f];
        [cell.contentView addSubview:nameLabel];
    
        UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 40, kScreenWidth - 160, 40)];
        introLabel.font = [UIFont systemFontOfSize:13.f];
        introLabel.numberOfLines = 0;
        introLabel.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.4];
//        introLabel.text = @"看了好多东西，觉得隐藏多余的分割线，基本两个各思路，一个是通过代码，一个是代码配合背景图片，第一种比较常见，在网上到处都是，我这也是抄别人的。主要就是说自己定义一个view，弄成透明的，然后盖在TableView的上部和下部，这样就“隐藏”了。";
        [cell.contentView addSubview:introLabel];
        
        UIButton *likeButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 101, 85, 90, 30)];
//        likeButton.backgroundColor = [UIColor lightGrayColor];
        likeButton.layer.masksToBounds = YES;
        likeButton.layer.cornerRadius = 3.f;
        [likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:likeButton];
        
        if (_isProduct) {
            FollowTagProductModel *model = _dataArray[indexPath.row];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbPath] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            numLabel.text = model.loveNumber;
            nameLabel.text = model.productName;
            nameLabel.font = [UIFont systemFontOfSize:16.f];
            introLabel.text = model.intro;
            introLabel.numberOfLines = 2;
            if ([model.isLove isEqual:@"1"]) {
//                likeButton.backgroundColor = [UIColor redColor];
                [likeButton setTitle:@"已喜欢" forState:UIControlStateNormal];
                [likeButton setTitleColor:[UIColor colorWithWhite:0 alpha:0.6] forState:UIControlStateNormal];
                likeButton.layer.borderColor = [[UIColor colorWithWhite:0 alpha:0.6] CGColor];
                likeButton.layer.borderWidth = 0.5f;
                likeButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
                [likeButton setImage:[UIImage imageNamed:@"icon_selectIcon"] forState:UIControlStateNormal];
                likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
            }else{
                [likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
//                likeButton.backgroundColor = [UIColor redColor];
                [likeButton setTitleColor:[UIColor colorRGBWithRed:233 green:60 blue:103 alpha:1] forState:UIControlStateNormal];
                likeButton.layer.borderColor = [[UIColor colorRGBWithRed:233 green:60 blue:103 alpha:1] CGColor];
                likeButton.layer.borderWidth = 0.5f;
                likeButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
                [likeButton setImage:[UIImage imageNamed:@"commission_like"] forState:UIControlStateNormal];
                likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
            }
        }else{
            ShareLabelListModel *model = _dataArray[indexPath.row];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbPath] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            numLabel.text = model.love;
            nameLabel.text = model.share_title;
            introLabel.text = model.share_content;
            
            if ([model.isLove isEqual:@"1"]) {
//                likeButton.backgroundColor = [UIColor redColor];
                [likeButton setTitle:@"已喜欢" forState:UIControlStateNormal];
                [likeButton setTitleColor:[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.6] forState:UIControlStateNormal];
                likeButton.layer.borderColor = [[UIColor colorWithWhite:0 alpha:0.6] CGColor];
                likeButton.layer.borderWidth = 0.5f;
                [likeButton setImage:[UIImage imageNamed:@"icon_selectIcon"] forState:UIControlStateNormal];
                likeButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
                likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
            }else{
                [likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
//                likeButton.backgroundColor = [UIColor redColor];
                [likeButton setTitleColor:[UIColor colorRGBWithRed:233 green:60 blue:103 alpha:1] forState:UIControlStateNormal];
                likeButton.layer.borderColor = [[UIColor colorRGBWithRed:233 green:60 blue:103 alpha:1] CGColor];
                likeButton.layer.borderWidth = 0.5f;
                [likeButton setImage:[UIImage imageNamed:@"commission_like"] forState:UIControlStateNormal];
                likeButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
                likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            cell.textLabel.text = @"还没有数据";
            cell.textLabel.font = [UIFont systemFontOfSize:13.f];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_dataArray count] > 0) {
        return 130;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isProduct) {
        FollowTagProductModel *model = _dataArray[indexPath.row];
        if (_shareProductVC == nil) {
            _shareProductVC = [[ShareProductDetailViewController alloc] init];
            _shareProductVC.productId = model.productId;
            _shareProductVC.productName = model.productName;
            [_shareProductVC reloadTheDataWithShare:NO];
            [self.navigationController pushViewController:_shareProductVC animated:YES];
        }
        NSLog(@"商品%ld",(long)indexPath.row);
    }else{
        ShareLabelListModel *model = _dataArray[indexPath.row];
        
        if (_productDetailVC == nil) {
            _productDetailVC = [[ProductDetailViewController alloc] init];
            _productDetailVC.shareId = model.shareId;
            _productDetailVC.myTitle = model.share_title;
            [self.navigationController pushViewController:_productDetailVC animated:YES];
        }
        NSLog(@"分享%ld",(long)indexPath.row);
    }
}

- (void)likeButtonAction:(UIButton *)sender{
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    if (_isProduct) {
        FollowTagProductModel *model = _dataArray[indexPath.row];
        [FollowMeModel doFollowWithId:model.productId type:1 block:^(int code) {
            if (code == 1) {
                model.isLove = @"1";
            }else{
                model.isLove = @"0";
            }
            [self.tableView reloadData];
        }];
    }else{
        ShareLabelListModel *model = _dataArray[indexPath.row];
        [FollowMeModel doFollowWithId:model.shareId type:8 block:^(int code) {
            if (code == 1) {
                model.isLove = @"1";
            }else{
                model.isLove = @"0";
            }
            [self.tableView reloadData];
        }];

    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView == _tableView) {
//        myContentOffset = _tableView.contentOffset;
//    }
//}

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
