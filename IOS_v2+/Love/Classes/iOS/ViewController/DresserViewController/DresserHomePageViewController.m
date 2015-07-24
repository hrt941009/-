//
//  DresserHomePageViewController.m
//  Love
//
//  Created by 李伟 on 14/11/15.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "DresserHomePageViewController.h"

#import "DresserHomePageHeaderView.h"
#import "DresserHomePageCell.h"
#import "DresserDetailViewController.h"
#import "DresserMainViewController.h"

#import "DresserDetailModel.h"
#import "FollowMeModel.h"
#import "DresserHomePageModel.h"

#import "UIImageView+WebCache.h"
#import "UIImage+Additions.h"

#import "LOVCircle.h"

#import "UserManager.h"
#import "LoginViewController.h"

@interface DresserHomePageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UINib *nib;
@property (nonatomic, strong) UIImageView *zoomImageView;
@property (nonatomic, strong) DresserHomePageHeaderView *headerView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BOOL isAttention;

@property (nonatomic, strong) DresserDetailViewController *detailViewController;
@property (nonatomic, strong) DresserHomePageModel *dresserModel;
@property (nonatomic, strong) DresserMainViewController *dresserMianVewController;
@end

static CGFloat const kImageOriginHight = 160.f;

@implementation DresserHomePageViewController

