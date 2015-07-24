//
//  SearchResultViewController.m
//  Love
//
//  Created by use on 15-1-16.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "SearchResultViewController.h"
#import "CommissionCollectionCell.h"

#import "CommissionModel.h"
#import "CommissionDetailModel.h"
#import "CommissionCommodityViewController.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

static NSString * const kCellReuseIdentifier1 = @"CommissionCollectionCell1";
static NSString * const kCellReuseIdentifier2 = @"CommissionCollectionCell1";

@interface SearchResultViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    int nextPage;
}
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) CommissionCommodityViewController *commodityViewController;
@property (nonatomic, strong) CommissionModel *commissionModel;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SearchResultViewController
- (instancetype)init{
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
        nextPage = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _searchKey;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(searchDataResult:)
                                                 name:kSearchNoticefationName
                                               object:nil];
    
    
    
    //--返利的内容
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((kScreenWidth - 20.f)/2, (kScreenWidth - 20.f)/2 + 50.f)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5.f, 5.f, CGRectGetWidth(self.view.frame) - 10.f, self.view.frame.size.height - 78.f)
                                         collectionViewLayout:flowLayout];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[CommissionCollectionCell class] forCellWithReuseIdentifier:kCellReuseIdentifier1];
    
    
    [self addHeader];
    [self addFooter];
    
}
- (void)addHeader{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加下拉刷新头部控件
    [self.collectionView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        //----- get data
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.collectionView reloadData];
        }
        
        [CommissionModel getSearchDataWithKeyword:mySelf.searchKey page:@"1" pageNumber:@"10"];
        
    }];
    //自动刷新(一进入程序就下拉刷新)
    [self.collectionView headerBeginRefreshing];
}

- (void)addFooter{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf loadingDataAction];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    _commodityViewController = nil;
    
    [_collectionView reloadData];
    
}

- (void)loadingDataAction{
    nextPage = nextPage + 1;
    [CommissionModel getSearchDataWithKeyword:_searchKey page:[NSString stringWithFormat:@"%d",nextPage] pageNumber:@"10"];
}

- (void)searchDataResult:(NSNotification *)noti{
    
    [_dataArray addObjectsFromArray:[noti object]];
    [_collectionView reloadData];
    
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];

}

#pragma mark - collection view data source methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_dataArray.count > 0) {
        return [_dataArray count];
    }else{
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        CommissionCollectionCell *cell = (CommissionCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier1 forIndexPath:indexPath];
    if (_dataArray.count > 0) {
        _commissionModel =(CommissionModel *)_dataArray[indexPath.row];
        NSString *urlStr = _commissionModel.thumb;
        [cell.picImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]
                         placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
//        cell.sellerLabel.text = _commissionModel.brandName;
//        cell.descLabel.text = _commissionModel.cDetail;
//        cell.oldPriceLabel.text = [NSString stringWithFormat:@"￥%@", _commissionModel.originalPrice];
//        cell.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@", _commissionModel.price];
//    
//        [cell.likeButton setTitle:_commissionModel.love forState:UIControlStateNormal];
//        [cell.commentButton setTitle:_commissionModel.discuss forState:UIControlStateNormal];
//        [cell.subjectButton setTitle:_commissionModel.save forState:UIControlStateNormal];
//    
//        if ([_commissionModel.hasDiscount intValue] == 0) {
//            cell.discountDataLabel.text = MyLocalizedString(@"无折扣");
//        }
//        else if ([_commissionModel.hasDiscount intValue] == 1){
//            cell.discountDataLabel.text = [NSString stringWithFormat:@"%@%@", _commissionModel.discount, MyLocalizedString(@"折")];
//        }
//    
//        if ([_commissionModel.isRebate intValue] == 0) {
//        cell.commissionButton.alpha = 0;
//            [cell.commissionButton setTitle:nil forState:UIControlStateNormal];
//        }
//        else if ([_commissionModel.isRebate intValue] == 1){
//            cell.commissionButton.alpha = 1;
//            NSString *commText = [NSString stringWithFormat:@"%@%@￥", MyLocalizedString(@"返"), _commissionModel.rebate];
//            [cell.commissionButton setTitle:commText forState:UIControlStateNormal];
//        }
//    
//        if ([_commissionModel.hasCoupon intValue] == 0) {
//            cell.discountButton.alpha = 0;
//            [cell.discountButton setTitle:nil forState:UIControlStateNormal];
//        }
//        else if ([_commissionModel.hasCoupon intValue] == 1){
//            cell.discountButton.alpha = 1;
//            [cell.discountButton setTitle:MyLocalizedString(@"优惠") forState:UIControlStateNormal];
//        }
    }
        return cell;
    
}

#pragma mark - delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _commissionModel =(CommissionModel *)_dataArray[indexPath.row];
    
    
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
