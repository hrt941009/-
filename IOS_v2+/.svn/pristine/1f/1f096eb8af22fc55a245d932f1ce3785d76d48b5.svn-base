//
//  ProductDetailViewController.m
//  Love
//
//  Created by use on 15-3-19.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "LOVPhotoScrollView.h"
#import "BigImageViewController.h"
#import "ShareDetialDataModel.h"
#import "FollowMeModel.h"
#import "CommentReplayModel.h"
#import "CommentViewController.h"
#import "UserHomeViewController.h"
#import "ShareProductDetailViewController.h"
#import "LOVShareActivityView.h"

#import "UserManager.h"
#import "LoginViewController.h"

#import "LOVCircle.h"
#import "LOVWriteCommentView.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"

@interface ProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,LOVPhotoScrollViewDelegate,LOVWriteCommentViewDelegate>
{
    CGFloat cellHeight;
    CGPoint tableViewContentOffSet;
}
@property (nonatomic, strong) NSMutableArray *dataArray;//评论列表
@property (nonatomic, strong) NSMutableArray *productArray;//产品列表
@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) NSMutableArray *imageArray;//轮播图片
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *commityButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) NSString *productDetailIntro;
@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, strong) NSString *discussNum;
@property (nonatomic, strong) NSString *isLike;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *shareContent;
@property (nonatomic, strong) NSString *shareTitle;

@property (nonatomic, strong) LOVPhotoScrollView *photoScrollView;
@property (nonatomic, strong) LOVWriteCommentView *writeCommentView;
@property (nonatomic, strong) ShareProductDetailViewController *productDetailVC;
@end

@implementation ProductDetailViewController

#pragma mark -- LOVWriteCommentViewDelegate
- (void)cancelWirteComment
{
    [_writeCommentView hiddenViewAction];
}

