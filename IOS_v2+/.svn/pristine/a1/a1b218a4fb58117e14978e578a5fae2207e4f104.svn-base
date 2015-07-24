//
//  MySubjectFunsViewController.m
//  Love
//
//  Created by lee wei on 14-10-3.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MySubjectFunsViewController.h"
#import "UIImageView+WebCache.h"

@interface MySubjectFunsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *tempDataArray;

@end

@implementation MySubjectFunsViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = MyLocalizedString(@"粉丝");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    _dataArray = [[NSMutableArray alloc] init];
    
    //----
    
    
    //-----
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  2;//[_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:nil]
                      placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    cell.textLabel.text = @"ccc";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ | %@", @"专辑(19)", @"粉丝(20)"];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11.f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 32.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *moreDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    moreDataButton.backgroundColor = [UIColor clearColor];
    if ([_tempDataArray count] > 0) {
        [moreDataButton setTitle:MyLocalizedString(@"查看更多") forState:UIControlStateNormal];
    }else{
        [moreDataButton setTitle:MyLocalizedString(@"已是最后一条") forState:UIControlStateNormal];
    }
    
    [moreDataButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    moreDataButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    moreDataButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [moreDataButton addTarget:self action:@selector(moreMyFunsDataAciton) forControlEvents:UIControlEventTouchUpInside];
    if ([_dataArray count] > 0) {
        return moreDataButton;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - button action
- (void)moreMyFunsDataAciton
{
    //    nextPage = nextPage + 1;
    //    [SubjectDetailModel getSubjectAlbum:_subjectId p:[NSString stringWithFormat:@"%d", nextPage] pnum:pageNumber];
    //    [_tableView reloadData];
}


@end
