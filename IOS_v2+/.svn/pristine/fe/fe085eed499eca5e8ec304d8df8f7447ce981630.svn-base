//
//  ShareProductViewController.m
//  Love
//
//  Created by use on 15-3-18.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ShareProductViewController.h"
#import "ShareProductTableViewCell.h"

#import "ShareListModel.h"


#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface ShareProductViewController ()<UITableViewDataSource,UITableViewDelegate, addCartActionDelegate>
{
    int nextPage;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UINib *nib;
@end

@implementation ShareProductViewController

//加入购物车
#pragma mark -- addCartActionDelegate
- (void)shareProductAddCartButton:(UIButton *)bnt{
    NSIndexPath *myIndexPath = [_tableView indexPathForCell:(ShareProductTableViewCell *)[[bnt superview] superview]];
    NSLog(@"%ld",[myIndexPath row]);
    ShareListModel *model = (ShareListModel *)_dataArray[[myIndexPath row]];
    if ([_delegate respondsToSelector:@selector(pushSKUViewController:ProductId:ProductIntro:)]) {
        [_delegate pushSKUViewControllerWithProductId:model.productId ProductIntro:model.productName];
    }
}

- (instancetype)init{
    self = [super init];
    if (self) {
        nextPage = 1;
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getProductListData:) name:kProductListNotificationName
                                               object:nil];
    
}

- (void)addHeaderRefresh{
    // 添加下拉刷新头部控件
    __unsafe_unretained typeof(self) mySelf = self;
    [self.tableView addHeaderWithCallback:^{
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        [ShareListModel getProductListWithUserId:mySelf.userId page:@"1" pageNumber:@"10"];
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
    [ShareListModel getProductListWithUserId:_userId page:[NSString stringWithFormat:@"%d",nextPage] pageNumber:@"10"];
}


- (void)getProductListData:(NSNotification *)noti{
    [_dataArray addObjectsFromArray:noti.object];
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
    [self.tableView reloadData];
}

- (void)reloadProductListData{
    for (id view in [self.view subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
    
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
        if (!_nib) {
            _nib = [UINib nibWithNibName:@"ShareProductTableViewCell" bundle:nil];
            [tableView registerNib:_nib forCellReuseIdentifier:cellID];
        }
        ShareProductTableViewCell *cell = (ShareProductTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        cell.delegate = self;
            ShareListModel *model = (ShareListModel *)_dataArray[indexPath.row];
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        cell.tagName.text = [NSString stringWithFormat:@"# %@",model.tagName];
        cell.productName.text = model.productName;
        cell.introLabel.text = model.intro;
        cell.priceLabel.text = model.price;
        cell.priceLabel.adjustsFontSizeToFitWidth = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
            cell.textLabel.text = @"还没有数据";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    return nil;
}

#pragma maek -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShareListModel *model = _dataArray[indexPath.row];
    NSString *productID = model.productId;
    NSString *productName = model.productName;
    if ([_delegate respondsToSelector:@selector(pushViewDelegateAndProductId:productName:)]) {
        [_delegate pushViewDelegateAndProductId:productID productName:productName];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _tableView) {
        if ([_delegate respondsToSelector:@selector(changeFrame:)]) {
            [_delegate changeFrame:_tableView];
        }
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