- (void)postCommentContent:(NSString *)content
{
    NSString *sig = [UserManager readSig];
    if ([sig length] > 0){
        if ([content length] > 0) {
            [CommentReplayModel postShareReplayItemShareId:_shareId content:content block:^(int code) {
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
                    [_writeCommentView hiddenViewAction];
                    [ShareDetialDataModel getShareDetailDataWithShareId:_shareId block:^(NSDictionary *detailInfo) {
//                        [_dataArray removeAllObjects];
                        _dataArray = [detailInfo objectForKey:@"share_discuss"];
//                        [_tabelView reloadData];
                        [self reloadTableView];
                    }];
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

#pragma mark - lov photo delegate
- (void)getImageViewTag:(NSInteger)tag
{
    if ([_imageArray count] > 0) {
        BigImageViewController *bigImageVC = [[BigImageViewController alloc] init];
        [bigImageVC getImageArray:_imageArray selectedImageViewTag:tag];
        [self presentViewController:bigImageVC animated:YES completion:nil];
    }
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
        _imageArray = [[NSMutableArray alloc] init];
        _productArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    _productDetailVC = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _myTitle;
    
    [ShareDetialDataModel getShareDetailDataWithShareId:_shareId block:^(NSDictionary *detailInfo) {
        [_imageArray removeAllObjects];
        [_imageArray addObjectsFromArray:[[detailInfo objectForKey:@"share_info"] objectForKey:@"img"]];
        [_dataArray addObjectsFromArray:[detailInfo objectForKey:@"share_discuss"]];
        [_productArray addObjectsFromArray:[detailInfo objectForKey:@"recom_product"]];
        _myTitle = [[detailInfo objectForKey:@"share_info"] objectForKey:@"share_title"];
        _productDetailIntro = [[detailInfo objectForKey:@"share_info"] objectForKey:@"share_content"];
        _tagName = [[detailInfo objectForKey:@"share_info"] objectForKey:@"tag_name"];
        _discussNum = [[detailInfo objectForKey:@"share_info"] objectForKey:@"discuss_num"];
        _isLike = [[detailInfo objectForKey:@"share_info"] objectForKey:@"is_love"];
        _header = [[detailInfo objectForKey:@"share_info"] objectForKey:@"header"];
        _userName = [[detailInfo objectForKey:@"share_info"] objectForKey:@"user_name"];
        _intro = [[detailInfo objectForKey:@"share_info"] objectForKey:@"intro"];
        _userId = [[detailInfo objectForKey:@"share_info"] objectForKey:@"user_id"];
        _shareContent = [[detailInfo objectForKey:@"share_info"] objectForKey:@"share_content"];
        _shareTitle = [[detailInfo objectForKey:@"share_info"] objectForKey:@"share_title"];
        
        [self reloadTableView];
        
    }];
    
}

- (void)reloadTableView{
    self.title = _myTitle;
    _tabelView = nil;
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.showsVerticalScrollIndicator = NO;
    _tabelView.showsHorizontalScrollIndicator = NO;
    _tabelView.backgroundColor = [UIColor colorRGBWithRed:251 green:251 blue:251 alpha:1];
    [self.view addSubview:_tabelView];
    _tabelView.contentOffset = tableViewContentOffSet;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    if (section == 1) {
        return 0;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        if ([_productArray count] > 0) {
            return [_productArray count];
        }else{
            return 1;
        }
    }
    if (section == 4) {
        if ([_dataArray count] > 0) {
            return [_dataArray count] + 1;
        }else{
            return 1;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        static NSString *cellID1 = @"cellID1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        }
        cell.textLabel.text = _productDetailIntro;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        
        return cell;
    }
    if (indexPath.section == 3) {
        static NSString *cellID2 = @"cellID2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        }
        for (UIView *vi in cell.contentView.subviews) {
            [vi removeFromSuperview];
        }
        if ([_productArray count] > 0) {
            NSDictionary *productDic = _productArray[indexPath.row];
            LOVCircle *imageView = [[LOVCircle alloc] initWithFrame:CGRectMake(5, 5, 40, 40) imageWithPath:[productDic objectForKey:@"thumb"] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            [cell.contentView addSubview:imageView];
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, kScreenWidth - 70, 20)];
            nameLabel.textColor = [UIColor blackColor];
            nameLabel.text = [productDic objectForKey:@"name"];
            nameLabel.font = [UIFont systemFontOfSize:14.f];
            [cell.contentView addSubview:nameLabel];
            
            UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, kScreenWidth - 70, 25)];
            priceLabel.font = [UIFont systemFontOfSize:17.f];
            NSString *priceStr = [productDic objectForKey:@"price"];
            priceLabel.text = [NSString stringWithFormat:@"￥%@",priceStr];
            priceLabel.textColor = [UIColor redColor];
            priceLabel.font = [UIFont systemFontOfSize:12.f];
            [cell.contentView addSubview:priceLabel];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else{
            cell.textLabel.text = @"还没有关联商品";
        }
        return cell;
    }
    if (indexPath.section == 4) {
        static NSString *cellID3 = @"cellID3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID3];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
        }
        for (UIView *vi in cell.contentView.subviews) {
            [vi removeFromSuperview];
        }
        
        if ([_dataArray count] > 0) {
            if (indexPath.row < [_dataArray count]){
                NSDictionary *commityDic = _dataArray[indexPath.row];
                LOVCircle *circle = [[LOVCircle alloc] initWithFrame:CGRectMake(5, 15, 40, 40) imageWithPath:[commityDic objectForKey:@"header"] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
                [cell.contentView addSubview:circle];
                
                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, kScreenWidth - 70, 20)];
                nameLabel.textColor = [UIColor colorRGBWithRed:147 green:194 blue:214 alpha:1];
                nameLabel.text = [commityDic objectForKey:@"name"];
                [cell.contentView addSubview:nameLabel];
                
                UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, kScreenWidth - 70, 10)];
                timeLabel.font = [UIFont systemFontOfSize:12.f];
                timeLabel.text = [commityDic objectForKey:@"create_time"];
                [cell.contentView addSubview:timeLabel];
                
                UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, kScreenWidth - 70, 60)];
                content.numberOfLines = 0;
                content.text = [commityDic objectForKey:@"content"];
                content.font = [UIFont systemFontOfSize:15.f];
                [cell.contentView addSubview:content];
            }else if (indexPath.row == [_dataArray count]){
                cell.textLabel.text = @"查看更多评论>>";
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            }
        }else{
            cell.textLabel.text = @"还没有评论";
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
//    static NSString *cellID = @"cellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    for (UIView *vi in cell.contentView.subviews) {
//        [vi removeFromSuperview];
//    }
//    if (indexPath.section == 2) {
//        cell.textLabel.text = _productDetailIntro;
//        cell.textLabel.numberOfLines = 0;
//        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
//    }
//    if (indexPath.section == 3){
//        if ([_productArray count] > 0) {
//                NSDictionary *productDic = _productArray[indexPath.row];
//                LOVCircle *imageView = [[LOVCircle alloc] initWithFrame:CGRectMake(5, 5, 40, 40) imageWithPath:[productDic objectForKey:@"thumb"] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
//                [cell.contentView addSubview:imageView];
//                
//                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, kScreenWidth - 70, 20)];
//                nameLabel.textColor = [UIColor colorRGBWithRed:147 green:194 blue:214 alpha:1];
//                nameLabel.text = [productDic objectForKey:@"name"];
//                nameLabel.font = [UIFont systemFontOfSize:14.f];
//                [cell.contentView addSubview:nameLabel];
//                
//                UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, kScreenWidth - 70, 25)];
//                priceLabel.font = [UIFont systemFontOfSize:17.f];
//                NSString *priceStr = [productDic objectForKey:@"price"];
//                priceLabel.text = [NSString stringWithFormat:@"￥%@",priceStr];
//                priceLabel.textColor = [UIColor redColor];
//                priceLabel.font = [UIFont systemFontOfSize:12.f];
//                [cell.contentView addSubview:priceLabel];
//                
//                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                
//            }else{
//                cell.textLabel.text = @"还没有关联商品";
//            }
//    }
//    if (indexPath.section == 4) {
//        if ([_dataArray count] > 0) {
//                if (indexPath.row < [_dataArray count]){
//                    NSDictionary *commityDic = _dataArray[indexPath.row];
//                    LOVCircle *circle = [[LOVCircle alloc] initWithFrame:CGRectMake(5, 15, 40, 40) imageWithPath:[commityDic objectForKey:@"header"] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
//                    [cell.contentView addSubview:circle];
//                
//                    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, kScreenWidth - 70, 20)];
//                    nameLabel.textColor = [UIColor colorRGBWithRed:147 green:194 blue:214 alpha:1];
//                    nameLabel.text = [commityDic objectForKey:@"name"];
//                    [cell.contentView addSubview:nameLabel];
//                
//                    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35, kScreenWidth - 70, 10)];
//                    timeLabel.font = [UIFont systemFontOfSize:12.f];
//                    timeLabel.text = [commityDic objectForKey:@"create_time"];
//                    [cell.contentView addSubview:timeLabel];
//                
//                    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, kScreenWidth - 70, 60)];
//                    content.numberOfLines = 0;
//                    content.text = [commityDic objectForKey:@"content"];
//                    content.font = [UIFont systemFontOfSize:15.f];
//                    [cell.contentView addSubview:content];
//                }else if (indexPath.row == [_dataArray count]){
//                    cell.textLabel.text = @"查看更多评论>>";
//                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
//                }
//        }else{
//                cell.textLabel.text = @"还没有评论";
//        }
//        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    return cell;
    return nil;
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        CGSize constraint = CGSizeMake(kScreenWidth, 20000.0f);
        CGSize size = [_productDetailIntro boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f]} context:nil].size;
        
        CGFloat height = MAX(size.height, 44.0f);
        return height;
    }
    if (indexPath.section == 3) {
        return 60.f;
    }
    if (indexPath.section == 4) {
        if (indexPath.row == [_dataArray count]) {
            return 42;
        }
    }
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 370;
    }
    if (section == 1) {
        return 60;
    }
    if (section == 2) {
        return 33;
    }
    if (section == 3) {
        return 33;
    }
    if (section == 4) {
        return 36;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 44;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth , 370)];
        view.backgroundColor = [UIColor clearColor];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 15, kScreenWidth - 20, 350)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 3.f;
        backView.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
        backView.layer.borderWidth = 1.f;
        [view addSubview:backView];
        
        _photoScrollView = [[LOVPhotoScrollView alloc] initWithFrame:CGRectMake(5, 5, backView.frame.size.width - 10, backView.frame.size.height - 45)];
        _photoScrollView.delegate = self;
        [backView addSubview:_photoScrollView];
        
        [_photoScrollView setImagePathArray:_imageArray];
        
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, backView.frame.size.height - 25 - 35, 40, 15)];
        tagLabel.backgroundColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3];
        tagLabel.font = [UIFont systemFontOfSize:14.f];
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.text = [NSString stringWithFormat:@"#%@",_tagName];
        [backView addSubview:tagLabel];
        
        _likeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, backView.frame.size.height - 35, backView.frame.size.width/3, 35)];
        _likeButton.backgroundColor = [UIColor clearColor];
        if ([_isLike isEqual:@"0"]) {
            [_likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
            [_likeButton setTitleColor:[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
            [_likeButton setImage:[UIImage imageNamed:@"commission_like"] forState:UIControlStateNormal];
            _likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
        }else{
            [_likeButton setTitle:@"已喜欢" forState:UIControlStateNormal];
            [_likeButton setTitleColor:[UIColor colorRGBWithRed:233 green:60 blue:103 alpha:1] forState:UIControlStateNormal];
            [_likeButton setImage:[UIImage imageNamed:@"icon_selectIcon"] forState:UIControlStateNormal];
            _likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        }
        _likeButton.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3] CGColor];
        _likeButton.layer.borderWidth = 0.3;
        [_likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:_likeButton];
        
        _commityButton = [[UIButton alloc] initWithFrame:CGRectMake(backView.frame.size.width/3, backView.frame.size.height - 35, backView.frame.size.width/3, 35)];
        _commityButton.backgroundColor = [UIColor clearColor];
        [_commityButton setTitle:@"评论" forState:UIControlStateNormal];
        [_commityButton setImage:[UIImage imageNamed:@"commission_comment"] forState:UIControlStateNormal];
        _commityButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
        [_commityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _commityButton.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3] CGColor];
        _commityButton.layer.borderWidth = 0.3;
        [_commityButton addTarget:self action:@selector(commityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:_commityButton];
        
        _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(backView.frame.size.width/3*2, backView.frame.size.height - 35, backView.frame.size.width/3, 35)];
        _shareButton.backgroundColor = [UIColor clearColor];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:@"commission_share"] forState:UIControlStateNormal];
        _shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 25);
        [_shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shareButton.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3] CGColor];
        _shareButton.layer.borderWidth = 0.3;
        [_shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:_shareButton];
        return view;
    }
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        view.backgroundColor = [UIColor whiteColor];
        UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [view addSubview:imageView];
        LOVCircle *circle = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, 40, 40) imageWithPath:_header placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        [imageView addSubview:circle];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, kScreenWidth - 60, 30)];
        nameLabel.textColor = [UIColor colorRGBWithRed:244 green:161 blue:180 alpha:1];
        nameLabel.text = _userName;
        nameLabel.font = [UIFont systemFontOfSize:15.f];
        [view addSubview:nameLabel];
        UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 35, kScreenWidth - 60, 20)];
        introLabel.font = [UIFont systemFontOfSize:12.f];
        introLabel.text = _intro;
        [view addSubview:introLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userMainInfo:)];
        [view addGestureRecognizer:tap];
        
        return view;
    }
    if (section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        view.backgroundColor = [UIColor colorRGBWithRed:251 green:251 blue:251 alpha:1];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, kScreenWidth - 20, 30)];
        label.text = _shareTitle;
        [view addSubview:label];
        
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(8, 98, kScreenWidth - 8, 1)];
//        lineView.backgroundColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3];
//        [view addSubview:lineView];
        
        return view;
    }
    if (section == 3) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        view.backgroundColor = [UIColor colorRGBWithRed:251 green:251 blue:251 alpha:1];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, kScreenWidth - 20, 30)];
        label.text = @"关联商品";
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(8, 1, kScreenWidth - 8, 0.5)];
        lineView1.backgroundColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3];
        [view addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(8, 35, kScreenWidth - 8, 0.5)];
        lineView2.backgroundColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3];
        [view addSubview:lineView2];
        return view;
    }
    if (section == 4) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        view.backgroundColor = [UIColor colorRGBWithRed:251 green:251 blue:251 alpha:1];
