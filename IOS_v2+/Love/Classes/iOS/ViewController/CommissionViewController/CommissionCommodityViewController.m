//
//  CommissionCommodityViewController.m
//  Love
//
//  Created by lee wei on 14-8-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CommissionCommodityViewController.h"
#import "AddSubjectViewController.h"
#import "LoginViewController.h"
#import "MyCartViewController.h"
#import "BigImageViewController.h"
#import "BrandViewController.h"
#import "CommissionSKUViewController.h"

#import "CCDetailTableViewCell.h"
#import "CCCommentTableViewCell.h"
#import "LOVWriteCommentView.h"
#import "CCBottomView.h"
#import "LOVShareActivityView.h"

#import "CommentListModel.h"
#import "CommentReplayModel.h"
#import "CommissionDetailModel.h"
#import "FollowMeModel.h"
#import "SKUModel.h"
#import "BrandModel.h"

#import "UIImageView+WebCache.h"

#import "LOVPhotoScrollView.h"
#import "LOVPageConfig.h"
#import "LOVCircle.h"
#import "UserManager.h"
#import "GenerationImage.h"


typedef NS_ENUM(NSInteger, CommButtonTag)
{
    CommButtonTagWithLike = 1,
    CommButtonTagWithDetail,
    CommButtonTagWithComment,
    CommButtonTagWithSubject,
    CommButtonTagWithCoupon,
    CommButtonTagWithShare,
    CommButtonTagWithCart,
    CommButtonTagWithBuy
};

@interface CommissionCommodityViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, CCBottomViewDelegate, LOVWriteCommentViewDelegate, UIAlertViewDelegate, LOVPhotoScrollViewDelegate>
{
    CGFloat scrollViewHeight;
    CGFloat tableViewHeight;
    CGFloat move;

    int myLike;
    
    int commentNextPage;
}

@property (nonatomic, strong) IBOutlet UIScrollView  *bgScrollView;
@property (nonatomic, strong) IBOutlet UIView   *headerView;
@property (nonatomic, strong) IBOutlet UILabel  *saleLabel, *nextPriceLabel;
@property (nonatomic, strong) IBOutlet UIButton *brandShopButton;
@property (nonatomic, strong) IBOutlet UIButton *likeButton, *detailButton, *commentButton, *subjectButton, *couponButton, *shareButton;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) LOVPhotoScrollView *photoView;
@property (nonatomic, strong) CCBottomView *bottomView;
@property (nonatomic, strong) LOVWriteCommentView *writeCommentView;

@property (nonatomic, strong) BrandViewController *brandViewController;
@property (nonatomic, strong) CommissionSKUViewController *skuViewController;

//----
@property (nonatomic, strong) UILabel *addLikeLabel;
@property (nonatomic, strong) UITableView *tableView; //点击商品详情、评论后出现的tableview

@property (nonatomic, strong) NSArray *detailArray;
@property (nonatomic, strong) NSMutableArray *commentArray;

@property (nonatomic, assign) BOOL isDetail;

//----
- (IBAction)buttonAction:(id)sender withEvent:(UIEvent *)event;

- (IBAction)pushBrandShopAction:(id)sender;

@end

@implementation CommissionCommodityViewController

#pragma mark - set view

- (UIColor *)viBorderLayerColor
{
    UIColor *color = [UIColor colorRGBWithRed:225.f green:225.f blue:225.f alpha:1.f];
    return color;
}

- (UIColor *)buttonSelectColor
{
    UIColor *color = [UIColor colorRGBWithRed:223.f green:35.f blue:84.f alpha:1.f];
    return color;
}

- (void)selectButton:(UIButton *)button imageName:(NSString *)imgName
{
    [button setBackgroundColor:[self buttonSelectColor]];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"commission_%@", imgName]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)noSelectButton:(UIButton *)button imageName:(NSString *)imgName
{
    [button setBackgroundColor:[UIColor colorRGBWithRed:229.f green:229.f blue:229.f alpha:1.f]];
    [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"commission_%@", imgName]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)setButtonStyle:(UIButton *)button
{
    button.layer.borderColor = [[self viBorderLayerColor] CGColor];
    button.layer.borderWidth = 1.f;
    
    [button setBackgroundColor:[UIColor colorRGBWithRed:229.f green:229.f blue:229.f alpha:1.f]];
}

