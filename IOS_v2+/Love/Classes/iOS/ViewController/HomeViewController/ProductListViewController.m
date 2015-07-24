//
//  ProductListViewController.m
//  Love
//
//  Created by use on 15-3-24.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ProductListViewController.h"
#import "ShareProductDetailViewController.h"

#import "ProductMyDetailCollectionViewCell.h"
#import "CommissionModel.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "NSString+AdjustWidth.h"
static NSString * const kCellReuseIdentifier1 = @"ProductCollectionCell1";
@interface ProductListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    int nextPage;
}
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ProductListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = _tagName;
    _dataArray = [[NSMutableArray alloc] init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getProductListData:) name:kProductListDataNotificationName object:nil];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((kScreenWidth - 20.f)/2, (kScreenWidth - 20.f)/2 *168/150)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5.f, 5.f, CGRectGetWidth(self.view.frame) - 10.f, self.view.frame.size.height - 78.f)
                                         collectionViewLayout:flowLayout];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[ProductMyDetailCollectionViewCell class] forCellWithReuseIdentifier:kCellReuseIdentifier1];
    
    
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
        
//        [CommissionModel getSearchDataWithKeyword:mySelf.searchKey page:@"1" pageNumber:@"10"];
        [CommissionModel getProductListDataWithPage:@"1" pnum:@"10" tagId:mySelf.tagId];
        
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
        
    [_collectionView reloadData];
    
}

- (void)loadingDataAction{
    nextPage = nextPage + 1;
//    [CommissionModel getSearchDataWithKeyword:_searchKey page:[NSString stringWithFormat:@"%d",nextPage] pageNumber:@"10"];
    [CommissionModel getProductListDataWithPage:[NSString stringWithFormat:@"%d",nextPage] pnum:@"10" tagId:_tagId];
}

- (void)getProductListData:(NSNotification *)noti{
    [_dataArray addObjectsFromArray:[noti object]];
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
    ProductMyDetailCollectionViewCell *cell = (ProductMyDetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier1 forIndexPath:indexPath];
    if (_dataArray.count > 0) {
        CommissionModel *model = _dataArray[indexPath.row];
        [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        NSString *priceStr = model.price;
        CGSize priceSize = [priceStr sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(MAXFLOAT, 21)];
        CGSize markedSize = [model.markedPrice sizeWithFont:[UIFont systemFontOfSize:10] maxSize:CGSizeMake(MAXFLOAT, 18)];
        cell.price.frame = CGRectMake(15, cell.contentView.frame.size.height - 21, priceSize.width, 21);
        cell.markedPrice.frame = CGRectMake(CGRectGetMaxX(cell.price.frame) + 3, cell.contentView.frame.size.height - 18, markedSize.width + 12, 18);
        cell.lineView.frame = CGRectMake(CGRectGetMaxX(cell.price.frame) + 3, cell.contentView.frame.size.height - 10, markedSize.width + 12, 1);
        cell.title.text = model.productName;
        cell.likeNum.text = model.loveNum;
        cell.price.text = model.price;
        cell.markedPrice.text = [NSString stringWithFormat:@"￥%@",model.markedPrice];
        if ([model.discount isEqual:@"10.0"]) {
            cell.discount.text = @"无折扣";
        }else{
            cell.discount.text = [NSString stringWithFormat:@"%@折",model.discount];
        }
        cell.discount.adjustsFontSizeToFitWidth = YES;
    }
    return cell;
    
}

#pragma mark - delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CommissionModel *model = _dataArray[indexPath.row];
    ShareProductDetailViewController *shareProductDetailVC = [[ShareProductDetailViewController alloc] init];
    shareProductDetailVC.productId = model.productId;
    shareProductDetailVC.productName = model.productName;
//    shareProductDetailVC.tagId = model.myTagId;
    [shareProductDetailVC reloadTheDataWithShare:NO];
    [self.navigationController pushViewController:shareProductDetailVC animated:YES];
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
