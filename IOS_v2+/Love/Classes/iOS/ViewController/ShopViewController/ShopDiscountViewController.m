//
//  ShopDiscountViewController.m
//  Love
//
//  Created by lee wei on 14/12/21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ShopDiscountViewController.h"

#import "ShopDiscountCell.h"

#import "ShopDiscountModel.h"

#import "LOVPageConfig.h"

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

static NSString * const kCellReuseIdentifier = @"kShopDiccountCell";

@interface ShopDiscountViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    int nextPage;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ShopDiscountViewController

#pragma mark - 刷新
- (void)addShopDiscountDataHeader
{
    
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加下拉刷新头部控件
    [self.collectionView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        //----- get data
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.collectionView reloadData];
        }
        
        // 增加数据
        [ShopDiscountModel getShopDiscountWithShopID:mySelf.shopID page:kLovStartPage pageNum:kLovPageNumber];
    }];
    
    //自动刷新(一进入程序就下拉刷新)
    [self.collectionView headerBeginRefreshing];
}

- (void)addShopDiscountDataFooter
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf loadingMoreDiscountData];

    }];
}

- (void)loadingMoreDiscountData
{
    nextPage = nextPage + 1;
    [ShopDiscountModel getShopDiscountWithShopID:self.shopID page:[NSString stringWithFormat:@"%d", nextPage] pageNum:kLovPageNumber];
}


#pragma mark --
- (void)viewDidLoad {
    [super viewDidLoad];
    
    nextPage = 1;
    
    _dataArray = [[NSMutableArray alloc] init];
    
    //---------
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shopDiscountDataNotice:)
                                                 name:kShopDiscountNotificationName object:nil];
    
    //--
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(150.f, 175.f)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5.f, 2.f, CGRectGetWidth(self.view.frame) - 10.f, self.view.frame.size.height - 64.f) collectionViewLayout:flowLayout];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[ShopDiscountCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];

    [self addShopDiscountDataHeader];
    [self addShopDiscountDataFooter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notice

- (void)shopDiscountDataNotice:(NSNotification *)notice
{
    [_dataArray addObjectsFromArray:[notice object]];

    [_collectionView reloadData];
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
}


#pragma mark - collection view data source methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShopDiscountCell *cell = (ShopDiscountCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    
    ShopDiscountModel *model = (ShopDiscountModel *)_dataArray[indexPath.row];
    
    NSString *urlString = model.thumb;
    
    [cell.photoImageView sd_setImageWithURL:[NSURL URLWithString:urlString]
                             placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    cell.priceLabel.text = model.price;
    cell.oldPriceLabel.text = model.oldPrice;
    
    
    return cell;
    
}

#pragma mark - delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}


@end