- (void)setALLButtonStyle
{
    //----

    [self setButtonStyle:_likeButton];
    [self setButtonStyle:_detailButton];
    [self setButtonStyle:_commentButton];
    [self setButtonStyle:_subjectButton];
    [self setButtonStyle:_couponButton];
    [self setButtonStyle:_shareButton];
    
    _likeButton.tag = CommButtonTagWithLike;
    _detailButton.tag = CommButtonTagWithDetail;
    _commentButton.tag = CommButtonTagWithComment;
    _subjectButton.tag = CommButtonTagWithSubject;
    _couponButton.tag = CommButtonTagWithCoupon;
    _shareButton.tag = CommButtonTagWithShare;
}

#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"商品信息");
        self.hidesBottomBarWhenPushed = YES;
        
        self.view.backgroundColor = [UIColor colorRGBWithRed:229.f green:229.f blue:229.f alpha:1.f];
        _bgScrollView.backgroundColor = [UIColor clearColor];
        
        _commentArray = [[NSMutableArray alloc] init];
        
        myLike = 0;
        _likeStr = @"0";
        _subjectStr = @"0";
        _commentStr = @"0";
        
        
        _bgScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _headerView.frame = CGRectMake(4, 2, kScreenWidth - 10, 346 * (kScreenWidth - 10)/310);
        _photoView.frame = CGRectMake(5, 3, kScreenWidth - 15, _headerView.frame.size.height - 35);
        _saleLabel.frame = CGRectMake(0, _headerView.frame.size.height - 30, _headerView.frame.size.width/2, 30);
        _nextPriceLabel.frame = CGRectMake(_saleLabel.frame.size.width, _headerView.frame.size.height - 30, _headerView.frame.size.width/2, 30);
        _likeButton.frame = CGRectMake(1, _headerView.frame.size.height + 10, kScreenWidth/3, 35);
        _detailButton.frame = CGRectMake((kScreenWidth-6)/3 + 1, _headerView.frame.size.height + 10, (kScreenWidth-6)/3, 35);
        _commentButton.frame = CGRectMake(2 * (kScreenWidth-6)/3 + 2, _headerView.frame.size.height + 10, (kScreenWidth-6)/3, 35);
        _subjectButton.frame = CGRectMake(1, _headerView.frame.size.height + 45, kScreenWidth/3, 35);
        _couponButton.frame = CGRectMake((kScreenWidth-6)/3 + 1, _headerView.frame.size.height + 45, (kScreenWidth-6)/3, 35);
        _shareButton.frame = CGRectMake(2 * (kScreenWidth-6)/3 + 2, _headerView.frame.size.height + 45, (kScreenWidth-6)/3, 35);
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //获取商品详情
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(descriptionNotice:)
                                                 name:kCommissionDescNotificationName
                                               object:nil];
    
    //----- 购物车按钮 start
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0, 0, 64.f, 40.f);
    [cartButton setBackgroundColor:[UIColor clearColor]];
    //[cartButton setBackgroundImage:[UIImage imageNamed:@"commission_cart"] forState:UIControlStateNormal];
    [cartButton setImage:[UIImage imageNamed:@"commission_cart"] forState:UIControlStateNormal];
    cartButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30.f, 0, 0);
    [cartButton setTitle:@"" forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(cartAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cartBarButton = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    self.navigationItem.rightBarButtonItem = cartBarButton;

    //-------
    
    //------ 点‘喜欢’button后 显示+1
    _addLikeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_likeButton.frame) - 30.f, _likeButton.frame.origin.y - 10.f, 30.f, 30.f)];
    _addLikeLabel.backgroundColor = [UIColor clearColor];
    _addLikeLabel.textColor = [UIColor redColor];
    _addLikeLabel.font = [UIFont systemFontOfSize:24.f];
    _addLikeLabel.alpha = 0;
    [_bgScrollView addSubview:_addLikeLabel];
    //--- end
    
    
    /*-- 图片上喜欢、加入专题、评论数量
    _scrollViewLabel.backgroundColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.7];
    _scrollViewLabel.adjustsFontSizeToFitWidth = YES;
     */
    
    //--- 商品图片背景
    _headerView.layer.borderColor = [[self viBorderLayerColor] CGColor];
    _headerView.layer.borderWidth = 1.f;
    
    //--- 商品图片
    _photoView = [[LOVPhotoScrollView alloc] initWithFrame:CGRectMake(5.f, 3.f, _headerView.frame.size.width - 10.f, 309.f)];
    _photoView.layer.borderColor = [[self viBorderLayerColor] CGColor];
    _photoView.delegate = self;
    [_headerView addSubview:_photoView];
    
    
    //----标题 库存 下次购买价
    _saleLabel.adjustsFontSizeToFitWidth = YES;
    _nextPriceLabel.adjustsFontSizeToFitWidth = YES;
    
    _saleLabel.layer.borderColor = [[self viBorderLayerColor] CGColor];
    _saleLabel.layer.borderWidth = 1.f;
    
    _nextPriceLabel.layer.borderColor = [[self viBorderLayerColor] CGColor];
    _nextPriceLabel.layer.borderWidth = 1.f;
    
    /*--进入品牌店铺button下划线
    NSMutableAttributedString *oldString = [[NSMutableAttributedString alloc] initWithString:_brandShopButton.titleLabel.text];
    [oldString addAttributes:@{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}
                       range:NSMakeRange(0, [_brandShopButton.titleLabel.text length])];
    _brandShopButton.titleLabel.attributedText = oldString;
    */
    //--设置button
    [self setALLButtonStyle];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
        
    _brandViewController = nil;
    _skuViewController = nil;
    
    //获取是否喜欢 登陆后才判断
    NSString *sig = [UserManager readSig];
    if ([sig length] > 0) {
        [FollowMeModel isFollowWithID:_itemStr
                                 type:FollowModelTypeWithCommission
                                block:^(int code) {
                                    if (code == 1) {
                                        _likeButton.enabled = NO;
                                        [_likeButton setTitle:MyLocalizedString(@"已喜欢") forState:UIControlStateNormal];
                                        [_likeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                                    }
                                    if (code == 0) {
                                        [_likeButton setTitle:MyLocalizedString(@"喜欢") forState:UIControlStateNormal];
                                        _likeButton.enabled = YES;
                                    }
                                }];
    }

    //获取商品详情
    NSString *cID = _cid;
    [CommissionDescModel getCommissionDescListWithID:cID];
    
    /*---
    NSString *likeStr = [NSString stringWithFormat:@"喜欢 +%@", _likeStr];
    NSString *subjectStr = [NSString stringWithFormat:@"加入专题 +%@", _subjectStr];
    NSString *commentStr = [NSString stringWithFormat:@"评论 +%@", _commentStr];
    _scrollViewLabel.text = [NSString stringWithFormat:@" %@  %@  %@", likeStr, subjectStr, commentStr];
    */
    
    NSString *saleString = [NSString stringWithFormat:@"库存:%@", _stock];
    NSMutableAttributedString *saleAttrString = [[NSMutableAttributedString alloc] initWithString:saleString];
    [saleAttrString setAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}
                            range:NSMakeRange(0, 2)];
    [saleAttrString setAttributes:@{NSForegroundColorAttributeName: [UIColor colorRGBWithRed:226.f green:25.f blue:73.f alpha:1.f]}
                            range:NSMakeRange(3, [_stock length])];
    _saleLabel.attributedText = saleAttrString;
    
    //-----
    [_photoView setImagePathArray:_imageArray];

    //-------
