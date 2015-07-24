//
//  SelectSubjectViewController.m
//  Love
//
//  Created by lee wei on 14-10-1.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SelectSubjectViewController.h"
#import "MJRefresh.h"
#import "MySubjectModel.h"

static NSString *const startPage = @"1";
static NSString *const pageNumber = @"10";

@interface SelectSubjectViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    int nextPage;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableViewCell *dataCell;
@property (nonatomic, strong) UITableViewCell *noDataCell;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SelectSubjectViewController

#pragma mark - loading
- (void)addSubjectDataHeader
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
        [MySubjectModel getMySubjectListWithUserID:mySelf.userId
                                              page:startPage
                                        pageNumber:pageNumber];
    }];
    
    //自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
}

- (void)addSubjectDataFooter
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf loadingSubjectData];
    }];
}

- (void)loadingSubjectData
{
    nextPage = nextPage + 1;
    [MySubjectModel getMySubjectListWithUserID:_userId
                                          page:[NSString stringWithFormat:@"%d", nextPage]
                                    pageNumber:pageNumber];
}


#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subjectListNotice:) name:kMySubjectNotificationName object:nil];
   
    //--正在直播
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notice
- (void)subjectListNotice:(NSNotification *)notice
{
    NSArray *array = [notice object];
    [_dataArray addObjectsFromArray:array];
    
    [_tableView reloadData];
    [_tableView headerEndRefreshing];
    [_tableView footerEndRefreshing];
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
    }else {
       return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    static NSString *noDataCellIdentifier = @"noDataCellIdentifier";
    
    if ([_dataArray count] > 0) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:noDataCellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:noDataCellIdentifier];
        }
        
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = MyLocalizedString(@"还没有内容");
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    }
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
