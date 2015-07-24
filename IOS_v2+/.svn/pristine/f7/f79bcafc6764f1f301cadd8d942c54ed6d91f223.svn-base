//
//  FollowTagViewController.m
//  Love
//
//  Created by use on 15-4-6.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "FollowTagViewController.h"
#import "HomeSubjectCollectionCell.h"
#import "FollowTagDetailViewController.h"

#import "SubjectModel.h"
#import "FollowMeModel.h"
#import "SVProgressHUD.h"

#import "UIImageView+WebCache.h"
#import "UIFont+boldFontOtherFont.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
static NSString * const kCellReuseIdentifier = @"kHomeSubjectCollectionViewCell";

@interface FollowTagViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,HomeSubjectCollectionCellDelegate>
{
    int nextPage;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) SubjectModel *subjectModel;
@property (nonatomic, strong) FollowTagDetailViewController *tagDetailViewController;
@end

@implementation FollowTagViewController
#pragma mark --HomeSubjectCollectionCellDelegate
- (void)getClickedButton:(UIButton *)sender{
    NSIndexPath *indexPath = [_collectionView indexPathForCell:(UICollectionViewCell *)[sender superview]];
    NSLog(@"indexPath.row=%ld",(long)indexPath.row);
    _subjectModel = _dataArray[indexPath.row];
        NSLog(@"喜欢");
    [FollowMeModel doFollowWithId:_subjectModel.tagid type:9 block:^(int code) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"关注成功"];
            _subjectModel.isAttent = @"1";
            _subjectModel.love = [NSString stringWithFormat:@"%d",[_subjectModel.love intValue] + 1];
        }else{
            [SVProgressHUD showErrorWithStatus:@"取消关注"];
            _subjectModel.isAttent = @"0";
            _subjectModel.love = [NSString stringWithFormat:@"%d",[_subjectModel.love intValue] - 1];
        }
        [self setFollowView];
        [SVProgressHUD showErrorWithStatus:@"已取消关注"];
    }];

}


- (void)setFollowView{
    for (id view in [self.view subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((kScreenWidth - 20.f)/2, (kScreenWidth - 20.f)/2 - 24.f)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5.f, 10.f, CGRectGetWidth(self.view.frame) - 10.f, self.view.frame.size.height - 15.f)  collectionViewLayout:flowLayout];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.alpha = 1;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HomeSubjectCollectionCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
    [_dataArray removeAllObjects];
    [SubjectModel followTagWithPage:@"1" Pnum:@"10"];
    [self addFollowSubjectDataFooter];
}

#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeSubjectCollectionCell *cell = (HomeSubjectCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    _subjectModel = (SubjectModel *)_dataArray[indexPath.row];
    
    NSString *urlString = _subjectModel.thumbPath;
    
    [cell.subjectImageView sd_setImageWithURL:[NSURL URLWithString:urlString]
                             placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    cell.likeNumLable.text = _subjectModel.love;
    cell.subjectTitleLabel.text = [NSString stringWithFormat:@"#%@",_subjectModel.name];
    
    [cell bringSubviewToFront:cell.followBackButton];
    [cell bringSubviewToFront:cell.followIconImage];
    if ([_subjectModel.isAttent isEqual:@"0"]) {
        cell.followIconImage.image = [UIImage imageNamed:@"icon_followtag_unselected"];
    }else{
        cell.followIconImage.image = [UIImage imageNamed:@"icon_followtag_selected"];
    }

    
    return cell;

}
#pragma mark --UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _subjectModel = _dataArray[indexPath.row];
    if ([_delegate respondsToSelector:@selector(pushFollowTagDetailDelegateWithTagId:tagName:)]) {
        [_delegate pushFollowTagDetailDelegateWithTagId:_subjectModel.tagid tagName:_subjectModel.name];
    }
}


#pragma mark - connect
- (void)isConnect:(BOOL)connect
{
    
    if (connect) {
        nextPage = 1;
        [self setFollowView];
        
//        [self addFollowSubjectDataHeader];
        [self addFollowSubjectDataFooter];
    }
}
- (void)addFollowSubjectDataHeader{
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
//        [FollowSubjectModel getFollowSubjectWithP:kLovStartPage pnum:kLovPageNumber];
        [SubjectModel followTagWithPage:@"1" Pnum:@"10"];
        //        [mySelf.tableView headerEndRefreshing];
    }];
    
    //自动刷新(一进入程序就下拉刷新)
    [self.collectionView headerBeginRefreshing];
}

- (void)addFollowSubjectDataFooter{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf moreSubjectDataAciton];
        
    }];

}

- (void)moreSubjectDataAciton
{
    nextPage = nextPage + 1;
//    [SubjectModel getFollowSubjectWithP:[NSString stringWithFormat:@"%d", nextPage] pnum:kLovPageNumber];
    [SubjectModel followTagWithPage:[NSString stringWithFormat:@"%d",nextPage] Pnum:@"10"];
    
    [_collectionView reloadData];
}

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        
        nextPage = 1;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    _tagDetailViewController = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getFollowTagListData:)
                                                 name:kFollowTagNotificationName
                                               object:nil];
//    [SubjectModel followTagWithPage:@"1" Pnum:@"10"];
}

- (void)getFollowTagListData:(NSNotification *)noti{
    [_dataArray addObjectsFromArray:noti.object];
    if ([_dataArray count] == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        label.text = @"还没有关注任何标签";
        label.font = [UIFont lovFontWitnSize:15 IsBold:NO];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }else{
        [self.collectionView reloadData];
//        if ([_dataArray count] > 0) {
//            [_collectionView setFooterHidden:YES];
//        }
//        [self.collectionView headerEndRefreshing];
        [self.collectionView footerEndRefreshing];
    }
    if ([noti.object count] == 0) {
        [self.collectionView removeFooter];
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