- (void)attentionAction:(id)sender{
    NSString *sig = [UserManager readSig];
    if (sig.length > 0) {
        UIButton *button = (UIButton *)sender;
        [FollowMeModel doFollowWithId:_sellerId type:5 block:^(int code){
            if (code == 1) {
                button.enabled = NO;
                [button setTitle:@"已关注" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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

#pragma mark - UIViewController

#pragma mark -
- (id)init
{
    self = [super init];
    if (self) {
//        self.title = MyLocalizedString(@"美妆师主页");
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getDresserInfoNotice:)
                                                 name:kDresserInfoNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dresserLiveNotice:)
                                                 name:kDresserLiveNotification
                                               object:nil];
    
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
//
    //------- 顶部个人信息背景效果
    _zoomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_userhome.jpg"]];
    _zoomImageView.frame = CGRectMake(0, -kImageOriginHight, self.tableView.frame.size.width, kImageOriginHight);
    _zoomImageView.userInteractionEnabled = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(kImageOriginHight, 0, 0, 0);
    [self.tableView addSubview:_zoomImageView];
    
    _headerView = [[DresserHomePageHeaderView alloc] initWithFrame:CGRectMake(0, 0, _zoomImageView.frame.size.width, kImageOriginHight)];
    _headerView.alpha = 1;
    [_headerView.followButton addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
    _headerView.followButton.layer.masksToBounds = YES;
    _headerView.followButton.layer.cornerRadius = 3.f;
    [_zoomImageView addSubview:_headerView];
    
//
//    //-----
//    [self addDresserDataFooter];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.title = _myTitle;
    _detailViewController = nil;
    _dresserMianVewController = nil;
    [DresserInfoModel getDresserInfoWithSellerID:_sellerId];
    [DresserLiveModel getDresserDetailWithSellerID:_sellerId];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - notice
//获取美妆师信息
- (void)getDresserInfoNotice:(NSNotification *)notice;
{
    DresserInfoModel *infoModel = [[DresserInfoModel alloc] init];
    NSDictionary *dic = [notice userInfo];
    _headerView.nameLabel.text = dic[infoModel.dresserName];
    _headerView.introLabel.text = dic[infoModel.dresserInfo];
    _headerView.addressLabel.text = dic[infoModel.dresserLocation];
    _headerView.funsLabel.text = dic[infoModel.followNum];
    _headerView.publishLabel.text = dic[infoModel.itemsNum];
//    [_headerView.bgImageView sd_setImageWithURL:[NSURL URLWithString:dic[infoModel.shopBackground]]
//                               placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    
    LOVCircle *header = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, 75.f, 75.f)
                                           imageWithPath:dic[infoModel.headerPath]
                                        placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    [_headerView.iconView addSubview:header];
    
    int dresserlevel = [dic[infoModel.dresserLevel] intValue];
    if (0 < dresserlevel && dresserlevel<= 5) {
        _headerView.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"dresser_level%d", dresserlevel]];
    }else {
        _headerView.levelImageView.image = [UIImage imageNamed:@"dresser_level1"];
    }
    
    _isAttention = [dic[infoModel.attention] intValue];
    if (_isAttention == 0) {
        _headerView.followButton.enabled = YES;
        [_headerView.followButton setTitle:@"+ 关注" forState:UIControlStateNormal];
        _headerView.followButton.layer.masksToBounds = YES;
        _headerView.followButton.layer.cornerRadius = 3.f;
    }
    if (_isAttention == 1) {
        _headerView.followButton.enabled = NO;
        _headerView.followButton.backgroundColor = [UIColor colorRGBWithRed:255 green:255 blue:255 alpha:0.3];
        [_headerView.followButton setTitle:@"√ 已关注" forState:UIControlStateNormal];
        [_headerView.followButton setTitleColor:[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3] forState:UIControlStateNormal];    }
   
}

//美妆师直播列表
- (void)dresserLiveNotice:(NSNotification *)notice;
{
    _dataArray = [notice object];
    [self.tableView reloadData];
}

//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    if (!_nib) {
        _nib = [UINib nibWithNibName:@"DresserHomePageCell" bundle:nil];
        [tableView registerNib:_nib forCellReuseIdentifier:CellIdentifier];
    }
    DresserHomePageCell *cell = (DresserHomePageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    DresserLiveModel *liveModel = (DresserLiveModel *)_dataArray[indexPath.row];
    [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:liveModel.livePic] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    cell.headerImageView.backgroundColor = [UIColor lightGrayColor];
    cell.headerImageView.layer.masksToBounds = YES;
    cell.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.headerImageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cell.headerImageView.layer.borderWidth = 1.f;
    cell.headerImageView.layer.cornerRadius = 6.f;
    cell.titleLabel.text = liveModel.liveName;
    cell.addressLabel.text = liveModel.dresserLocation;
    cell.introLabel.text = liveModel.dresserIntro;
    cell.dateTimeLabel.text = liveModel.createTime;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_detailViewController == nil) {
//         __block DresserLiveModel *liveModel = (DresserLiveModel *)_dataArray[indexPath.row];
//        [DresserDetailModel getDresserDetailWithLiveID:liveModel.liveID
//                                                 block:^(NSDictionary *dic) {
////                                                     _dresserModel = (DresserHomePageModel *)_dataArray[indexPath.row];
//                                                     _detailViewController = [[DresserDetailViewController alloc] initWithNibName:@"DresserDetailViewController" bundle:nil];
//                                                     _detailViewController.artistID = _sellerId;
//                                                     _detailViewController.liveID = liveModel.liveID;
//                                                     _detailViewController.isAttention = [[dic objectForKey:@"is_attention"] intValue];
//                                                     _detailViewController.isHomePage = NO;
//                                                     
//                                                     DresserDetailModel *detailModel = [[DresserDetailModel alloc] init];
//                                                     _detailViewController.publishTitle = dic[detailModel.liveName];
//                                                     _detailViewController.publishContent = dic[detailModel.dresserIntro];
//                                                     _detailViewController.imageArray = dic[detailModel.photoArray];
//                                                     [_detailViewController getPhotoArray:dic[detailModel.photoArray]];
//                                                     [self.navigationController pushViewController:_detailViewController animated:YES];
//                                                 }];
//    }
    if (_dresserMianVewController == nil) {
        DresserLiveModel *model = _dataArray[indexPath.row];
        _dresserMianVewController = [[DresserMainViewController alloc] init];
        _dresserMianVewController.liveID = model.liveID;
        [self.navigationController pushViewController:_dresserMianVewController animated:YES];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -kImageOriginHight) {
        CGRect f = _zoomImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        _zoomImageView.frame = f;
    }
}


@end