//        view.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 22, 20)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"icon_discuss"];
        [view addSubview:imageView];
        
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x + 30, 5, 165, 30)];
        myLabel.backgroundColor = [UIColor clearColor];
        myLabel.text = [NSString stringWithFormat:@"累计评价（%@）",_discussNum];
        myLabel.textColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.6];
        [view addSubview:myLabel];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(8, 1, kScreenWidth - 8, 0.5)];
        lineView1.backgroundColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3];
        [view addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(8, 35, kScreenWidth - 8, 0.5)];
        lineView2.backgroundColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3];
        [view addSubview:lineView2];
        
//        UILabel *saleLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 95, 0, 85, 30)];
//        saleLable.text = [NSString stringWithFormat:@"销量%@>",@"3174"];
//        [view addSubview:saleLable];
        return view;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 4) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
        view.backgroundColor = [UIColor clearColor];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 5, 80, 35)];
        [button addTarget:self action:@selector(discussAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"评论" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 3.f;
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        button.layer.borderWidth = 1.f;
        [view addSubview:button];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 5, kScreenWidth - 100, 35)];
        textField.backgroundColor = [UIColor whiteColor];
//        textField.borderStyle = UITextBorderStyleLine;
        textField.placeholder = @" 您想说点什么";
        textField.font = [UIFont systemFontOfSize:15.f];
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 3.f;
        textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        textField.layer.borderWidth = 1.f;
        textField.delegate = self;
        [view addSubview:textField];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4&&indexPath.row == [_dataArray count]) {
        NSLog(@"更多");
        CommentViewController *commentVC = [[CommentViewController alloc] init];
//        commentVC.isShare = YES;
        commentVC.commentStatu = MyCommentStatusShare;
        commentVC.shareId = _shareId;
        commentVC.totleDiscussNum = _discussNum;
        commentVC.dresserName = _userName;
        [self.navigationController pushViewController:commentVC animated:YES];
    }
    if (indexPath.section == 3) {
        if ([_productArray count] > 0) {
        NSLog(@"商品详情");
        if (_productDetailVC == nil) {
            _productDetailVC = [[ShareProductDetailViewController alloc] init];
            _productDetailVC.productId = [_productArray[indexPath.row] objectForKey:@"id"];
            _productDetailVC.productName = [_productArray[indexPath.row] objectForKey:@"name"];
            [_productDetailVC reloadTheDataWithShare:NO];
            [self.navigationController pushViewController:_productDetailVC animated:YES];
        }else{
        [SVProgressHUD showErrorWithStatus:@"未关联商品"];
        }
        }
    }
}


