//
//  CountryListViewController.m
//  Love
//
//  Created by lee wei on 14/11/25.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "CountryListViewController.h"
#import "CountryModel.h"
#import "UIImageView+WebCache.h"

@interface CountryListViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *indexArray;
@property (nonatomic, strong) CountryModel *countryModel;

@end

@implementation CountryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CountryModel getAllCountry];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(allCountryNotice:) name:kAllCountryNotificationName object:nil];
    
    _indexArray = [[NSMutableArray alloc] init];
    for (char c = 'A'; c <= 'Z'; c++) {
        [_indexArray addObject:[NSString stringWithFormat:@"%c", c]];
    }
    
    //--正在直播
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f - 44.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notice
- (void)allCountryNotice:(NSNotification *)notice
{
    _dataArray = [notice object];
    [_tableView reloadData];
}

#pragma mark - Table view data source
//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _indexArray;
}

//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count = 0;
    
    NSLog(@"--- %@ | %ld",title,(unsigned long)index);
    for(NSString *character in _indexArray)
    {
        if([character isEqualToString:title])
        {
            return count;
        }
        count ++;
    }
    return 0;
}

/**
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _indexArray[section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_indexArray count];
}
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    for (UIView *vi in cell.contentView.subviews) {
        [vi removeFromSuperview];
    }
    _countryModel = (CountryModel *)_dataArray[indexPath.row];
    
//    cell.textLabel.text = _countryModel.countryName;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 30, 30)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_countryModel.flagPicPath] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    [cell.contentView addSubview:imageView];
    
    UILabel *countyLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 5, 250, 30)];
    countyLabel.text = _countryModel.countryName;
    [cell.contentView addSubview:countyLabel];
    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_countryModel.flagPicPath] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _countryModel = (CountryModel *)_dataArray[indexPath.row];
    [_delegate getCountryName:_countryModel.countryName andCode:_countryModel.code];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
