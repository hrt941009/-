//
//  DresserViewController.m
//  Love
//
//  Created by lee wei on 14-10-6.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "DresserViewController.h"
#import "DresserMainViewController.h"
#import "DresserQuiltViewCell.h"
#import "LOVCircle.h"
#import "DresserDetailViewController.h"
#import "DresserHomePageModel.h"
#import "DresserDetailModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Additions.h"
#import "MJRefresh.h"
#import "UIFont+boldFontOtherFont.h"

#import "LOVPageConfig.h"


static CGFloat const photoViewWidth = 150.f;

static NSString * const kCellReuseIdentifier = @"kDresserCollectionViewCell";

@interface DresserViewController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>
{
    int nextPage;
    UIImage *setImage;
    int i;
}


@property (nonatomic, strong) DresserHomePageModel *dresserModel;
@property (nonatomic, strong) UIButton *loadingButton;
@property (nonatomic, strong) DresserDetailViewController *detailViewController;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) DresserMainViewController *dressserMainVC;

@end

@implementation DresserViewController

#pragma mark - 
#pragma mark - 刷新
- (void)addDresserDataHeader
{
    
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加下拉刷新头部控件
    [self.collectionView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        //----- get data
        nextPage = 1;
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.collectionView reloadData];
        }
        
        // 增加数据
        [DresserHomePageModel getDresserListPage:kLovStartPage
                                         pageNum:kLovPageNumber];
    }];
    
    //自动刷新(一进入程序就下拉刷新)
    [self.collectionView headerBeginRefreshing];
    [self.collectionView reloadData];
}

- (void)addDresserDataFooter
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf loadingDresserData];
    }];
}

- (void)loadingDresserData
{
    nextPage = nextPage + 1;
    //int num = [pageNumber intValue];
    [DresserHomePageModel getDresserListPage:[NSString stringWithFormat:@"%d", nextPage]
                                     pageNum:kLovPageNumber];
    [self.collectionView reloadData];
}

#pragma mark - init
- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithCollectionViewLayout:layout];
    if (self)
    {
        self.collectionView.backgroundColor = [UIColor clearColor];
        
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        nextPage = 1;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        [self.collectionView registerClass:[DresserQuiltViewCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    i = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    if (VersionNumber_iOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;//view在导航栏下方
    }
    //----- get data
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dresserListNotice:)
                                                 name:kDresserHomePageNotificationName
                                               object:nil];

    [_dataArray addObjectsFromArray:_firstData];
    
    //----
    [self addDresserDataHeader];
    [self addDresserDataFooter];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    _detailViewController = nil;
    _dressserMainVC = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - reload view
#pragma mark - notice
- (void)dresserListNotice:(NSNotification *)notice;
{
    NSArray *array = [notice object];
    
    if ([array count] == 0) {
        [self.collectionView setFooterRefreshingText:@"没数据了"];
        [self.collectionView footerEndRefreshing];
    }else{
        [_dataArray addObjectsFromArray:array];
        [self.collectionView reloadData];
        
        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
    }
    
    
    
}

#pragma mark - images
//
- (UIImage *)imageAtIndexPath:(NSIndexPath *)indexPath {

    _dresserModel = (DresserHomePageModel *)_dataArray[indexPath.row];
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_dresserModel.thumbPath]
                 placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];

    
    CGFloat imgWidth = imageView.image.size.width;
    CGFloat imgHeight = imageView.image.size.height;
    UIImage *thumbImage = nil;
    //150.f cell宽度
    CGFloat cellWidth = (kScreenWidth - 20.f)/2;
    if (imgWidth > cellWidth) {
        CGFloat thumbImgHeight = (imgHeight/imgWidth) * cellWidth;
        CGSize size = CGSizeMake(cellWidth, thumbImgHeight);
        thumbImage = [UIImage lovThumbImage:imageView.image size:size];
    }else{
        thumbImage = imageView.image;
    }
    
    return thumbImage;
}

#pragma mark - collection view data source methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_dataArray count] > 0) {
        DresserQuiltViewCell *cell = (DresserQuiltViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
        
        _dresserModel = (DresserHomePageModel *)_dataArray[indexPath.row];
        
//        cell.photoView.image = _dresserModel.thumbImage;
//        cell.photoView.image  = [self imageAtIndexPath:indexPath];
        CGFloat myWidth = (kScreenWidth - 20)/2;
        CGFloat myRatio = [_dresserModel.picWhRatio floatValue]/100;
        NSLog(@"ratio = %f",myRatio);
        CGFloat height = myWidth/myRatio;
        NSLog(@"height = %f",height);
        cell.photoView.frame = CGRectMake(0, 0, (kScreenWidth - 20)/2, height);
        [cell.photoView sd_setImageWithURL:[NSURL URLWithString:_dresserModel.thumbPath] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        
        cell.userNameLabel.text =  _dresserModel.artistName;
        cell.titleLabel.text = [NSString stringWithFormat:@"#%@",_dresserModel.liveName];
        cell.addressLabel.text = _dresserModel.dresserLocation;
        cell.publishTimeLabel.text = _dresserModel.createTime;
        
        return cell;
    }else{
        return nil;
    }
}

#pragma mark - delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dressserMainVC == nil) {
        _dresserModel = (DresserHomePageModel *)_dataArray[indexPath.row];
        _dressserMainVC = [[DresserMainViewController alloc] init];
        _dressserMainVC.liveID = _dresserModel.liveId;
//        [_dressserMainVC reloadTableViewData];
        [self.navigationController pushViewController:_dressserMainVC animated:YES];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _dresserModel = (DresserHomePageModel *)_dataArray[indexPath.row];
    CGSize size = CGSizeMake(0,0);
//    NSLog(@"%@ %f", image, image.size.height);
    CGFloat radio = [_dresserModel.picWhRatio floatValue]/100;
    if (kScreenHeight <= 568.f) {
        size = CGSizeMake(photoViewWidth, photoViewWidth/radio + 100.f);
    }else{
        size = CGSizeMake(photoViewWidth, photoViewWidth/radio + 80.f);
    }
    NSLog(@"layout size h = %f", size.height);
    return size;
}

@end
