//
//  DresserDetailViewController.m
//  Love
//
//  Created by lee wei on 14-10-7.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "DresserDetailViewController.h"
#import "CommissionCommodityViewController.h"
#import "MySubjectCommentViewController.h"
#import "DresserProductViewController.h"
#import "DresserDetailProductCell.h"
#import "DresserHomePageViewController.h"
#import "MyCartViewController.h"
#import "LoginViewController.h"
#import "LOVShareActivityView.h"

#import "CommissionDetailModel.h"
#import "DresserDetailModel.h"
#import "FollowMeModel.h"

#import "BigImageViewController.h"
#import "LOVPhotoScrollView.h"
#import "LOVCircle.h"
#import "UIImageView+WebCache.h"
#import "UserManager.h"

static NSInteger const goodsCellNumbers = 2;
static NSInteger const tableViewCellHeight = 56.f;

@interface DresserDetailViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, LOVPhotoScrollViewDelegate>
{
    UIButton *likeButton;
}

@property (nonatomic, strong) IBOutlet UIScrollView *bgScrollView;
@property (nonatomic, strong) IBOutlet UIView *headerIconView;
@property (nonatomic, strong) IBOutlet UIImageView *levelImageView;
@property (nonatomic, strong) IBOutlet UILabel *userNamelabel;
@property (nonatomic, strong) IBOutlet UILabel *keywordLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *photoScrollView;
@property (nonatomic, strong) IBOutlet UILabel *titlelabel;
@property (nonatomic, strong) IBOutlet UILabel *publishTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel *publishContentLabel;
@property (nonatomic, strong) IBOutlet UIView  *tableViewToplineView;
@property (nonatomic, strong) IBOutlet UIButton *pushDresserHomePageButton;

@property (nonatomic, strong) DresserHomePageViewController *dresserHomePageController;
@property (nonatomic, strong) MySubjectCommentViewController *commentViewController;
@property (nonatomic, strong) DresserProductViewController *productViewController;


@property (nonatomic, strong) NSArray  *goodsDataArray;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) DresserProductModel *productListModel;
@property (nonatomic, strong) LOVPhotoScrollView *lovPhotoView;

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UITableView *goodsTableView;


- (IBAction)pushDresserHomePageAction:(id)sender;

@end

@implementation DresserDetailViewController

#pragma mark -
#pragma mark - 底部 view
//--
- (void)setFooterView
{
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 800.f, kScreenWidth, 40.f)];
    _bottomView.backgroundColor = [UIColor colorRGBWithRed:249.f green:249.f blue:249.f alpha:1.f];
    [_bgScrollView addSubview:_bottomView];
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(10.f, 2.f, 90.f, 36.f);
    commentButton.backgroundColor = [UIColor clearColor];
    [commentButton setImage:[UIImage imageNamed:@"commission_comment"] forState:UIControlStateNormal];
    commentButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8.f);
    [commentButton setTitle:MyLocalizedString(@"评论") forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor Designmoo] forState:UIControlStateNormal];
    commentButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [commentButton addTarget:self action:@selector(commentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:commentButton];
    
    likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake((kScreenWidth - 90)/2 - 10 + 10.f, 2.f, 90.f, 36.f);
    likeButton.backgroundColor = [UIColor clearColor];
    [likeButton setImage:[UIImage imageNamed:@"commission_like"] forState:UIControlStateNormal];
    likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8.f);
    [likeButton setTitleColor:[UIColor Designmoo] forState:UIControlStateNormal];
    likeButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [_bottomView addSubview:likeButton];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(kScreenWidth - 100, 2.f, 90.f, 36.f);
    shareButton.backgroundColor = [UIColor clearColor];
    [shareButton setImage:[UIImage imageNamed:@"commission_share"] forState:UIControlStateNormal];
    shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8.f);
    [shareButton setTitle:MyLocalizedString(@"分享") forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor Designmoo] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:shareButton];

}