//    if ([_isNextPriceStr isEqualToString:@"0"]) {
//        _nextPriceLabel.text = nil;
//    }
//    if ([_isNextPriceStr isEqualToString:@"1"]) {
        NSString *nextPriceString = [NSString stringWithFormat:@"到手价:%@元", _priceStr];
        NSMutableAttributedString *nextPriceAttrString = [[NSMutableAttributedString alloc] initWithString:nextPriceString];
        [nextPriceAttrString setAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}
                                     range:NSMakeRange(0, 3)];
        [nextPriceAttrString setAttributes:@{NSForegroundColorAttributeName: [UIColor colorRGBWithRed:226.f green:25.f blue:73.f alpha:1.f]}
                                 range:NSMakeRange(4, [_nextPriceStr length])];
        _nextPriceLabel.attributedText = nextPriceAttrString;
//    }
    
    if ([_isCouponStr isEqualToString:@"0"]) {
        _couponButton.enabled = NO;
        [_couponButton setTitle:@"无优惠券" forState:UIControlStateNormal];
        [_couponButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    if ([_isCouponStr isEqualToString:@"1"]) {
        _couponButton.enabled = YES;
        [_couponButton setTitle:@"领取惠券" forState:UIControlStateNormal];
        [_couponButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    //-----
    [self setBackgroundScrollView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    _photoView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 获取商品图片
- (void)getCommissionPhoto:(NSArray *)imageArray
{
    
    //_imageArray = imageArray;
}

#pragma mark - 设置scrollview和底部购买、加入购车view
- (void)setBackgroundScrollView
{
    CGFloat bgScrollViewHeight = kScreenHeight - 64.f - 44.f;
    
    //-----
    _bgScrollView.backgroundColor = [UIColor clearColor];
    CGRect rect = _bgScrollView.frame;
    rect.size.height = bgScrollViewHeight;
    _bgScrollView.frame = rect;
    
    scrollViewHeight = _bgScrollView.frame.size.height;
    
    _bgScrollView.scrollEnabled = YES;
    if (iPhone4) {
        _bgScrollView.contentSize = CGSizeMake(kScreenWidth - 2.f, kScreenHeight - 10.f);
    }else{
        _bgScrollView.contentSize = CGSizeMake(kScreenWidth - 2.f, bgScrollViewHeight);
    }
    
    
    //-----
    //--- 底部view 加入购车、购买
    _bottomView = [[CCBottomView alloc] initWithFrame:CGRectMake(0, bgScrollViewHeight, kScreenWidth, 44.f)];
    [_bottomView setBackgroundColor:[UIColor colorRGBWithRed:55.f green:55.f blue:55.f alpha:1.f]];
    _bottomView.delgate = self;
    _bottomView.alpha = 1.f;
    [_bottomView setBottomViewForWirte:NO];
    [self.view addSubview:_bottomView];
    
    _bottomView.bottomPriceStr = _priceStr;
    _bottomView.priceLabel.text = [NSString stringWithFormat:@"%@元", _priceStr];//;
    _bottomView.bottomOriginalPriceStr = _originalPriceStr;
    _bottomView.originalPriceLabel.text = [NSString stringWithFormat:@"%@元", _originalPriceStr];//;
    if ([_isDiscountStr isEqualToString:@"0"]) {
        _bottomView.bottomDiscount = @"10";
        _bottomView.discountLabel.text = @"无折扣";
    }
    if ([_isDiscountStr isEqualToString:@"1"]) {
        _bottomView.bottomDiscount = _discountStr;
        _bottomView.discountLabel.text = [NSString stringWithFormat:@"%@折", _discountStr];
    }
    
    
    //---
    move = 340.f;
    tableViewHeight = move + (_bottomView.frame.origin.y - CGRectGetMaxY(_subjectButton.frame));
}

#pragma mark - notice
- (void)descriptionNotice:(NSNotification *)notice
{
    _detailArray = [notice object];
    NSLog(@"_detailArray=%@", _detailArray);
}

#pragma mark - lov photo delegate
- (void)getImageViewTag:(NSInteger)tag
{
    if ([_imageArray count] > 0) {
        BigImageViewController *bigImageVC = [[BigImageViewController alloc] init];
        [bigImageVC getImageArray:_imageArray selectedImageViewTag:tag];
        [self presentViewController:bigImageVC animated:YES completion:nil];
    }
}

#pragma mark - 打开、移除商品详情页面、评论页面
- (void)moveBgScrollView
{
    for (id tv in [_bgScrollView subviews]) {
        if ([tv isKindOfClass:[UITableView class]]) {
            [(UITableView *)tv removeFromSuperview];
        }
    }
    //-------
    CGRect tvRect = CGRectMake(1.f, kScreenHeight + 200.f, _bgScrollView.frame.size.width - 2.f, tableViewHeight);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.layer.borderColor = [[self viBorderLayerColor] CGColor];
    _tableView.layer.borderWidth = 1.f;
    [_bgScrollView addSubview:_tableView];
    
    __block CGRect bgScrollViewframe = _bgScrollView.frame;
    __block CGRect tableViewFrame = _tableView.frame;
    
    [UIView animateWithDuration:0.5 delay:0.5 options:0
                     animations:^{
                         bgScrollViewframe.size.height = scrollViewHeight + move - 4.f;
                         bgScrollViewframe.origin.y = -move;
                         
                         tableViewFrame.origin.y = CGRectGetMaxY(_subjectButton.frame) + 2.f;
                     }
                     completion:^(BOOL finished) {
                         _bgScrollView.frame = bgScrollViewframe;
                         _tableView.frame = tableViewFrame;
                     }];
}

- (void)removeTableViewFromSuperView
{
    for (id tv in [_bgScrollView subviews]) {
        if ([tv isKindOfClass:[UITableView class]]) {
            [(UITableView *)tv removeFromSuperview];
        }
    }
    
    __block CGRect bgScrollViewframe = _bgScrollView.frame;
    [UIView animateWithDuration:0.5 animations:^{
        bgScrollViewframe.size.height = scrollViewHeight;
        bgScrollViewframe.origin.y = 0;
    } completion:^(BOOL finished) {
        _bgScrollView.frame = bgScrollViewframe;
    }];
}

#pragma mark - CCBottomViewDelegate
//写评论
- (void)writeMyComment
{
    _bottomView.alpha = 0;
    
    //---写评论页面
    _writeCommentView = [[LOVWriteCommentView alloc] init];
    _writeCommentView.alpha = 1.f;
    [_writeCommentView showWirteView];
    _writeCommentView.delegate = self;
    [self.view addSubview:_writeCommentView];
    //--- end

}

//跳转到SKU页面
- (void)pushSKUViewController:(BOOL)isCart
{
    NSString *sig = [UserManager readSig];
    if ([sig length] > 0) {
        if (_skuViewController == nil) {
            NSString *item = _cid;
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
                
                _skuViewController.intro = _intro;
                [self.navigationController pushViewController:_skuViewController animated:YES];
            }];
        }
    }else{
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}

//加入购车
- (void)putCart
{
    [self pushSKUViewController:YES];
}

//立即购买
- (void)buyNow
{
    [self pushSKUViewController:NO];
}

#pragma mark - timer
- (void)putCommissionCart
{
    
}

/**
#pragma mark - 键盘notice
/
 获取键盘高度
 
 @param  notification
 /
- (void)ccKeyboardFrame:(NSNotification *)notification{
    //  if(!isDisplayFaceBox){
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
#endif
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_3_2
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
#else
        NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey];
#endif
        CGRect keyboardBounds;
        [keyboardBoundsValue getValue:&keyboardBounds];
        
        CGFloat textBgViewY = [[UIScreen mainScreen] bounds].size.height - keyboardBounds.size.height - CommentWriteHeight - 64.f;
        CGRect rect = _commentWriteView.frame;
        rect.origin.y = textBgViewY;
        _commentWriteView.frame = rect;
        
        
        NSLog(@"%@",NSStringFromCGRect(keyboardBounds));
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    }
#endif
    
}
*/

#pragma mark - LOVWriteCommentViewDelegate 提交评论
- (void)cancelWirteComment
{
    _bottomView.alpha = 1.f;
    [self noSelectButton:_commentButton imageName:@"comment"];
    [self removeTableViewFromSuperView];
    [_bottomView setBottomViewForWirte:NO];
}

- (void)postCommentContent:(NSString *)content
{
    NSString *sig = [UserManager readSig];
    if ([sig length] > 0){
        if ([content length] > 0) {
            [CommentReplayModel postReplayWithItem:_itemStr
                                              toId:@""
                                           content:content
                                             block:^(int code) {
                                                 UIAlertView *alertView = nil;
                                                 if (code == 0) {
                                                     alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                            message:@"发送失败"
                                                                                           delegate:self
                                                                                  cancelButtonTitle:MyLocalizedString(@"返回")
                                                                                  otherButtonTitles:nil];
                                                     alertView.tag = 111;
                                                     alertView.delegate = self;
                                                     [alertView show];
                                                 }
                                                 if (code == 1) {
                                                     alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                            message:@"发送成功"
                                                                                           delegate:self
                                                                                  cancelButtonTitle:MyLocalizedString(@"返回")
                                                                                  otherButtonTitles:nil];
                                                     alertView.tag = 222;
                                                     alertView.delegate = self;
                                                     [alertView show];
                                                 }
                                             }];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"请填写评论"
                                                               delegate:self
                                                      cancelButtonTitle:MyLocalizedString(@"返回")
                                                      otherButtonTitles:nil];
            [alertView show];
        }

    }else{
        [_writeCommentView closeKeyboard];
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 111) {
        _bottomView.alpha = 1.f;
        [_writeCommentView hiddenViewAction];
        [_tableView reloadData];
    }
    if (alertView.tag == 222) {
        _bottomView.alpha = 1.f;
        [_writeCommentView hiddenViewAction];
        
        [CommentListModel getCommentWithItem:_itemStr//@"97"//
                                        page:kLovStartPage
                                        pnum:kLovPageNumber
                                       block:^(NSArray *array) {
                                           if ([_commentArray count] > 0) {
                                               [_commentArray removeAllObjects];
                                           }
                                           [_commentArray addObjectsFromArray:array];
                                           
                                           [_tableView reloadData];
                                       }];
    }
}

#pragma mark - button action
//购物车
- (void)cartAction
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

//品牌店铺
- (IBAction)pushBrandShopAction:(id)sender
{
    if (_brandViewController == nil) {
        [BrandModel getBrandInfoWithID:_brandId
                                 block:^(NSString *fansNum, NSString *brandID, NSString *intro, NSString *brandName, NSString *productNum, NSString *thumbPath) {
                                     _brandViewController = [[BrandViewController alloc] init];
                                     _brandViewController.brandId = brandID;
                                     _brandViewController.brandHeader = thumbPath;
                                     _brandViewController.brandName = brandName;
                                     _brandViewController.introString = intro;
                                     _brandViewController.followNum = fansNum;
                                     _brandViewController.pushNum = productNum;
                                     [self.navigationController pushViewController:_brandViewController animated:YES];
                                 }];
    }
}

- (IBAction)buttonAction:(id)sender withEvent:(UIEvent *)event
{
    UIButton *button = (UIButton *)sender;
    NSInteger tag = [button tag];
    button.selected = !button.selected;

    //UITouch *touch = [[event allTouches] anyObject];
    NSString *sig = [UserManager readSig];

    
    if (tag == CommButtonTagWithLike) {
        if ([sig length] > 0) {
            [self noSelectButton:_detailButton imageName:@"detail"];
            [self noSelectButton:_commentButton imageName:@"comment"];

            [FollowMeModel doFollowWithId:_itemStr
                                     type:FollowModelTypeWithCommission
                                    block:^(int code) {
                                        if (code == 1) {
                                            myLike = myLike + 1;
                                            [_bottomView setBottomViewForWirte:NO];
                                            [self removeTableViewFromSuperView];
                                            //_addLikeLabel.text = @"+1";
                                            //_addLikeLabel.alpha = 1;
                                            //[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(labelDismiss) userInfo:nil repeats:NO];
                                            _likeButton.enabled = NO;
                                            [_likeButton setTitle:MyLocalizedString(@"已喜欢") forState:UIControlStateNormal];
                                            [_likeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                                        }
                                    }];
        }else{
            LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginController animated:YES];
        }
    }
    if (tag == CommButtonTagWithDetail) {
        if (button.selected) {
            _commentButton.selected = NO;

            [self selectButton:_detailButton imageName:@"detail_select"];
            [self noSelectButton:_commentButton imageName:@"comment"];
            
            [_bottomView setBottomViewForWirte:NO];
            [self moveBgScrollView];
            _isDetail = YES;
            [_tableView reloadData];
        }
        if (!button.selected) {
            [self noSelectButton:_detailButton imageName:@"detail"];
            [self removeTableViewFromSuperView];
        }

    }
    if (tag == CommButtonTagWithComment) {

        if (button.selected) {
            _detailButton.selected = NO;
            
            [self noSelectButton:_detailButton imageName:@"detail"];
            [self selectButton:_commentButton imageName:@"comment_select"];
            
            [_bottomView setBottomViewForWirte:YES];
            [self moveBgScrollView];
            _isDetail = NO;
            
            [CommentListModel getCommentWithItem:_itemStr//@"97"//
                                            page:kLovStartPage
                                            pnum:kLovPageNumber
                                           block:^(NSArray *array) {
                                               if ([_commentArray count] > 0) {
                                                   [_commentArray removeAllObjects];
                                               }
                                               [_commentArray addObjectsFromArray:array];
                                               
                                               [_tableView reloadData];
                                           }];
        }
        if (!button.selected) {
            [self noSelectButton:_commentButton imageName:@"comment"];
            [self removeTableViewFromSuperView];
            [_bottomView setBottomViewForWirte:NO];
        }
    }
    if (tag == CommButtonTagWithSubject) {
        if ([sig length] > 0) {
            [self noSelectButton:_detailButton imageName:@"detail"];
            [self noSelectButton:_commentButton imageName:@"comment"];
            
            [_bottomView setBottomViewForWirte:NO];
            [self removeTableViewFromSuperView];
            
            AddSubjectViewController *addSubjectViewController = [[AddSubjectViewController alloc] initWithNibName:@"AddSubjectViewController" bundle:nil];
            addSubjectViewController.titleStr = _titleStr;
            addSubjectViewController.intro = _intro;
            addSubjectViewController.itemId = _cid;
            if ([_imageArray lastObject]) {
                addSubjectViewController.imgUrl = _imageArray[0];
            }
            [self.navigationController pushViewController:addSubjectViewController animated:YES];
        }else{
            LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginController animated:YES];
        }
    }
    if (tag == CommButtonTagWithCoupon) {
        if ([sig length] > 0) {
            [self noSelectButton:_detailButton imageName:@"detail"];
            [self noSelectButton:_commentButton imageName:@"comment"];
            
            [_bottomView setBottomViewForWirte:NO];
            [self removeTableViewFromSuperView];
        }else{
            LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:loginController animated:YES];
        }
    }
    if (tag == CommButtonTagWithShare) {
        [self noSelectButton:_detailButton imageName:@"detail"];
        [self noSelectButton:_commentButton imageName:@"comment"];
        
        [_bottomView setBottomViewForWirte:NO];
        [self removeTableViewFromSuperView];
        
        NSString *imgString = nil;
        if ([_imageArray count] > 0) {
            imgString = _imageArray[0];
        }else{
            imgString = nil;
        }

        LOVShareActivityView *shareView = [[LOVShareActivityView alloc] initWithShareType:LOVShareTypeSinaWeibo shareTitle:_titleStr shareDesc:[NSString stringWithFormat:@"RMB:%@￥,%@", _priceStr, _intro] shareURL:nil shareImageURL:imgString];
        [shareView show];
        
    }
}



