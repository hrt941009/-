//
//  CommissionViewController.m
//  Love
//
//  Created by lee wei on 14-8-20.
//  Copyright (c) 2014年 李伟. All rights reserved.
//  首页

#import "CommissionViewController.h"
#import "CommissionCommodityViewController.h"
#import "LeftSideDrawerViewController.h"
#import "LoginViewController.h"
#import "HomeSubjectViewController.h"
#import "SubjectViewController.h"
#import "NewSearchViewController.h"
#import "HomeTagViewController.h"
#import "ProductListViewController.h"
#import "ShareListViewController.h"

#import "CommissionCollectionCell.h"

#import "CommissionModel.h"
#import "SubjectModel.h"
#import "CommissionDetailModel.h"

#import "LOVPageConfig.h"
#import "LOVSegmentControl.h"
#import "LOVLoadingView.h"

#import "MMDrawerBarButtonItem.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"

static NSString *const requestTime = @"day";


static NSString * const kCellReuseIdentifier = @"CommissionCollectionCell";

@interface CommissionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,SubjectViewControllerDelegate>
{
    CGFloat buttonWidth;
    CGFloat buttonHeight;
    NSInteger cvcType;
    BOOL isSubject;
    
    int nextPage;
}

@property (nonatomic, strong) CommissionCommodityViewController *commodityViewController;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HomeSubjectViewController *homeSubjectVC;
@property (nonatomic, strong) MMDrawerBarButtonItem * leftDrawerButton;
@property (nonatomic, strong) MMDrawerBarButtonItem * rightDrawerButton;

@property (nonatomic, strong) NSMutableArray *dataArray;//获取数据，"商品", @"分享"
@property (nonatomic, strong) NSString *catagoryKey; //"商品", @"分享"
@property (nonatomic, strong) NSString *pageRequestTime; //时间 day month year

@property (nonatomic, strong) CommissionModel *commissionModel;
@property (nonatomic, strong) SubjectModel *subjectModel;

@property (nonatomic, strong) LOVSegmentControl *segmentControl;

@property (nonatomic, strong) LOVLoadingView *loadingView;

@end

@implementation CommissionViewController


#pragma mark - 刷新
- (void)addCommissionHeader
{
    // 添加下拉刷新头部控件
    __unsafe_unretained typeof(self) mySelf = self;
    [self.collectionView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        nextPage = 1;
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.collectionView reloadData];
        }
        
        [CommissionModel getHomePageDataWithTime:requestTime
                                             key:mySelf.catagoryKey
                                               p:kLovStartPage
                                            pnum:kLovPageNumber];
        
    }];
    //自动刷新(一进入程序就下拉刷新)
    [self.collectionView headerBeginRefreshing];
}
- (void)addCommissionFooter
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf loadingDataAction];
    }];
}