//发表评论触发按钮
- (void)discussAction:(UIButton *)sender{
    //---写评论页面
    _writeCommentView = [[LOVWriteCommentView alloc] init];
    _writeCommentView.alpha = 1.f;
    [_writeCommentView showWirteView];
    _writeCommentView.delegate = self;
    [self.view addSubview:_writeCommentView];
}
//喜欢按钮点击事件
- (void)likeButtonAction:(UIButton *)sender{
    NSLog(@"喜欢");
    NSString *sig = [UserManager readSig];
    if (sig.length > 0) {
        NSLog(@"喜欢");
        [FollowMeModel doFollowWithId:_shareId type:8 block:^(int code) {
            if (code == 1) {
                _isLike = @"1";
                [self.tabelView reloadData];
//                [self reloadTableView];
            }else{
                _isLike = @"0";
                [self.tabelView reloadData];
//                [self reloadTableView];
            }
        }];
        
        
        
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
}

//加入标签
- (void)commityButtonAction:(UIButton *)sender{
    NSLog(@"新建标签");
    CommentViewController *commentVC = [[CommentViewController alloc] init];
//    commentVC.isShare = YES;
    commentVC.commentStatu = MyCommentStatusShare;
    commentVC.shareId = _shareId;
    commentVC.totleDiscussNum = _discussNum;
    commentVC.dresserName = _userName;
    [self.navigationController pushViewController:commentVC animated:YES];
}

//分享按钮点击事件
- (void)shareButtonAction:(UIButton *)sender{
    NSLog(@"分享");
    LOVShareActivityView *shareView = [[LOVShareActivityView alloc] initWithShareType:LOVShareTypeSinaWeibo shareTitle:_userName shareDesc:_shareContent shareURL:[NSString stringWithFormat:@"%@%@",kShareURL,_shareId] shareImageURL:nil];
    [shareView show];
}

//进入个人主页
- (void)userMainInfo:(UITapGestureRecognizer *)tap{
    UserHomeViewController *userHomeVC = [[UserHomeViewController alloc] init];
    userHomeVC.userId = _userId;
    userHomeVC.userName = _userName;
    [self.navigationController pushViewController:userHomeVC animated:YES];
}


#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //---写评论页面
    _writeCommentView = [[LOVWriteCommentView alloc] init];
    _writeCommentView.alpha = 1.f;
    [_writeCommentView showWirteView];
    _writeCommentView.delegate = self;
    [self.view addSubview:_writeCommentView];
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _tabelView) {
        tableViewContentOffSet = _tabelView.contentOffset;
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

@end
