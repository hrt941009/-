//
//  MyLikeViewController.m
//  Love
//
//  Created by lee wei on 14-10-6.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MyLikeViewController.h"
#import "MyLikeCell.h"
#import "MyCartViewController.h"
#import "CommissionCommodityViewController.h"

#import "MyLikeModel.h"
#import "FollowMeModel.h"
#import "CommissionDetailModel.h"

#import "UIImageView+WebCache.h"
#import "UIScrollView+MJRefresh.h"
NSString * const kPage = @"1";
NSString * const kPageNum = @"10";
@interface MyLikeViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>
{
    int nextPage;
}
@property (nonatomic, strong) UIBarButtonItem *editBarButton;
@property (nonatomic, strong) UIBarButtonItem *cancelBarButton;
@property (nonatomic, strong) UIBarButtonItem *deleteBarButton;
@property (nonatomic, strong) UIBarButtonItem *backBarButton;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UINib *nib;

@property (nonatomic, strong) CommissionCommodityViewController *commodityViewController;
@end

@implementation MyLikeViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = MyLocalizedString(@"我的喜欢");
        nextPage = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myLikeData:) name:kMyLikeNotificationName object:nil];
    
    
    //--
    _dataArray = [[NSMutableArray alloc] init];
    //--
    self.view.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    
    if (VersionNumber_iOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;//view在导航栏下方
    }
    
    //-----
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 29, 20.f);
    backButton.backgroundColor = [UIColor clearColor];
    [backButton setBackgroundImage:[UIImage imageNamed:@"nav-back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0, 0, 29, 20.f);
    cartButton.backgroundColor = [UIColor clearColor];
    [cartButton setBackgroundImage:[UIImage imageNamed:@"navBar_cart"] forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(cartButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    _backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    _editBarButton = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    
    self.navigationItem.rightBarButtonItem = _editBarButton;
    /*
    _deleteBarButton = [[UIBarButtonItem alloc] initWithTitle:MyLocalizedString(@"Delete")
                                                        style:UIBarButtonItemStyleBordered
                                                       target:self
                                                       action:@selector(deleteButtonAction)];
    
    //
    _editBarButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑"
                                                      style:UIBarButtonItemStyleBordered
                                                     target:self
                                                     action:@selector(editCartAction)];
    
    
    _cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                        style:UIBarButtonItemStyleBordered
                                                       target:self
                                                       action:@selector(cancelButtonAction)];
    
    */
    if (VersionNumber_iOS_7) {
        _deleteBarButton.tintColor = [UIColor whiteColor];
        _editBarButton.tintColor = [UIColor whiteColor];
        _cancelBarButton.tintColor = [UIColor whiteColor];
    }
    
    //
//    [self updateButtonsToMatchTableState];
    
    //
    
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsSelection = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    [self addHeaderRefresh];
    [self addFooterRefresh];
    
}

- (void)addHeaderRefresh{
    // 添加下拉刷新头部控件
    __unsafe_unretained typeof(self) mySelf = self;
    [self.tableView addHeaderWithCallback:^{
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        [MyLikeModel getMyLikeDataPage:kPage andPageNum:kPageNum];
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
    [MyLikeModel getMyLikeDataPage:[NSString stringWithFormat:@"%d",nextPage] andPageNum:kPageNum];
}

- (void)myLikeData:(NSNotification*)noti{
    [_dataArray addObjectsFromArray:noti.object];
    
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArray.count > 0) {
        return [_dataArray count];
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"kMyLikeCellIdentifier";
    static NSString *CellIdentifier2 = @"CellIdentifier2";
    if (_dataArray.count > 0){
        if (!_nib) {
            _nib = [UINib nibWithNibName:@"MyLikeCell" bundle:nil];
            [tableView registerNib:_nib forCellReuseIdentifier:CellIdentifier];
        }
        MyLikeCell *cell = (MyLikeCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        MyLikeModel *model = (MyLikeModel*)_dataArray[indexPath.row];
    
        cell.titleLabel.text = model.name;
        cell.descLabel.text = model.commDescription;
//    cell.stateLabel.text = model.my_price;
    
        NSString *imgUrl = model.thumb;
        [cell.previewImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier2];
        }
        cell.detailTextLabel.text = MyLocalizedString(@"您还未添加你喜欢的商品");
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyLikeModel *model = (MyLikeModel*)_dataArray[indexPath.row];
    [FollowMeModel doFollowWithId:model.commodityId type:1 block:^(int code) {
        [self.tableView headerBeginRefreshing];
    }];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    _commodityViewController = nil;
    
    [_tableView reloadData];
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.f;
}


//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Update the delete button's title based on how many items are selected.
//    [self updateDeleteButtonTitle];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Update the delete button's title based on how many items are selected.
//    [self updateButtonsToMatchTableState];
    MyLikeModel *model = (MyLikeModel *)_dataArray[indexPath.row];
    NSString *item = model.commodityId;//item=102
    [CommissionDetailModel getDetailWithItem:item block:^(NSArray *array) {
        if (_commodityViewController == nil) {
            _commodityViewController  = [[CommissionCommodityViewController alloc] initWithNibName:@"CommissionCommodity" bundle:nil];
            
            CommissionDetailModel *model = (CommissionDetailModel *)[array lastObject];
            _commodityViewController.imageArray = model.cImageArray;
            _commodityViewController.cid = model.cid;
            _commodityViewController.brandId = model.brandId;
            _commodityViewController.brandName = model.brandName;
            _commodityViewController.itemStr = item;
            _commodityViewController.titleStr = model.cName;
            _commodityViewController.saleStr = model.sales;
            _commodityViewController.isNextPriceStr = model.hasNextPrice;
            _commodityViewController.nextPriceStr = model.nextPrice;
            _commodityViewController.isCouponStr = model.hasCoupon;
            _commodityViewController.subjectStr = model.save;
            _commodityViewController.commentStr = model.discuss;
            _commodityViewController.likeStr = model.love;
            _commodityViewController.originalPriceStr = model.originalPrice;
            _commodityViewController.priceStr = model.price;
            _commodityViewController.discountStr = model.discount;
            _commodityViewController.isDiscountStr = model.hasDiscount;
            _commodityViewController.intro = model.intro;
            _commodityViewController.stock = model.commissionStock;
            
            //[_commodityViewController getCommissionPhoto:model.cImageArray];
            
            [self.navigationController pushViewController:_commodityViewController animated:YES];
        }
        
    }];
    
}

#pragma mark - MyCartTableViewCell Delegate
- (void)buyNumber:(int)number
{
    NSLog(@"------- number = %d", number);
}

#pragma mark - button action
- (void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cartButtonAction
{
    MyCartViewController *myCartVC = [[MyCartViewController alloc] init];
    
    [self.navigationController pushViewController:myCartVC animated:YES];
    
}

- (void)cancelButtonAction
{
    _tableView.allowsMultipleSelectionDuringEditing = NO;
    [self.tableView setEditing:NO animated:YES];
    [self updateButtonsToMatchTableState];
}

- (void)editCartAction
{
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.tableView setEditing:YES animated:YES];
    
    [self updateButtonsToMatchTableState];
}


- (void)buyAction
{
    NSLog(@"-------- buy ---------");
}

- (void)deleteButtonAction
{
    // Open a dialog with just an OK button.
	NSString *actionTitle;
    if (([[self.tableView indexPathsForSelectedRows] count] == 1)) {
        actionTitle = NSLocalizedString(@"Are you sure you want to remove this item?", @"");
    }
    else
    {
        actionTitle = NSLocalizedString(@"Are you sure you want to remove these items?", @"");
    }
    
    NSString *cancelTitle = NSLocalizedString(@"Cancel", @"Cancel title for item removal action");
    NSString *okTitle = NSLocalizedString(@"OK", @"OK title for item removal action");
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:actionTitle
                                                             delegate:self
                                                    cancelButtonTitle:cancelTitle
                                               destructiveButtonTitle:okTitle
                                                    otherButtonTitles:nil];
    
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    // Show from our table view (pops up in the middle of the table).
	[actionSheet showInView:self.view];
}


#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// The user tapped one of the OK/Cancel buttons.
	if (buttonIndex == 0)
	{
		// Delete what the user selected.
        NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
        BOOL deleteSpecificRows = selectedRows.count > 0;
        if (deleteSpecificRows)
        {
            // Build an NSIndexSet of all the objects to delete, so they can all be removed at once.
            NSMutableIndexSet *indicesOfItemsToDelete = [NSMutableIndexSet new];
            for (NSIndexPath *selectionIndex in selectedRows)
            {
                [indicesOfItemsToDelete addIndex:selectionIndex.row];
            }
            // Delete the objects from our data model.
            [self.dataArray removeObjectsAtIndexes:indicesOfItemsToDelete];
            
            // Tell the tableView that we deleted the objects
            [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else
        {
            // Delete everything, delete the objects from our data model.
            [self.dataArray removeAllObjects];
            
            // Tell the tableView that we deleted the objects.
            // Because we are deleting all the rows, just reload the current table section
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        // Exit editing mode after the deletion.
        [self.tableView setEditing:NO animated:YES];
        [self updateButtonsToMatchTableState];
	}
}


#pragma mark - Updating button state

- (void)updateButtonsToMatchTableState
{
    if (self.tableView.editing)
    {
        // Show the option to cancel the edit.
        self.navigationItem.rightBarButtonItem = self.cancelBarButton;
        
        [self updateDeleteButtonTitle];
        
        // Show the delete button.
        self.navigationItem.leftBarButtonItem = self.deleteBarButton;
    }
    else
    {
        // Not in editing mode.
        self.navigationItem.leftBarButtonItem = self.backBarButton;
        
        // Show the edit button, but disable the edit button if there's nothing to edit.
        if (self.dataArray.count > 0)
        {
            self.editBarButton.enabled = YES;
        }
        else
        {
            self.editBarButton.enabled = NO;
        }
        self.navigationItem.rightBarButtonItem = self.editBarButton;
    }
}

- (void)updateDeleteButtonTitle
{
    // Update the delete button's title, based on how many items are selected
    NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
    
    BOOL allItemsAreSelected = selectedRows.count == self.dataArray.count;
    BOOL noItemsAreSelected = selectedRows.count == 0;
    
    if (allItemsAreSelected || noItemsAreSelected)
    {
        self.deleteBarButton.title = NSLocalizedString(@"Delete All", @"");
    }
    else
    {
        NSString *titleFormatString =
        NSLocalizedString(@"Delete (%d)", @"Title for delete button with placeholder for number");
        self.deleteBarButton.title = [NSString stringWithFormat:titleFormatString, selectedRows.count];
    }
}


@end