#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = MyLocalizedString(@"美妆师");
        
        self.view.backgroundColor = [UIColor whiteColor];
        _bgScrollView.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _bgScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _pushDresserHomePageButton.frame = CGRectMake(4, 0, kScreenWidth - 5, 74);
    _userNamelabel.frame = CGRectMake(84, 2, kScreenWidth - 94, 22);
    _keywordLabel.frame = CGRectMake(84, 25, kScreenWidth - 94, 30);
    _addressLabel.frame = CGRectMake(84, 53, kScreenWidth - 94, 22);
    _photoScrollView.frame = CGRectMake(0, 78, kScreenWidth, 310);
    _publishContentLabel.frame = CGRectMake(10, 414, kScreenWidth - 20, 24);
    _tableViewToplineView.frame = CGRectMake(0, 444, kScreenWidth, 1);
//    _isAttention = 0;
    
    //[DresserDetailModel getDresserDetailWithLiveID:_liveID];
    
    
    //--
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dresserInfoNotice:)
                                                 name:kDresserInfoNotification
                                               object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(dresserDetailNotice:)
//                                                 name:kDresserDetailNotification
//                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dresserProductNotice:)
                                                 name:kDresserProductListNotification
                                               object:nil];
    //--
 
    
    //--
    //----- 购物车按钮 start
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0, 0, 64.f, 40.f);
    [cartButton setBackgroundColor:[UIColor clearColor]];
    //[cartButton setBackgroundImage:[UIImage imageNamed:@"commission_cart"] forState:UIControlStateNormal];
    [cartButton setImage:[UIImage imageNamed:@"commission_cart"] forState:UIControlStateNormal];
    cartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30.f, 0, 0);
    [cartButton setTitle:@"" forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(dresserCartAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cartBarButton = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    self.navigationItem.rightBarButtonItem = cartBarButton;
    
    //---
    _photoScrollView.alpha = 0;
    _lovPhotoView = [[LOVPhotoScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_addressLabel.frame), _photoScrollView.frame.size.width, _photoScrollView.frame.size.height)];
    _lovPhotoView.delegate = self;
    [_bgScrollView addSubview:_lovPhotoView];
    
    //-----
    CGRect tvRect = CGRectMake(0, CGRectGetMaxY(_publishContentLabel.frame), kScreenWidth, 44.f);
    _goodsTableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _goodsTableView.backgroundColor = [UIColor clearColor];
    _goodsTableView.delegate = self;
    _goodsTableView.dataSource = self;
    _goodsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_bgScrollView addSubview:_goodsTableView];
    
    //---
    [self setFooterView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [DresserProductModel getDresserProductListWithLiveID:_liveID];
    
    _dresserHomePageController = nil;
    _commentViewController = nil;
    _productViewController = nil;
    
    _titlelabel.text = _publishTitle;
    _publishContentLabel.text = _publishContent;
    _publishTimeLabel.text = _publishDate;

    [DresserInfoModel getDresserInfoWithSellerID:_artistID];
    
    if ([_goodsDataArray count] == 0) {
        [self resetViewHeight];
    }
    
    if (_isAttention == 0) {
        likeButton.enabled = YES;
        [likeButton setTitle:@"关注" forState:UIControlStateNormal];
    }
    if (_isAttention == 1) {
        likeButton.enabled = NO;
        [likeButton setTitle:@"已关注"  forState:UIControlStateNormal];
        [likeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDresserInfoNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDresserProductListNotification object:nil];
    // Dispose of any resources that can be recreated.
}

- (void)getPhotoArray:(NSArray *)imgArray
{
    [_lovPhotoView setFullScreenImagePathArray:imgArray];
    _imageArray = imgArray;
}

#pragma mark - scroll image view delegate
- (void)getImageViewTag:(NSInteger)tag
{
    if ([_imageArray count] > 0) {
        BigImageViewController *bigImageVC = [[BigImageViewController alloc] init];
        [bigImageVC getImageArray:_imageArray selectedImageViewTag:tag];
        [self presentViewController:bigImageVC animated:YES completion:nil];

    }
}

#pragma mark - 计算tableview和scrollview高度
- (void)resetViewHeight
{    
    CGFloat pcWidth = _publishContentLabel.frame.size.width;
    CGFloat pcHeight = 0;
    
    CGRect contentRect = [_publishContentLabel.text boundingRectWithSize:CGSizeMake(pcWidth, 500.f)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                              attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.f]}
                                                                 context:nil];
    if (contentRect.size.height < 24.f) {
        pcHeight = 24.f;
    }else{
        pcHeight = contentRect.size.height;
    }
    
    //--- 重新算publishContentLabel高度
    CGRect publishRect =  _publishContentLabel.frame;
    publishRect.size.height = pcHeight;
    _publishContentLabel.frame = publishRect;
    
    //---- 分割线
    CGRect lineRect =  _tableViewToplineView.frame;
    lineRect.origin.y = CGRectGetMaxY(_publishTimeLabel.frame) + pcHeight + 5.f;
    _tableViewToplineView.frame = lineRect;
    
    //--- tableview
    NSInteger count = 0;
    if ([_goodsDataArray count] <= 0) {
        count = goodsCellNumbers;
    }else{
        count = [_goodsDataArray count];
    }
    
    CGFloat tvOriginY = CGRectGetMaxY(_publishTimeLabel.frame) + pcHeight + 10.f;
    CGRect tvRect = _goodsTableView.frame;
    tvRect.origin.y = tvOriginY;
    tvRect.size.height = count * tableViewCellHeight + 2.f;
    _goodsTableView.frame = tvRect;
    _goodsTableView.scrollEnabled = NO;
    
    //-----
    CGRect bottomRect = _bottomView.frame;
    bottomRect.origin.y = tvRect.size.height + tvOriginY;
    _bottomView.frame = bottomRect;
    
    //--
    _bgScrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(_goodsTableView.frame) + 200.f);
    
    //
    [_goodsTableView reloadData];
}