//- (void)labelDismiss
//{
//    _addLikeLabel.alpha = 0;
//    if (myLike == 1) {
//        _likeButton.enabled = NO;
//        [_likeButton setTitle:@"已喜欢" forState:UIControlStateNormal];
//    }
//}


#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isDetail == YES) {
        return 1;
    }
    if (_isDetail == NO) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isDetail == YES) {
        return [_detailArray count];
    }
    if (_isDetail == NO) {
        if ([_commentArray count] > 0) {
            return [_commentArray count];
        }else{
            return 1;
        }
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *detailCellIdentifier = @"detailCellIdentifier";
    static NSString *commentCellIdentifier = @"commentCellIdentifier";
    if (_isDetail == YES) {
        
        CCDetailTableViewCell *detialCell = (CCDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:detailCellIdentifier];
        
        if (detialCell == nil) {
            detialCell = [[CCDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellIdentifier];
        }
        if ([_detailArray count] > 0) {

            [detialCell.cImageView sd_setImageWithURL:[NSURL URLWithString:_detailArray[indexPath.row]]
                                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                [detialCell commImageView:CGRectMake(0, 0, kScreenWidth, kScreenWidth * (image.size.height/image.size.width))];
                                                detialCell.cImageView.image = image;
                                            }];
        }
        //detialCell.cImageView.image = [UIImage imageNamed:@"icon_pic.png"];
        detialCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return detialCell;
    }
    if (_isDetail == NO) {
        
        if ([_commentArray count] > 0) {
            CCCommentTableViewCell *commentCell = (CCCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:commentCellIdentifier];
            
            if (commentCell == nil) {
                commentCell = [[CCCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellIdentifier];
                
            }
            
            CommentListModel *commentModel = (CommentListModel *)_commentArray[indexPath.row];
            
            commentCell.nameLabel.text = commentModel.fromName;
            commentCell.cdateLabel.text = commentModel.commentCreateTime;
            commentCell.commentLabel.text = commentModel.commentMessage;
            
            LOVCircle *circle = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, 40.f, 40.f)
                                                   imageWithPath:commentModel.fromHeader
                                                placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            [commentCell.headerView addSubview:circle];
            
            [commentCell setCellHeight];
            
            commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return commentCell;
        }else{
            UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"nocomment"];
            
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"nocomment"];
            }
            
            cell.detailTextLabel.text = @"还没有人评论哦！";
            
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
    if (_isDetail == YES) {
        CCDetailTableViewCell *detialCell  = (CCDetailTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
        
        return detialCell.cImageView.frame.size.height;
    }
    if (_isDetail == NO) {
        if ([_commentArray count] > 0) {
            CCCommentTableViewCell *cell = (CCCommentTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
            return [cell setCellHeight] + 20.f;
        }else{
            return 40.f;
        }
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}



@end