- (void)loadingDataAction
{
    nextPage = nextPage + 1;
    [CommissionModel getProductMainDataWithKey:_catagoryKey
                                          Page:[NSString stringWithFormat:@"%d", nextPage]
                                          pnum:kLovPageNumber];
}

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
        _catagoryKey = @"";
        _pageRequestTime = requestTime;
        nextPage = 1;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //----- 初始为专辑
    isSubject = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(homePageDataNotice:)
                                                 name:kTagProductNotificationName object:nil];

    /*----- 导航条左侧按钮
    _leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:_leftDrawerButton animated:YES];
    */
    
    //----- 导航条右侧按钮
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(0, 0, 18.f, 18.f);
    searchButton.backgroundColor = [UIColor clearColor];
    [searchButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    //----- 顶部导航
    NSArray *titleArray = @[MyLocalizedString(@"标签"), MyLocalizedString(@"商品"), MyLocalizedString(@"分享")];
    _segmentControl = [[LOVSegmentControl alloc] initWithItems:titleArray];
    _segmentControl.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 39.f);
    _segmentControl.backgroundColor = [UIColor whiteColor];
    _segmentControl.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _segmentControl.layer.borderWidth = 0.4;
    [_segmentControl addTarget:self action:@selector(headerButtonAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentControl];
    
    CGFloat viewWidth = kScreenWidth;
    CGFloat viewHeight = kScreenHeight - 64.f - 44.f - 45.f;
    _contentView = [[UIView alloc] initWithFrame: CGRectMake(0, CGRectGetMaxY(_segmentControl.frame), viewWidth, viewHeight)];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    //---- 标签
    _homeSubjectVC = [[HomeSubjectViewController alloc] init];
    _homeSubjectVC.view.frame = _contentView.bounds;
    [_homeSubjectVC reloadHomeSubjectData];
    _homeSubjectVC.view.alpha = 1.f;
    _homeSubjectVC.delegate = self;
    [_homeSubjectVC.view setBackgroundColor:[UIColor clearColor]];
    _homeSubjectVC.view.userInteractionEnabled = YES;
    [_contentView addSubview:_homeSubjectVC.view];
    
    //--商品／分享 的内容
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((kScreenWidth - 20.f)/2, 163 * (kScreenWidth - 20.f)/300)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5.f, 10.f, CGRectGetWidth(self.view.frame) - 10.f, self.view.frame.size.height - 44 - 64 - 55)  collectionViewLayout:flowLayout];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    _collectionView.alpha = 0;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_contentView addSubview:_collectionView];
    
    [_collectionView registerClass:[CommissionCollectionCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

     _commodityViewController = nil;
    [_collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLeftSideDrawerLoginNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCommissionKeyNotificationName object:nil];
}

#pragma mark - HomeSubjectDelegate

- (void)pushTagViewControllerWithTitle:(NSString *)title labelId:(NSString *)labelId{
    HomeTagViewController *homeTagVC = [[HomeTagViewController alloc] init];
    homeTagVC.titleName = title;
    homeTagVC.labelId = labelId;
    [self.navigationController pushViewController:homeTagVC animated:YES];
}

- (void)pushLogin{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark - 获取专辑数据
// 获取标签数据
- (void)reloadCommissionView
{
    _segmentControl.selectedSegmentIndex = 0;
    
    _homeSubjectVC.view.alpha = 1.f;
    
    cvcType = CommissionButtonTagWithSubject;
    _catagoryKey = @"";
    isSubject = YES;
    
    _collectionView.alpha = 0;
    _loadingView.alpha = 0;
    [_loadingView.activityView stopAnimating];
    
    [_homeSubjectVC reloadHomeSubjectData];
    //[_collectionView reloadData];
}

#pragma mark - button action
/**
 打开侧边栏
 */
-(void)leftDrawerButtonPress:(id)sender{
    [_delegate toggleLeftDrawerSide];
//    MMDrawerAnimationType *animationTypeForSection = [[MMExampleDrawerVisualStateManager sharedManager] leftDrawerAnimationType];
}

- (void)rightDrawerButtonPress:(id)sender{
//    [_delegate toggleRightDrawerSide];
    NewSearchViewController *newSearchVC = [[NewSearchViewController alloc] init];
    [self.navigationController pushViewController:newSearchVC animated:YES];
}

//获取标签数据
- (void)getDiscountData
{
    [self reloadCommissionView];
}

#pragma mark - 顶部导航切换
//刷新 商品／分享
- (void)refreshCollectionData
{
    
    isSubject = NO;
    
    _homeSubjectVC.view.alpha = 0;
    _collectionView.alpha = 1.f;
    
    if (_loadingView == nil) {
        _loadingView = [[LOVLoadingView alloc] initWithFrame:CGRectMake(0, 30.f, kScreenWidth, 40.f)];
        _loadingView.alpha = 1.f;
        [self.view addSubview:_loadingView];
    }else{
        _loadingView.alpha = 1.f;
        [_loadingView.activityView startAnimating];
    }
    
    // 加载数据
    if ([self.dataArray count] > 0) {
        [self.dataArray removeAllObjects];
        [self.collectionView reloadData];
    }else{

    }
//    [CommissionModel getHomePageDataWithTime:requestTime
//                                         key:self.catagoryKey
//                                           p:kLovStartPage
//                                        pnum:kLovPageNumber];
    [CommissionModel getProductMainDataWithKey:self.catagoryKey Page:kLovStartPage pnum:kLovPageNumber];
    
    [self addCommissionFooter];

}

//切换 商品／分享 的数据
- (void)headerButtonAction:(LOVSegmentControl *)segmentControl
{
    nextPage = 1;
    NSInteger tag = segmentControl.selectedSegmentIndex;
    if (tag == CommissionButtonTagWithCommission) {
        [self reloadCommissionView];
    }
    if (tag == CommissionButtonTagWithDiscount) {
        _catagoryKey = kRebateKey;
        cvcType = CommissionButtonTagWithDiscount;
        [self refreshCollectionData];
    }
    if (tag == CommissionButtonTagWithComment) {
        _catagoryKey = kDiscussKey;
        cvcType = CommissionButtonTagWithComment;
        [self refreshCollectionData];
    }
}


//商品／分享的数据获取
- (void)homePageDataNotice:(NSNotification *)notice{
    NSArray *arr = [notice object];
    [_dataArray addObjectsFromArray:[notice object]];
    
    _loadingView.alpha = 0;
    [_loadingView.activityView stopAnimating];
    
    [_collectionView reloadData];
    
    [self.collectionView footerEndRefreshing];
    if ([arr count] == 0) {
        [self.collectionView removeFooter];
    }
}

#pragma mark - collection view data source methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CommissionCollectionCell *cell = (CommissionCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    
    _commissionModel =(CommissionModel *)_dataArray[indexPath.row];
    NSString *urlStr = _commissionModel.thumb;
    [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]
                         placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    cell.picImageView.backgroundColor = [UIColor lightGrayColor];
    cell.picImageView.layer.masksToBounds = YES;
    cell.picImageView.contentMode = UIViewContentModeScaleAspectFill;
    if (_catagoryKey == kRebateKey) {
        cell.titleLabel.text = _commissionModel.effect;
        cell.titleLabel.font = [UIFont systemFontOfSize:11];
        cell.introLabel.text = _commissionModel.tagIntro;
        cell.introLabel.font = [UIFont systemFontOfSize:9];
        cell.likeNum.text = _commissionModel.love;
        cell.myLabel.text = _commissionModel.tagName;
        cell.introLabel.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.6];
        cell.introLabel.frame = CGRectMake(2, cell.frame.size.height - 18, cell.frame.size.width - 2, 18);
    }
    if (_catagoryKey == kDiscussKey) {
        cell.introLabel.frame = CGRectMake(5, cell.frame.size.height - 27, cell.frame.size.width - 2, 30);
        cell.introLabel.numberOfLines = 0;
        cell.titleLabel.font = [UIFont systemFontOfSize:12.f];
        cell.introLabel.font = [UIFont systemFontOfSize:11.f];
        cell.introLabel.numberOfLines = 1;
        cell.titleLabel.text = _commissionModel.shareName;
        cell.introLabel.text = _commissionModel.shareIntro;
        cell.likeNum.text = _commissionModel.love;
        cell.myLabel.text = [NSString stringWithFormat:@"#%@",_commissionModel.shareTag];
        cell.myLabel.adjustsFontSizeToFitWidth = YES;
        cell.introLabel.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.6];
    }
    return cell;
}