#pragma mark - notice
- (void)dresserInfoNotice:(NSNotification *)notice
{
    DresserInfoModel *infoModel = [[DresserInfoModel alloc] init];
    NSDictionary *dic = [notice userInfo];
    _userNamelabel.text = dic[infoModel.dresserName];
    _keywordLabel.text = dic[infoModel.dresserInfo];
    _addressLabel.text = dic[infoModel.dresserLocation];
//    _isAttention = [dic[infoModel.attention] intValue];
    
    LOVCircle *header = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, 45.f, 45.f)
                                           imageWithPath:dic[infoModel.headerPath]
                                        placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    [_headerIconView addSubview:header];
    
}

- (void)dresserDetailNotice:(NSNotification *)notice
{
//    DresserDetailModel *detailModel = [[DresserDetailModel alloc] init];
//    NSDictionary *dic = [notice userInfo];
//    _titlelabel.text = dic[detailModel.liveName];
//    _publishContentLabel.text = dic[detailModel.dresserIntro];
//    NSArray *photoArr = dic[detailModel.photoArray];
//    _imageArray = photoArr;
}

- (void)dresserProductNotice:(NSNotification *)notice
{
    NSArray *arr = [notice object];
    _goodsDataArray = arr;
    
    [self resetViewHeight];
    
    [_goodsTableView reloadData];
}

#pragma mark - scroll view delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = fabs(_photoScrollView.contentOffset.x/_photoScrollView.frame.size.width);
    
    _pageControl.currentPage = index;
}


#pragma mark - button
//进入美妆师主页
- (IBAction)pushDresserHomePageAction:(id)sender
{
    if (_isHomePage) {
        if (_dresserHomePageController == nil) {
            _dresserHomePageController = [[DresserHomePageViewController alloc] init];
            _dresserHomePageController.sellerId = _artistID;
            [self.navigationController pushViewController:_dresserHomePageController animated:YES];
        }
    }
}

