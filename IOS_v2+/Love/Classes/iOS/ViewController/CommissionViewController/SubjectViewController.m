//
//  SubjectViewController.m
//  Love
//
//  Created by lee wei on 14-9-9.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SubjectViewController.h"

#import "MySubjectFunsViewController.h"
#import "MySubjectCommentViewController.h"
#import "SubjectCommissionTableViewCell.h"
#import "SubjectCommissionHeaderView.h"
#import "CommissionCommodityViewController.h"
#import "LoginViewController.h"
#import "MySubjectViewController.h"
#import "CommissionSKUViewController.h"
#import "MyCartViewController.h"
#import "SVProgressHUD.h"

#import "ShareProductDetailViewController.h"

#import "CommissionDetailModel.h"
#import "FollowMeModel.h"
#import "SubjectDetailModel.h"
#import "SubjectInfoModel.h"
#import "SKUModel.h"
#import "MeTagListModel.h"

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#import "LOVCircle.h"
#import "LOVPageConfig.h"
#import "UserManager.h"

static CGFloat const kImageOriginHight = 161.f;

@interface SubjectViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    CGRect headerRect;
    CGRect tableViewRect;
    int nextPage;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SubjectCommissionHeaderView *headerView;
@property (nonatomic, strong) UIImageView *zoomImageView;

@property (nonatomic, strong) MySubjectCommentViewController *commentViewController;
@property (nonatomic, strong) MySubjectViewController *mySubjectViewController;

@property (nonatomic, strong) ShareProductDetailViewController *shareProductDetailVC;
@property (nonatomic, strong) CommissionSKUViewController *skuViewController;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSString *headerPath;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userID;

@end

@implementation SubjectViewController

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



#pragma mark - 刷新
- (void)addSubjectDataFooter
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf moreSubjectDataAciton];

    }];
}

- (void)moreSubjectDataAciton
{
    nextPage = nextPage + 1;
    [MeTagListModel getTagProductListDataWith:_tagId Page:[NSString stringWithFormat:@"%d",nextPage] Pnum:kLovPageNumber];
//    [SubjectDetailModel getSubjectAlbum:_subjectId
//                                      p:[NSString stringWithFormat:@"%d", nextPage] pnum:kLovPageNumber];
    [_tableView reloadData];
}


#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _dataArray = [[NSMutableArray alloc] init];
        nextPage = 1;
    }
    return self;
}

- (void)cartButtonAction{
    MyCartViewController *myCart = [[MyCartViewController alloc] init];
    [self.navigationController pushViewController:myCart animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0, 0, 29, 20.f);
    cartButton.backgroundColor = [UIColor clearColor];
    [cartButton setBackgroundImage:[UIImage imageNamed:@"navBar_cart"] forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(cartButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cartBarButton = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    
    self.navigationItem.rightBarButtonItem = cartBarButton;
    
//    [SubjectDetailModel getSubjectAlbum:_subjectId p:kLovStartPage pnum:kLovPageNumber];
    
    [MeTagListModel getTagProductListDataWith:_tagId Page:kLovStartPage Pnum:kLovPageNumber];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(subjectDataNotice:)
                                                 name:kMeTagProductListNotificationName
                                               object:nil];
    //---
    self.view.backgroundColor = [UIColor whiteColor];
    
    //--
    self.title = _tagName;
    
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    //------- 顶部个人信息背景效果
    _zoomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_bg"]];
    _zoomImageView.frame = CGRectMake(0, -kImageOriginHight, self.tableView.frame.size.width, kImageOriginHight);
    _zoomImageView.userInteractionEnabled = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(kImageOriginHight, 0, 0, 0);
    [self.tableView addSubview:_zoomImageView];
    
    _headerView = [[SubjectCommissionHeaderView alloc] initWithFrame:CGRectMake(0, 0, _zoomImageView.frame.size.width, kImageOriginHight)];
    [_zoomImageView addSubview:_headerView];
    LOVCircle *iconView = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, 105.f, 105.f)
                                             imageWithPath:_header
                                          placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    [_headerView.iconView addSubview:iconView];
    
    _headerView.titleLabel.text = [NSString stringWithFormat:@"# %@",_tagName];
    _headerView.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_zoomImageView sendSubviewToBack:_headerView];
    
    
    [self addSubjectDataFooter];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _commentViewController = nil;
    _mySubjectViewController = nil;
    _shareProductDetailVC = nil;
    _skuViewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSubjectDetailNotificationName object:nil];
}

#pragma mark - button action

//加入购物车
- (void)buyButtonAction:(UIButton *)sender{
    UITableViewCell *myCell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [_tableView indexPathForCell:myCell];
    NSLog(@"%d",(int)indexPath.row);
    MeTagListModel *model = (MeTagListModel *)_dataArray[(int)indexPath.row];
    [self pushSKUViewController:YES ProductId:model.productId ProductIntro:model.productIntro];
    
}


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
- (void)subjectDataNotice:(NSNotification *)notice
{
    [_dataArray addObjectsFromArray:[notice object]];
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
    if ([_dataArray count] > 0) {
        return [_dataArray count];
    }else{
        return 1;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier2 = @"Cell2";
    static NSString *CellIdentifier3 = @"Cell3";
    
    if (indexPath.section == 0) {
        if ([_dataArray count] > 0) {
            SubjectCommissionTableViewCell *cell = (SubjectCommissionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
            
            if (cell == nil) {
                cell = [[SubjectCommissionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                             reuseIdentifier:CellIdentifier2];
                
            }
            MeTagListModel *model = (MeTagListModel *)_dataArray[indexPath.row];
            
            [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:model.productHeader]
                                     placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            cell.nameLabel.text = model.productName;
            cell.introLabel.text = model.productIntro;
            cell.priceLabel.text = [NSString stringWithFormat:@"￥%@", model.productPrice];
            
            [cell.buyButton addTarget:self action:@selector(buyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell setCellHeight];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else{
            UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier3];
            }
            cell.detailTextLabel.text = MyLocalizedString(@"数据为空");
            
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }
    return nil;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray count] > 0) {
        SubjectCommissionTableViewCell *cell = (SubjectCommissionTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
        [cell setCellHeight];
        return cell.frame.size.height;
    }else{
        return 40.f;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray count] >0){
    MeTagListModel *model = _dataArray[indexPath.row];
    if (_shareProductDetailVC == nil) {
        _shareProductDetailVC = [[ShareProductDetailViewController alloc] init];
        _shareProductDetailVC.productId = model.productId;
        _shareProductDetailVC.productName = model.productName;
        _shareProductDetailVC.tagId = _tagId;
        [_shareProductDetailVC reloadTheDataWithShare:NO];
        [self.navigationController pushViewController:_shareProductDetailVC animated:YES];
    }
    }else{
        [SVProgressHUD showErrorWithStatus:@"未关联商品"];
    }
}

@end
