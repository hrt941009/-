//
//  LikeMainViewController.m
//  Love
//
//  Created by use on 15-4-3.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "LikeMainViewController.h"
#import "LOVSegmentControl.h"
#import "CommissionSKUViewController.h"
#import "LoginViewController.h"
#import "ShareProductDetailViewController.h"
#import "LikeShareViewController.h"
#import "ProductDetailViewController.h"

#import "MyLikeModel.h"
#import "UserManager.h"
#import "SKUModel.h"

#import "ShareProductTableViewCell.h"
#import "PublicProductCollectionViewCell.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
static NSString * const kCellPublicIdentifier = @"kCellPublicIdentifier";
@interface LikeMainViewController ()<UITableViewDataSource,UITableViewDelegate,addCartActionDelegate,CellSelectedDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    int nextPage;
    NSInteger segmentSelected;
}
@property (weak, nonatomic) IBOutlet UIImageView *NullIcon;
@property (weak, nonatomic) IBOutlet UILabel *NullLabel;
@property (weak, nonatomic) IBOutlet UIButton *bankMain;
- (IBAction)backMainView:(id)sender;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *productDataArray;
@property (nonatomic, strong) NSMutableArray *shareDataArray;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UINib *nib;
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) LOVSegmentControl *segment;
@property (nonatomic, strong) CommissionSKUViewController *skuViewController;
@property (nonatomic, strong) ShareProductDetailViewController *shareProductDetail;
@property (nonatomic, strong) LikeShareViewController *likeShareViewController;
@property (nonatomic, strong) ProductDetailViewController *shareDetailVC;
@end

@implementation LikeMainViewController
#pragma mark --CellSelectedDelegate
- (void)cellSelectedActionWithShareId:(NSString *)shareId{
    ProductDetailViewController *shareDetailVC = [[ProductDetailViewController alloc] init];
    shareDetailVC.shareId = shareId;
    shareDetailVC.myTitle = @"我也不知道这个值从哪里来";
    [self.navigationController pushViewController:shareDetailVC animated:YES];
}

#pragma mark -- addCartActionDelegate
- (void)shareProductAddCartButton:(UIButton *)bnt{
    NSIndexPath *indexPath = (NSIndexPath *)[_tableView indexPathForCell:(UITableViewCell *)[[bnt superview] superview]];
    int row = (int)[indexPath row];
    MyLikeModel *model = _dataArray[row];
    [self pushSKUViewController:YES ProductId:model.commodityId ProductIntro:model.commDescription];
}

//跳转到SKU页面
- (void)pushSKUViewController:(BOOL)isCart ProductId:(NSString *)productId ProductIntro:(NSString *)productIntro
{
    NSString *sig = [UserManager readSig];
    if ([sig length] > 0) {
        if (_skuViewController == nil) {
            NSString *item = productId;
            [SKUModel getSKUWithItem:item block:^(NSString *thumbPath, NSString *stockNum,NSString *section1,
                                                  NSString *section2, NSString *price1, NSString *price2, NSString *price3, NSString *defaultPrice, NSDictionary *commoListDic, NSArray *skuValueArray) {
                
                _skuViewController = [[CommissionSKUViewController alloc] initWithNibName:@"CommissionSKUViewController" bundle:nil];
                _skuViewController.isCart = isCart;
                _skuViewController.commoStr = item;
                _skuViewController.thumbPath = thumbPath;
                _skuViewController.stocksNum = stockNum;
                _skuViewController.defaultPrice = defaultPrice;
                _skuViewController.commList = commoListDic;
                _skuViewController.skuValueArr = skuValueArray;
                _skuViewController.section1 = section1;
                _skuViewController.section2 = section2;
                _skuViewController.price1 = price1;
                _skuViewController.price2 = price2;
                _skuViewController.price3 = price3;
                
                _skuViewController.intro = productIntro;
                [self.navigationController pushViewController:_skuViewController animated:YES];
            }];
        }
    }else{
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的喜欢";
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [[NSMutableArray alloc] init];
//    _shareDataArray = [[NSMutableArray alloc] initWithObjects:@"fdsf",@"cscds",@"fsfds",@"caads",@"gfgfd", nil];
    _shareDataArray = [[NSMutableArray alloc] init];
    _productDataArray = [[NSMutableArray alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getLikeProductListData:)
                                                 name:kMyLikeNotificationName
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getShareListData:) name:kShareLikeNotificationName
                                               object:nil];
    
    _NullIcon.frame = CGRectMake((kScreenWidth - 100)/2, 143, 100, 100);
    _NullIcon.backgroundColor = [UIColor clearColor];
    _NullLabel.frame = CGRectMake(0, 273, kScreenWidth, 34);
    _bankMain.frame = CGRectMake((kScreenWidth - 130)/2, 309, 130, 30);
    
    [_bankMain setTitleColor:[UIColor colorRGBWithRed:233 green:69 blue:116 alpha:1] forState:UIControlStateNormal];
    _bankMain.titleLabel.font = [UIFont systemFontOfSize:18.f];
    _bankMain.layer.borderColor = [[UIColor colorWithWhite:0 alpha:0.1] CGColor];
    _bankMain.layer.borderWidth = 1.f;
    
    NSArray *array = @[@"喜欢的商品",@"喜欢的分享"];
    _segment = [[LOVSegmentControl alloc] initWithItems:array];
    _segment.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40);
    _segment.backgroundColor = [UIColor whiteColor];
    _segment.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _segment.layer.borderWidth = 0.4;
    _segment.selectedSegmentIndex = 0;
    [_segment addTarget:self action:@selector(segementAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segment];
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kScreenWidth, kScreenHeight - 64 - 40)];
    _backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_backView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((kScreenWidth - 8)/3, (kScreenWidth - 8)/3)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 7, kScreenWidth, _backView.frame.size.height - 14)  collectionViewLayout:flowLayout];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [_backView addSubview:_collectionView];
    
    [_collectionView registerClass:[PublicProductCollectionViewCell class] forCellWithReuseIdentifier:kCellPublicIdentifier];
