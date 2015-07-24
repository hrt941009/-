//
//  FollowDresserViewController.m
//  Love
//
//  Created by 李伟 on 14-10-16.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "FollowDresserViewController.h"
#import "BrandTableViewCell.h"

#import "FollowModel.h"
#import "FollowMeModel.h"

#import "LOVPageConfig.h"
#import "LOVCircle.h"

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface FollowDresserViewController ()<UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, FollowViewDelegate>
{
    int nextPage;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *tempDataArray;

@end

@implementation FollowDresserViewController

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
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    [_dataArray removeAllObjects];
    [FollowDresserModel getFollowDresserWithPage:kLovStartPage pageNum:kLovPageNumber];
}


#pragma mark -
#pragma mark - 刷新
- (void)addFollowDresserDataHeader
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
        [FollowDresserModel getFollowDresserWithPage:kLovStartPage pageNum:kLovPageNumber];
        
    }];
    
    //自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
}

- (void)addFollowDresserDataFooter
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf moreDresserDataAciton];
        
    }];
}
- (void)moreDresserDataAciton
{
    nextPage = nextPage + 1;
    [FollowDresserModel getFollowDresserWithPage:[NSString stringWithFormat:@"%d", nextPage] pageNum:kLovPageNumber];
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
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getDresserDataNotice:)
                                                 name:kFollowDresserNotificationName
                                               object:nil];
    
    self.view.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    
//    [FollowDresserModel getFollowDresserWithPage:kLovStartPage pageNum:kLovPageNumber];
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
        
//        if ([_dataArray count] == 0) {
//            [[NSNotificationCenter defaultCenter] addObserver:self
//                                                     selector:@selector(getDresserDataNotice:)
//                                                         name:kFollowDresserNotificationName
//                                                       object:nil];
//           
//            
//        }else{
//            [_tableView reloadData];
//        }
//        

//        [self addFollowDresserDataHeader];
        [self addFollowDresserDataFooter];
    }
}


#pragma mark - notice
- (void)getDresserDataNotice:(NSNotification *)notice
{
    _tempDataArray = [notice object];
    [_dataArray addObjectsFromArray:_tempDataArray];
    
    if ([notice.object count] == 0) {
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
        BrandTableViewCell *cell = (BrandTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BrandTableViewCell" owner:self options:nil];
            for (id object in  nib) {
                if ([object isKindOfClass:[BrandTableViewCell class]]) {
                    cell = (BrandTableViewCell *)object;
                }
            }
        }
        cell.delegate = self;
        cell.backgroundColor = [UIColor whiteColor];
        FollowDresserModel *model = (FollowDresserModel *)_dataArray[(NSUInteger)indexPath.row];
        cell.titleLabel.text = model.dresserName;
        cell.descTextView.text = model.dresserIntro;
        [cell.likeButton setTitle:model.numAtt forState:UIControlStateNormal];
        [cell.publishButton setTitle:model.numProduct forState:UIControlStateNormal];
        cell.addressLabel.text = model.dresesrLocation;
        
        cell.levelImageView.hidden = NO;
        int dresserLevel = [model.dresserStar intValue];
        if (dresserLevel > 0 && dresserLevel <= 5) {
            cell.levelImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"dresser_level%d", dresserLevel]];
        }else {
            cell.levelImageView.image = [UIImage imageNamed:@"dresser_level1"];
        }
        
        LOVCircle *iconView = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, cell.brandIconView.frame.size.width, cell.brandIconView.frame.size.height) imageWithPath:model.thumbPath placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        [cell.brandIconView addSubview:iconView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    return 120.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray count] > 0) {
        FollowDresserModel *model = (FollowDresserModel *)_dataArray[(NSUInteger)indexPath.row];
        [_delegate pushDresserViewControllerWithDresserID:model.sellerId Title:model.dresserName];
    }
}

#pragma mark - 取消关注delegate
- (void)cancelFollowButton:(UIButton *)button
{
    NSIndexPath *indexPath = nil;
    if (VersionNumber_iOS_8) {
        indexPath = [_tableView indexPathForCell:(BrandTableViewCell *)[[button superview] superview]];
        
    }else{
        indexPath = [_tableView indexPathForCell:(BrandTableViewCell *)[[[button superview] superview] superview]];
    }
    NSInteger row = [indexPath  row];
    FollowDresserModel *model = (FollowDresserModel *)_dataArray[(NSUInteger)row];
    [FollowMeModel doFollowWithId:model.sellerId type:FollowModelTypeWithDresser block:^(int code) {
        if (code == 0) {
            [self addFollowDresserDataHeader];
        }
    }];
}


@end