#pragma mark - delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _commissionModel =(CommissionModel *)_dataArray[indexPath.row];
    /*
    NSString *item = _commissionModel.cid;//item=102
    
    [CommissionDetailModel getDetailWithItem:item block:^(NSArray *array) {
        if (_commodityViewController == nil) {
            _commodityViewController  = [[CommissionCommodityViewController alloc] initWithNibName:@"CommissionCommodity" bundle:nil];
            
            CommissionDetailModel *model = (CommissionDetailModel *)[array lastObject];
            _commodityViewController.imageArray = model.cImageArray;
            _commodityViewController.cid = model.cid;
            _commodityViewController.brandId = model.brandId;
            _commodityViewController.brandName = model.brandName;
            _commodityViewController.itemStr = item;
            _commodityViewController.titleStr = model.cName;
            _commodityViewController.saleStr = model.sales;
            _commodityViewController.isNextPriceStr = model.hasNextPrice;
            _commodityViewController.nextPriceStr = model.nextPrice;
            _commodityViewController.isCouponStr = model.hasCoupon;
            _commodityViewController.subjectStr = model.save;
            _commodityViewController.commentStr = model.discuss;
            _commodityViewController.likeStr = model.love;
            _commodityViewController.originalPriceStr = model.originalPrice;
            _commodityViewController.priceStr = model.price;
            _commodityViewController.discountStr = model.discount;
            _commodityViewController.isDiscountStr = model.hasDiscount;
            _commodityViewController.intro = model.intro;
            _commodityViewController.stock = model.commissionStock;
            
            //[_commodityViewController getCommissionPhoto:model.cImageArray];
            
            [self.navigationController pushViewController:_commodityViewController animated:YES];
        }
        
    }];
     */
    if (self.catagoryKey == kRebateKey) {
        ProductListViewController *productListVC = [[ProductListViewController alloc] init];
        productListVC.tagId = _commissionModel.tagId;
        productListVC.tagName = _commissionModel.tagName;
        [self.navigationController pushViewController:productListVC animated:YES];
    }
    if (self.catagoryKey == kDiscussKey) {
        ShareListViewController *shareListVC = [[ShareListViewController alloc] init];
        shareListVC.tagId = _commissionModel.shareTagId;
        shareListVC.tagName = _commissionModel.shareTag;
        [self.navigationController pushViewController:shareListVC animated:YES];
    }

}
@end
