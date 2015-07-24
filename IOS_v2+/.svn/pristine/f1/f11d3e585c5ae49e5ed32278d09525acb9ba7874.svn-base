//
//  HomeTagViewController.m
//  Love
//
//  Created by use on 15-3-17.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "HomeTagViewController.h"
#import "UserHomeViewController.h"
#import "ProductDetailViewController.h"

#import "ShareLabelListModel.h"

#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface HomeTagViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    int nextPage;
}
@property (nonatomic, strong) UserHomeViewController *userHomeViewController;
@property (nonatomic, strong) ProductDetailViewController *productDetailVC;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HomeTagViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        nextPage = 1;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _productDetailVC = nil;
    _userHomeViewController = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = _titleName;
    if (VersionNumber_iOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;//view在导航栏下方
    }
    
    _dataArray = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareLabelListData:) name:kShareLabelListNotificationName object:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.allowsSelection = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
    
}

- (void)shareLabelListData:(NSNotification *)noti{
    
    [_dataArray addObjectsFromArray:noti.object];
    
    [self.tableView reloadData];
    
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

- (void)addHeaderRefresh{
    // 添加下拉刷新头部控件
    __unsafe_unretained typeof(self) mySelf = self;
    [self.tableView addHeaderWithCallback:^{
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        [ShareLabelListModel getShareLabelListWithTagId:mySelf.labelId page:@"1" pageNumber:@"10"];
    }];
    
    [self.tableView headerBeginRefreshing];
}

- (void)addFooterRefresh{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf loadingDataAction];
    }];
}

- (void)loadingDataAction{
    nextPage = nextPage + 1;
    [ShareLabelListModel getShareLabelListWithTagId:_labelId page:[NSString stringWithFormat:@"%d",nextPage] pageNumber:@"10"];
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_dataArray count] > 0) {
        return [_dataArray count];
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    static NSString *cellID1 = @"cellID1";
    if ([_dataArray count] > 0) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            //        cell.textLabel.text = @"dahsjdhs";
        }
        // 清除cell上面的控件
        for (UIView *theView in [cell.contentView subviews]) {
            [theView removeFromSuperview];
        }
        ShareLabelListModel *model = (ShareLabelListModel *)_dataArray[indexPath.row];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 130, 103)];
        imageView.layer.masksToBounds = YES;
        imageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        imageView.layer.borderWidth = 1.f;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius = 6;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbPath] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        [cell.contentView addSubview:imageView];
        
        UIImageView *likeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 10, 10)];
        likeImageView.image = [UIImage imageNamed:@"icon_love"];
        [imageView addSubview:likeImageView];
        
        UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 30, 15)];
        numLabel.font = [UIFont systemFontOfSize:13.f];
        numLabel.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.6];
        numLabel.text = model.love;
        [imageView addSubview:numLabel];
        
        UIImageView *sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 15, 15, 15)];
        if ([model.sex isEqual:@"0"]) {
            sexImageView.image = [UIImage imageNamed:@"icon_sex_women"];
        }else{
            sexImageView.image = [UIImage imageNamed:@"icon_sex_man"];
        }
        [cell.contentView addSubview:sexImageView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 8, kScreenWidth - 175, 30)];
        // nameLabel.text = @"用户名字";
        nameLabel.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.8];
        nameLabel.font = [UIFont systemFontOfSize:18.f];
        nameLabel.text = model.name;
        [cell.contentView addSubview:nameLabel];
        
        UILabel *productName = [[UILabel alloc] initWithFrame:CGRectMake(150, 33, kScreenWidth - 160, 30)];
        // productName.text = @"分享商品名称";
        productName.text = model.share_title;
        productName.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.7];
        productName.font = [UIFont systemFontOfSize:15.f];
        [cell.contentView addSubview:productName];
        
        UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 60, kScreenWidth - 160, 60)];
        introLabel.font = [UIFont systemFontOfSize:13.f];
        introLabel.numberOfLines = 0;
        introLabel.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.6];
        // introLabel.text = @"看了好多东西，觉得隐藏多余的分割线，基本两个各思路，一个是通过代码，一个是代码配合背景图片，第一种比较常见，在网上到处都是，我这也是抄别人的。主要就是说自己定义一个view，弄成透明的，然后盖在TableView的上部和下部，这样就“隐藏”了。";
        introLabel.text = model.share_content;
        CGSize size = [model.share_content boundingRectWithSize:CGSizeMake(introLabel.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13.f]} context:nil].size;
        CGAffineTransform transform = introLabel.transform;
        introLabel.transform = CGAffineTransformIdentity;
        CGRect frame = introLabel.frame;
        frame.size.height = size.height;
        if (frame.size.height > 60) {
            introLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 60);
        }else{
            introLabel.frame = frame;
        }
        // introLabel.frame = frame;
        introLabel.transform = transform;
        [cell.contentView addSubview:introLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 124, kScreenWidth - 25, 1)];
        lineView.backgroundColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.1];
        [cell.contentView addSubview:lineView];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        }
        cell.textLabel.text = @"还没有数据";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
    
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShareLabelListModel *myModel = (ShareLabelListModel *)_dataArray[indexPath.row];
    
    if (_productDetailVC == nil) {
        _productDetailVC = [[ProductDetailViewController alloc] init];
        _productDetailVC.shareId = myModel.shareId;
        _productDetailVC.myTitle = myModel.share_title;
        [self.navigationController pushViewController:_productDetailVC animated:YES];
    }
    
    
}
@end
