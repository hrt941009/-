//
//  HomeSubjectViewController.m
//  Love
//
//  Created by lee wei on 14-9-21.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "HomeSubjectViewController.h"
#import "SubjectViewController.h"
#import "HomeSubjectCollectionCell.h"
#import "HomeTagViewController.h"
#import "LoginViewController.h"

#import "UIImageView+WebCache.h"
#import "SubjectModel.h"
#import "UserManager.h"
#import "FollowMeModel.h"

#import "SVProgressHUD.h"

#import "LOVPageConfig.h"
#import "LOVLoadingView.h"

static NSString * const kCellReuseIdentifier = @"kHomeSubjectCollectionViewCell";


@interface HomeSubjectViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, HomeSubjectCollectionCellDelegate>
{
    int nextPage;
    CGPoint myContentOffset;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *loadingButton;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SubjectModel *subjectModel;
@property (nonatomic, strong) LOVLoadingView *loadingView;
@property (nonatomic, strong) HomeTagViewController *homeTagViewController;

@end

@implementation HomeSubjectViewController

#pragma mark --HomeSubjectCollectionCellDelegate
- (void)getClickedButton:(UIButton *)sender{
    myContentOffset = _collectionView.contentOffset;
    NSIndexPath *indexPath = [_collectionView indexPathForCell:(UICollectionViewCell *)[sender superview]];
    NSLog(@"indexPath.row=%ld",(long)indexPath.row);
    _subjectModel = _dataArray[indexPath.row];
    NSString *sig = [UserManager readSig];
    if (sig.length > 0) {
        [FollowMeModel doFollowWithId:_subjectModel.tagid type:9 block:^(int code) {
            if (code == 1) {
                [SVProgressHUD showSuccessWithStatus:@"关注成功"];
                _subjectModel.isAttent = @"1";
                _subjectModel.love = [NSString stringWithFormat:@"%d",[_subjectModel.love intValue] + 1];
                [SVProgressHUD showSuccessWithStatus:@"已关注"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"取消关注"];
                _subjectModel.isAttent = @"0";
                _subjectModel.love = [NSString stringWithFormat:@"%d",[_subjectModel.love intValue] - 1];
                [SVProgressHUD showErrorWithStatus:@"已取消关注"];
            }
            [self.collectionView reloadData];
        }];
        
        
        
    }else{
        if ([_delegate respondsToSelector:@selector(pushLogin)]) {
            [_delegate pushLogin];
        }
    }
}

#pragma mark - 刷新
- (void)addSubjectDataHeader
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
        [SubjectModel getSubjectWithP:kLovStartPage pnum:kLovPageNumber];

    }];
    
    //自动刷新(一进入程序就下拉刷新)
    [self.collectionView headerBeginRefreshing];
}

- (void)addSubjectDataFooter
{
    myContentOffset = _collectionView.contentOffset;
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf loadingDataAction];

    }];
}

- (void)loadingDataAction
{
    nextPage = nextPage + 1;
    //    int num = [pageNumber intValue];
    [SubjectModel getSubjectWithP:[NSString stringWithFormat:@"%d", nextPage] pnum:kLovPageNumber];
}


#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
        nextPage = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //---------
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(homeSubjectDataNotice:)
                                                 name:kSubjectHomeNotificationName object:nil];
 
    [self addSubjectDataHeader];
    [self addSubjectDataFooter];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    _homeTagViewController = nil;
    
    [_collectionView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kSubjectHomeNotificationName object:nil];
    // Dispose of any resources that can be recreated.
}

- (void)reloadHomeSubjectData
{
    for (id view in [self.view subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    //--
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((kScreenWidth - 20.f)/2, (kScreenWidth - 20.f)/2 - 24.f)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5.f, 10.f, CGRectGetWidth(self.view.frame) - 10.f, self.view.frame.size.height - 12)
                                         collectionViewLayout:flowLayout];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.contentOffset = myContentOffset;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HomeSubjectCollectionCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];

    //----- get data
    if ([self.dataArray count] > 0) {
        [self.dataArray removeAllObjects];
        
        [self.collectionView reloadData];
    }else{
        _loadingView = [[LOVLoadingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40.f)];
        _loadingView.alpha = 1.f;
        [self.view addSubview:_loadingView];
    }
    
    // 增加数据
    [SubjectModel getSubjectWithP:kLovStartPage pnum:kLovPageNumber];
    [self addSubjectDataFooter];
}

#pragma mark -
#pragma mark - notice

- (void)homeSubjectDataNotice:(NSNotification *)notice
{
    NSArray *arr = [notice object];
    [_dataArray addObjectsFromArray:[notice object]];

    _loadingView.alpha = 0;
    [_loadingView.activityView stopAnimating];
    
    [_collectionView reloadData];
    _collectionView.contentOffset = myContentOffset;
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
    if ([arr count] == 0) {
        [self.collectionView removeFooter];
    }
}

#pragma mark - collection view data source methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_dataArray count] > 0) {
        return [_dataArray count];
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeSubjectCollectionCell *cell = (HomeSubjectCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    
    _subjectModel = (SubjectModel *)_dataArray[indexPath.row];
    
    cell.delegate = self;
    
    NSString *urlString = _subjectModel.thumbPath;
    
    [cell.subjectImageView sd_setImageWithURL:[NSURL URLWithString:urlString]
                             placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    cell.likeNumLable.text = _subjectModel.love;
    cell.subjectTitleLabel.text = [NSString stringWithFormat:@"#%@",_subjectModel.name];
    [cell bringSubviewToFront:cell.followBackButton];
    [cell bringSubviewToFront:cell.followIconImage];
    if ([_subjectModel.isAttent isEqual:@"1"]) {
        cell.followIconImage.image = [UIImage imageNamed:@"icon_followtag_selected"];
    }else{
        cell.followIconImage.image = [UIImage imageNamed:@"icon_followtag_unselected"];
    }
    return cell;
    
}

#pragma mark - delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _subjectModel = (SubjectModel *)_dataArray[indexPath.row];
    
    [_delegate pushTagViewControllerWithTitle:_subjectModel.name labelId:_subjectModel.tagid];
    
}


@end