//    [self relaodLikeData];
//    [self addHeaderRefresh];
//    [self addFooterRefresh];
    segmentSelected = _segment.selectedSegmentIndex;
    [MyLikeModel getMyLikeDataPage:@"1" andPageNum:@"1000"];
    
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PublicProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellPublicIdentifier forIndexPath:indexPath];
    MyLikeModel *model = _dataArray[indexPath.row];
    [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    cell.tagLabel.text = [NSString stringWithFormat:@"#%@",model.tagName];
    return cell;
}

#pragma mark -- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MyLikeModel *model = _dataArray[indexPath.row];
    if (_segment.selectedSegmentIndex == 0) {
        if (_shareProductDetail == nil) {
            _shareProductDetail = [[ShareProductDetailViewController alloc] init];
            _shareProductDetail.productId = model.commodityId;
            [_shareProductDetail reloadTheDataWithShare:NO];
            [self.navigationController pushViewController:_shareProductDetail animated:YES];
        }
    }
    if (_segment.selectedSegmentIndex == 1) {
        if (_shareDetailVC == nil) {
            _shareDetailVC = [[ProductDetailViewController alloc] init];
            _shareDetailVC.shareId = model.shareId;
            [self.navigationController pushViewController:_shareDetailVC animated:YES];
        }
    }
    
    
    
}
#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    nextPage = 1;
    _skuViewController = nil;
    _shareProductDetail = nil;
    _shareDetailVC = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (segmentSelected == 0) {
        [MyLikeModel getMyLikeDataPage:@"1" andPageNum:@"1000"];
    }
    if (segmentSelected == 1) {
        [MyLikeModel getShareLikeDataPage:@"1" andPageNum:@"1000"];
    }
}

- (void)getLikeProductListData:(NSNotification *)noti{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:noti.object];
    _productDataArray = _dataArray;
    [self.collectionView reloadData];
    
}

- (void)getShareListData:(NSNotification *)noti{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:noti.object];
    _shareDataArray = _dataArray;
    [self.collectionView reloadData];
}

- (void)segementAction:(LOVSegmentControl *)sender{
    NSInteger tag = sender.selectedSegmentIndex;
    NSLog(@"%ld",tag);
    if (tag == 0) {
        segmentSelected = sender.selectedSegmentIndex;
        [MyLikeModel getMyLikeDataPage:@"1" andPageNum:@"1000"];
    }else{
        segmentSelected = sender.selectedSegmentIndex;
        [MyLikeModel getShareLikeDataPage:@"1" andPageNum:@"1000"];
    }
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

- (IBAction)backMainView:(id)sender {
    if ([_delegate respondsToSelector:@selector(backMainViewWithTag:)]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
//        传递一个任意值过去判断是否返回主页面
        [_delegate backMainViewWithTag:kAllAddressKey];
    }
}
@end
