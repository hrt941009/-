//
//  DresserProductViewController.m
//  Love
//
//  Created by lee wei on 14/11/19.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "DresserProductViewController.h"

#import "DresserProductInfoCell.h"
#import "CCDetailTableViewCell.h"
#import "CCCommentTableViewCell.h"
#import "CommissionSKUViewController.h"
#import "LoginViewController.h"
#import "LOVShareActivityView.h"

#import "BigImageViewController.h"
#import "LOVPhotoScrollView.h"
#import "LOVCircle.h"
#import "UIImageView+WebCache.h"

#import "CommentListModel.h"
#import "CommissionDetailModel.h"
#import "SKUModel.h"
#import "CommentReplayModel.h"
#import "FollowMeModel.h"

#import "UserManager.h"

@interface DresserProductViewController ()<LOVPhotoScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

{
    UITextView *cTextView;
    NSString *isFollow;
}

@property (nonatomic, strong) IBOutlet UIView *footerView;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UIButton *putCartButton, *buyNowButton;

@property (nonatomic, strong) UIView *commentView;

@property (nonatomic, strong)  UITableView *tableView;
@property (nonatomic, strong)  LOVPhotoScrollView *lovPhotoView;
@property (nonatomic, strong)  UINib *nib;
@property (nonatomic, strong)  DresserProductInfoCell *dresserProductCell;
@property (nonatomic, strong) CommissionSKUViewController *skuViewController;

@property (nonatomic, strong)  NSArray *dataArray;
@property (nonatomic, strong)  NSArray *detailArray;
@property (nonatomic, strong)  NSArray *commentArray;

@property (nonatomic, assign)  BOOL isDetail;

- (IBAction)putDresserProductCartAction:(id)sender;
- (IBAction)buyDresserProductNowButton:(id)sender;

@end

@implementation DresserProductViewController

