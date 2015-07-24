//
//  FollowSubjectViewController.m
//  Love
//
//  Created by lee wei on 14-9-22.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "FollowSubjectViewController.h"
#import "FollowSubjectTableViewCell.h"

#import "FollowModel.h"
#import "FollowMeModel.h"

#import "LOVPageConfig.h"
#import "LOVCircle.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface FollowSubjectViewController ()<UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, FollowViewDelegate>
{
    int nextPage;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *tempDataArray;

@end

@implementation FollowSubjectViewController

- (void)setFollowView
{
    for (id view in [self.view subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    //--正在直播
    CGRect tvRect = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    
    //-------------
}


#pragma mark -
#pragma mark - 刷新
- (void)addFollowSubjectDataHeader
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加下拉刷新头部控件
    [self.tableView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        //----- get data
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        
        // 增加数据
        [FollowSubjectModel getFollowSubjectWithP:kLovStartPage pnum:kLovPageNumber];
        
//        [mySelf.tableView headerEndRefreshing];
    }];
    
    //自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
}

- (void)addFollowSubjectDataFooter
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
    [FollowSubjectModel getFollowSubjectWithP:[NSString stringWithFormat:@"%d", nextPage] pnum:kLovPageNumber];

    [_tableView reloadData];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getSubjectDataNotice:)
                                                 name:kFollowSubjectNotificationName
                                               object:nil];
    
    self.view.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - connect
- (void)isConnect:(BOOL)connect
{
    
    if (connect) {
        [self setFollowView];
        
//        if ([_dataArray count] > 0) {
//            [_tableView reloadData];
//        } else{
//            //[FollowSubjectModel getFollowSubjectWithP:kLovStartPage pnum:kLovPageNumber];
//
//            
//        }
        
        
        [self addFollowSubjectDataHeader];
        [self addFollowSubjectDataFooter];
    }
}


#pragma mark - notice
- (void)getSubjectDataNotice:(NSNotification *)notice
{
    _tempDataArray = [notice object];
    [_dataArray addObjectsFromArray:_tempDataArray];
    
    if ([_dataArray count] == 0) {
        [self.tableView setFooterHidden:YES];
    }
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
    
    
    [_tableView reloadData];

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
    static NSString *CellIdentifier = @"Cell";
    if ([_dataArray count] > 0) {
        FollowSubjectTableViewCell *cell = (FollowSubjectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FollowSubjectTableViewCell" owner:self options:nil];
            for (id object in  nib) {
                if ([object isKindOfClass:[FollowSubjectTableViewCell class]]) {
                    cell = (FollowSubjectTableViewCell *)object;
                }
            }
        }
        
        cell.delegate = self;
        
        FollowSubjectModel *model = (FollowSubjectModel *)_dataArray[(NSUInteger)indexPath.row];
        cell.titleLabel.text = model.albumName;
        cell.descTextView.text = model.subjectDesc;
        [cell.likeButton setTitle:model.interestNum forState:UIControlStateNormal];
        [cell.commentButton setTitle:model.reviewNum forState:UIControlStateNormal];
        
        LOVCircle *iconView = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, cell.subjectIconView.frame.size.width, cell.subjectIconView.frame.size.height) imageWithPath:model.thumbPath placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        [cell.subjectIconView addSubview:iconView];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"noDataCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"noDataCell"];
        }
        cell.detailTextLabel.text = MyLocalizedString(@"您还没有关注");
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }

    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowSubjectModel *model = (FollowSubjectModel *)_dataArray[(NSUInteger)indexPath.row];
//    [_delegate pushSubjectViewControllerWithTitle:model.albumName subjectId:model.sid subjectDesc:model.subjectDesc thumPath:model.thumbPath];
}

#pragma mark - 取消专辑关注
- (void)cancelFollowButton:(UIButton *)button
{
    NSIndexPath *indexPath = nil;
    if (VersionNumber_iOS_8) {
        indexPath = [_tableView indexPathForCell:(FollowSubjectTableViewCell *)[[button superview] superview]];
    }else{
        indexPath = [_tableView indexPathForCell:(FollowSubjectTableViewCell *)[[[button superview] superview] superview]];
    }
    NSInteger row = [indexPath  row];
    FollowSubjectModel *model = (FollowSubjectModel *)_dataArray[(NSUInteger)row];
    [FollowMeModel doFollowWithId:model.sid type:FollowModelTypeWithSubject block:^(int code) {
        if (code == 0) {
            [self addFollowSubjectDataHeader];
        }
    }];
}


@end