//购物车
- (void)dresserCartAction
{
    NSString *sig = [UserManager readSig];
    if ([sig length] > 0) {
        MyCartViewController *cartViewController = [[MyCartViewController alloc] init];
        [self.navigationController pushViewController:cartViewController animated:YES];
    }else{
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}

//评论
- (void)commentButtonAction:(id)sender
{
    NSString *sig = [UserManager readSig];
    if (sig.length > 0) {
        _commentViewController = [[MySubjectCommentViewController alloc] init];
        _commentViewController.subjectID = _liveID;
        _commentViewController.isLive = YES;
        [self.navigationController pushViewController:_commentViewController animated:YES];
    }else{
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
   
}

//关注
- (void)likeButtonAction:(id)sender
{
    NSString *sig = [UserManager readSig];
    if ([sig length] > 0) {
        UIButton *button = (UIButton *)sender;
        [FollowMeModel doFollowLive:_liveID block:^(int code) {
            if (code == 1) {
                button.enabled = NO;
                [button setTitle:@"已关注" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"关注失败" delegate:self cancelButtonTitle:MyLocalizedString(@"Cancel") otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }else{
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}

//分享美妆师
- (void)shareButtonAction:(id)sender
{
    NSString *imgURL = nil;
    if ([_imageArray count] > 0) {
        imgURL = _imageArray[0];
    }else{
        imgURL = nil;
    }
    
    LOVShareActivityView *shareView = [[LOVShareActivityView alloc] initWithShareType:LOVShareTypeSinaWeibo shareTitle:_publishTitle shareDesc:_publishContent shareURL:nil shareImageURL:imgURL];
    [shareView show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_goodsDataArray count] > 0) {
        return [_goodsDataArray count];
    }else{
        return goodsCellNumbers;;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *noDataCellIdentifier = @"noDataCell";
    
    if ([_goodsDataArray count] > 0) {
        
        DresserDetailProductCell *cell = (DresserDetailProductCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DresserDetailProductCell" owner:self options:nil];
            for (id object in  nib) {
                if ([object isKindOfClass:[DresserDetailProductCell class]]) {
                    cell = (DresserDetailProductCell *)object;
                }
            }
        }
        
        _productListModel = (DresserProductModel *)_goodsDataArray[indexPath.row];
        
        [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:_productListModel.thumbPath]
                                 placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        
        cell.nameLabel.text = _productListModel.productName;
        cell.priceLabel.text = [NSString stringWithFormat:@"￥ %@", _productListModel.productPrice];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:noDataCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:noDataCellIdentifier];
        }
        cell.backgroundColor = [UIColor clearColor];

        if (indexPath.row == 0) {
            cell.detailTextLabel.text = MyLocalizedString(@"数据为空");
        }
        
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableViewCellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_goodsDataArray.count > 0) {
        _productListModel = (DresserProductModel *)_goodsDataArray[indexPath.row];
        NSString *item = _productListModel.productID;
        [CommissionDetailModel getDetailWithItem:item block:^(NSArray *array) {
        
            if (_productViewController == nil) {
                _productViewController = [[DresserProductViewController alloc] initWithNibName:@"DresserProductViewController" bundle:nil];
                CommissionDetailModel *model = (CommissionDetailModel *)[array lastObject];
            
                _productViewController.cid = model.cid;
                _productViewController.itemStr = item;
                _productViewController.titleStr = model.cName;
                _productViewController.saleStr = model.sales;
                _productViewController.isNextPriceStr = model.hasNextPrice;
                _productViewController.nextPriceStr = model.nextPrice;
                _productViewController.isCouponStr = model.hasCoupon;
                _productViewController.subjectStr = model.save;
                _productViewController.commentStr = model.discuss;
                _productViewController.likeStr = model.love;
                _productViewController.originalPriceStr = model.originalPrice;
                _productViewController.priceStr = model.price;
                _productViewController.discountStr = model.discount;
                _productViewController.isDiscountStr = model.hasDiscount;
                _productViewController.stockStr = model.commissionStock;
                _productViewController.isAttention = model.isAttention;
                _productViewController.dresserId = _artistID;
            
                [_productViewController getProductPhoto:model.cImageArray];
            
                [self.navigationController pushViewController:_productViewController animated:YES];
            }
        }];
    }
}

@end