#pragma mark -- 发表评论
- (void)commentAction:(UIButton *)sender{
    NSString *sig = [UserManager readSig];
    if (sig.length > 0) {
        if (cTextView.text.length>0) {
            NSString *toId = @"";
            [CommentReplayModel postReplayWithItem:_cid toId:toId content:cTextView.text block:^(int code) {
                if (code == 1) {
                    NSLog(@"成功");
                    cTextView.text = nil;
                    [CommentListModel getCommentWithItem:_itemStr//@"97"//
                                                    page:@"1"
                                                    pnum:@"20"
                                                   block:^(NSArray *array) {
                                                       
                                                       _commentArray = array;
                                                       [_tableView reloadData];
                                                   }];
                    
                    //                [_tableView setContentOffset:CGPointMake(0, 240.f) animated:YES];
                    [_tableView reloadData];
                }else{
                    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:@"评论失败，请重试!" delegate:nil cancelButtonTitle:MyLocalizedString(@"确定") otherButtonTitles:nil, nil];
                    [alerView show];
                }
            }];
        }else{
            UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入评论内容" delegate:nil cancelButtonTitle:MyLocalizedString(@"确定") otherButtonTitles:nil, nil];
            [alerView show];
        }
    }else{
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _titleStr;

    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f - 44.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    _skuViewController = nil;
    
    NSString *cID = _cid;
    [CommissionDescModel getCommissionDescListWithID:cID];
    //获取商品详情
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dresserProductDescriptionNotice:)
                                                 name:kCommissionDescNotificationName
                                               object:nil];
    
    //-----计算底部的view
    CGRect footerRect = _footerView.frame;
    footerRect.origin.y = kScreenHeight - 64.f - 44.f;
    _footerView.frame = footerRect;
    
    _footerView.backgroundColor = [UIColor colorRGBWithRed:254.f green:251.f blue:252.f alpha:1.f];
    
    _commentView = [[UIView alloc] init];
    _commentView.frame = footerRect;
    _commentView.backgroundColor = [UIColor colorRGBWithRed:254.f green:251.f blue:252.f alpha:1.f];
    [self.view addSubview:_commentView];
    
    cTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, 200, 32)];
    cTextView.backgroundColor = [UIColor clearColor];
    cTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cTextView.layer.borderWidth = 2.f;
    cTextView.layer.masksToBounds = YES;
    cTextView.layer.cornerRadius = 4.f;
    [_commentView addSubview:cTextView];
    
    UIButton *cButton = [[UIButton alloc] initWithFrame:CGRectMake(230, 5, 80, 32)];
    cButton.backgroundColor = [UIColor clearColor];
    cButton.layer.masksToBounds = YES;
    cButton.layer.cornerRadius = 4.f;
    [cButton setTitle:@"发表" forState:UIControlStateNormal];
    [cButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    cButton.backgroundColor = [UIColor colorRGBWithRed:210 green:50 blue:90 alpha:1];
    [cButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [_commentView addSubview:cButton];
    _commentView.hidden = YES;
    
    _priceLabel.textColor = [UIColor colorRGBWithRed:222.f green:18.f blue:76.f alpha:1.f];
    _priceLabel.text = _priceStr;
    
    _putCartButton.layer.borderColor = [[UIColor colorRGBWithRed:185.f green:100.f blue:124.f alpha:1.f] CGColor];
    _putCartButton.layer.borderWidth = 1.f;
    _putCartButton.layer.cornerRadius = 5.f;
    [_putCartButton setTitleColor:[UIColor colorRGBWithRed:225.f green:46.f blue:95.f alpha:1.f] forState:UIControlStateNormal];
    
    _buyNowButton.layer.borderColor = [[UIColor colorRGBWithRed:226.f green:39.f blue:91.f alpha:1.f] CGColor];
    _buyNowButton.layer.borderWidth = 1.f;
    _buyNowButton.layer.cornerRadius = 5.f;
    _buyNowButton.backgroundColor = [UIColor colorRGBWithRed:227.f green:53.f blue:99.f alpha:1.f];
    //--------
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
- (void)getProductPhoto:(NSArray *)imgArray
{
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        if (_isDetail == YES) {
            return [_detailArray count];
        }
        if (_isDetail == NO) {
            return [_commentArray count];
        }
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *dressserIentifier = @"dresserProductInfoCellIdentifier";
    static NSString *detailCellIdentifier = @"detailCellIdentifier";
    static NSString *commentCellIdentifier = @"commentCellIdentifier";
    static NSString *commentCellIdentifier1 = @"commentCellIdentifier1";
    
    NSInteger section = [indexPath section];
    if (section == 0) {
        if (!_nib) {
            _nib = [UINib nibWithNibName:@"DresserProductInfoCell" bundle:nil];
            [tableView registerNib:_nib forCellReuseIdentifier:dressserIentifier];
        }
        DresserProductInfoCell *cell = (DresserProductInfoCell *)[tableView dequeueReusableCellWithIdentifier:dressserIentifier];
        _dresserProductCell = cell;
        
        _lovPhotoView = [[LOVPhotoScrollView alloc] initWithFrame:CGRectMake(0, 0, cell.photoView.frame.size.width, 310.f)];
        _lovPhotoView.delegate = self;
        [cell.photoView addSubview:_lovPhotoView];
        [_lovPhotoView setFullScreenImagePathArray:_imageArray];
        
        cell.titleLabel.text = _titleStr;
        cell.emsLabel.text = @"";
        cell.salesLabel.text = [NSString stringWithFormat:@"%@:%@", MyLocalizedString(@"销量"), _saleStr];
        cell.stockLabel.text = [NSString stringWithFormat:@"%@ %@%@", MyLocalizedString(@"仅剩"), _stockStr, MyLocalizedString(@"件")];
        cell.likeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        cell.commentButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [cell.commentButton setTitle:[NSString stringWithFormat:@"%@", MyLocalizedString(@"评论")] forState:UIControlStateNormal];
        [cell.detailButton addTarget:self action:@selector(productDetailAciton:) forControlEvents:UIControlEventTouchUpInside];
        [cell.commentButton addTarget:self action:@selector(productCommentAciton:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeButton addTarget:self action:@selector(productLikeAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shareButton addTarget:self action:@selector(shareDresserProductAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([_isAttention isEqual:@"1"]) {
            cell.likeButton.enabled = NO;
            [cell.likeButton setTitle:[NSString stringWithFormat:@"%@", MyLocalizedString(@"已喜欢")] forState:UIControlStateNormal];
        }else{
            cell.likeButton.enabled = YES;
            [cell.likeButton setTitle:[NSString stringWithFormat:@"%@", MyLocalizedString(@"喜欢")] forState:UIControlStateNormal];
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    if (section == 1) {
        if (_isDetail == YES) {
            
            _footerView.hidden = NO;
            _commentView.hidden = YES;
            
            CCDetailTableViewCell *detialCell = (CCDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:detailCellIdentifier];
            
            if (detialCell == nil) {
                detialCell = [[CCDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellIdentifier];
            }
            if ([_detailArray count] > 0) {
//                [detialCell.cImageView sd_setImageWithURL:[NSURL URLWithString:_detailArray[indexPath.row]]
//                                         placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
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
            
            _footerView.hidden = YES;
            _commentView.hidden = NO;
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
        }
    }
    return nil;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    if (section == 0) {
        return 419.f;
    }
    if (section == 1) {
        if (_isDetail == YES) {
            CCDetailTableViewCell *detialCell  = (CCDetailTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
            
            return detialCell.cImageView.frame.size.height;
        }
        if (_isDetail == NO) {
            CCCommentTableViewCell *cell = (CCCommentTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
            return [cell setCellHeight] + 20.f;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - button
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
                _skuViewController.dresserId = _dresserId;
                [self.navigationController pushViewController:_skuViewController animated:YES];
            }];
        }
    }else{
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}

- (IBAction)putDresserProductCartAction:(id)sender
{
    [self pushSKUViewController:YES];
}

- (IBAction)buyDresserProductNowButton:(id)sender
{
    [self pushSKUViewController:NO];
}

- (void)shareDresserProductAction:(id)sender
{
    _footerView.hidden = NO;
    _commentView.hidden = YES;
    NSString *imgURL = nil;
    if ([_imageArray count] > 0) {
        imgURL = _imageArray[0];
    }else{
        imgURL = nil;
    }
    LOVShareActivityView *shareView = [[LOVShareActivityView alloc] initWithShareType:LOVShareTypeSinaWeibo shareTitle:self.title shareDesc:[NSString stringWithFormat:@"RMB:%@￥,%@", _priceStr, _productIntro] shareURL:nil shareImageURL:imgURL];
    [shareView show];
}

- (void)productDetailAciton:(id)sender
{
    _dresserProductCell.detailButton.enabled = NO;
    _dresserProductCell.commentButton.enabled = YES;
    
    _isDetail = YES;
    _detailArray = _dataArray;
    
    [_tableView setContentOffset:CGPointMake(0, 220.f) animated:YES];
    [_tableView reloadData];

}

- (void)productCommentAciton:(id)sender
{
    _dresserProductCell.detailButton.enabled = YES;
    _dresserProductCell.commentButton.enabled = NO;
    
    _isDetail = NO;
    [CommentListModel getCommentWithItem:_itemStr//@"97"//
                                    page:@"1"
                                    pnum:@"20"
                                   block:^(NSArray *array) {
                                       
                                       _commentArray = array;
                                       [_tableView reloadData];
                                   }];
    
    [_tableView setContentOffset:CGPointMake(0, 240.f) animated:YES];
    [_tableView reloadData];
    
}

- (void)productLikeAction:(id)sender{
    NSString *sig = [UserManager readSig];
    if (sig.length > 0) {
        [FollowMeModel doFollowWithId:_cid type:1 block:^(int code) {
            if (code == 1) {
                _dresserProductCell.likeButton.enabled = NO;
                [_dresserProductCell.likeButton setTitle:@"已喜欢" forState:UIControlStateNormal];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"关注失败，请重试！" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }else{
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}

#pragma mark - notice
- (void)dresserProductDescriptionNotice:(NSNotification *)notice
{
    _dataArray = [notice object];
}


@end
