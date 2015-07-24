//
//  BuyViewController.m
//  Love
//
//  Created by 李伟 on 14-8-7.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "BuyViewController.h"
#import "UIImageView+WebCache.h"

#import "OrderAddressViewController.h"
#import "BuyHeaderTableViewCell.h"
#import "CommodityDetailTableViewCell.h"
#import "PriceAndNumbersTableViewCell.h"
#import "CommodityTypeTableViewCell.h"
#import "RedPacketTableViewCell.h"
#import "MyMessageTableViewCell.h"
#import "MyAddressTableViewCell.h"
#import "SubmitButtonTableViewCell.h"
#import "BuyDetailTableViewCell.h"

@interface BuyViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate, PriceAndNumbersCellDelegate, RedPacketCellDelegate, MyMessageCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextView  *messageTextView;

@property (nonatomic, strong) BuyHeaderTableViewCell        *headerCell;
@property (nonatomic, strong) CommodityDetailTableViewCell  *commodityDetailCell;
@property (nonatomic, strong) PriceAndNumbersTableViewCell  *priceAndNumbersCell;
@property (nonatomic, strong) CommodityTypeTableViewCell    *commodityTypeCell;
@property (nonatomic, strong) RedPacketTableViewCell        *redPacketCell;
@property (nonatomic, strong) MyMessageTableViewCell        *messageCell;
@property (nonatomic, strong) MyAddressTableViewCell        *addressCell;
@property (nonatomic, strong) SubmitButtonTableViewCell     *submitButtonCell;
@property (nonatomic, strong) BuyDetailTableViewCell        *detailCell;

@end

@implementation BuyViewController

#pragma mark -
#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        self.title = MyLocalizedString(@"支付定金");
        _imageArray = [[NSMutableArray alloc] init];
        _commodityType = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //------
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    //-----
    CGRect tvRect = CGRectMake(0, 0, screenWidth, screenHeight - 60.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == BuyViewCellTagWithHeader) {
        return 1;
    }
    if (section == BuyViewCellTagWithCommodityDetail) {
        return 1;
    }
    if (section == BuyViewCellTagWithPriceAndNumbers) {
        return 1;
    }
    if (section == BuyViewCellTagWithCommodityType) {
        if (_commodityType) {
            return 1;
        }
        return 0;
    }
    if (section == BuyViewCellTagWithRedPacket) {
        return 1;
    }
    if (section == BuyViewCellTagWithMessage) {
        return 1;
    }
    if (section == BuyViewCellTagWithAddress) {
        return 1;
    }
    if (section == BuyViewCellTagWithSubmitButton) {
        return 1;
    }
    if (section == BuyViewCellTagWithDetail) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
    static NSString *CellIdentifier3 = @"Cell3";
    static NSString *CellIdentifier4 = @"Cell4";
    static NSString *CellIdentifier5 = @"Cell5";
    static NSString *CellIdentifier6 = @"Cell6";
    static NSString *CellIdentifier7 = @"Cell7";
    static NSString *CellIdentifier8 = @"Cell8";
    static NSString *CellIdentifier9 = @"Cell9";
    
    _headerCell = (BuyHeaderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    _commodityDetailCell = (CommodityDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    _priceAndNumbersCell = (PriceAndNumbersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
    if (_commodityType) {
        _commodityTypeCell = (CommodityTypeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
    }
    _redPacketCell = (RedPacketTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier5];
    _messageCell = (MyMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier6];
    _addressCell = (MyAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier7];
    _submitButtonCell = (SubmitButtonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier8];
    _detailCell = (BuyDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier9];
    
    NSInteger section = indexPath.section;
    
    if (_headerCell == nil) {
        _headerCell = [[BuyHeaderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
    }
    if (_commodityDetailCell == nil) {
        _commodityDetailCell = [[CommodityDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
    }
    if (_priceAndNumbersCell == nil) {
        _priceAndNumbersCell = [[PriceAndNumbersTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3];
        _priceAndNumbersCell.delegate = self;
    }
    if (_commodityType) {
        if (_commodityTypeCell == nil) {
            _commodityTypeCell = [[CommodityTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier4];
        }
    }
    if (_redPacketCell == nil) {
        _redPacketCell = [[RedPacketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier5];
        _redPacketCell.delegate = self;
    }
    if (_messageCell == nil) {
        _messageCell = [[MyMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier6];
        _messageCell.delegate = self;
    }
    if (_addressCell == nil) {
        _addressCell = [[MyAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier7];
    }
    if (_submitButtonCell == nil) {
        _submitButtonCell = [[SubmitButtonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier8];
    }
    if (_detailCell == nil) {
        _detailCell = [[BuyDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier9];
    }
    
    //----------------------
    if (section == BuyViewCellTagWithHeader) {
        _headerCell.accessoryType = UITableViewCellAccessoryNone;
        _headerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return _headerCell;
    }
    if (section == BuyViewCellTagWithCommodityDetail) {
        _commodityDetailCell.imageArray = _imageArray;
        _commodityDetailCell.detailLabel.text = _descriptionStr;
        [_commodityDetailCell setCellHeight];

        
        _commodityDetailCell.accessoryType = UITableViewCellAccessoryNone;
        _commodityDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return _commodityDetailCell;
    }
    if (section == BuyViewCellTagWithPriceAndNumbers) {
        
        _priceAndNumbersCell.isDetail = NO;
        
        _priceAndNumbersCell.accessoryType = UITableViewCellAccessoryNone;
        _priceAndNumbersCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return _priceAndNumbersCell;
    }
    if (_commodityType) {
        if (section == BuyViewCellTagWithCommodityType) {
            _commodityTypeCell.accessoryType = UITableViewCellAccessoryNone;
            _commodityTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return _commodityTypeCell;
        }
    }

    if (section == BuyViewCellTagWithRedPacket) {

        _redPacketCell.titleLabel.text = [NSString stringWithFormat:@"可用红包数量(%d)", 0];
        
        _redPacketCell.accessoryType = UITableViewCellAccessoryNone;
        _redPacketCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return _redPacketCell;
    }
    if (section == BuyViewCellTagWithMessage) {
        _messageCell.accessoryType = UITableViewCellAccessoryNone;
        _messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return _messageCell;
    }
    if (section == BuyViewCellTagWithAddress) {
        
        [_addressCell setMyAddressCellHeight];

        _addressCell.accessoryType = UITableViewCellAccessoryNone;
        _addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return _addressCell;
    }
    if (section == BuyViewCellTagWithSubmitButton) {
        
        _submitButtonCell.accessoryType = UITableViewCellAccessoryNone;
        _submitButtonCell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        return _submitButtonCell;
    }
    if (section == BuyViewCellTagWithDetail) {
        
        _detailCell.accessoryType = UITableViewCellAccessoryNone;
        _detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return _detailCell;
    }

    return nil;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if (section == BuyViewCellTagWithHeader) {
        return 70.f;
    }
    if (section == BuyViewCellTagWithCommodityDetail) {
        CommodityDetailTableViewCell *detailCell = (CommodityDetailTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
        CGFloat height = [detailCell setCellHeight];
        return height + 20.f;
    }
    if (section == BuyViewCellTagWithPriceAndNumbers) {
        return 170.f;
    }
    if (section == BuyViewCellTagWithCommodityType) {
        if (_commodityType) {
            return 170.f;
        }
        return 0;
    }
    if (section == BuyViewCellTagWithRedPacket) {
        return 68.f;
    }
    if (section == BuyViewCellTagWithMessage) {
        return 94.f;
    }
    if (section == BuyViewCellTagWithAddress) {
        MyAddressTableViewCell *addressCell = (MyAddressTableViewCell *)[self tableView:_tableView cellForRowAtIndexPath:indexPath];
        CGFloat height = [addressCell setMyAddressCellHeight];
        return height + 20.f;
    }
    if (section == BuyViewCellTagWithSubmitButton) {
        return 65.f;
    }
    if (section == BuyViewCellTagWithDetail) {
        return 90.f;
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    if (section == BuyViewCellTagWithAddress) {
        OrderAddressViewController *addressVC = [[OrderAddressViewController alloc] initWithNibName:@"OrderAddressView" bundle:nil];
        [self.navigationController pushViewController:addressVC animated:YES];
    }
}

#pragma mark - PriceAndNumbersCellDelegate
/**
 商品数量的textfield
 */
- (void)priceAndNumbersKeyboardDidShow
{
    [_tableView setContentOffset:CGPointMake(0, 310.f) animated:YES];
}

#pragma mark - RedPacketCellDelegate
/**
 红包的textfield
 */
- (void)redPacketCellKeyboardDidShow
{
   [_tableView setContentOffset:CGPointMake(0, 310.f) animated:YES];
}

#pragma mark - MyMessageCellDelegate
/**
 买家留言的textfield
 */
- (void)myMessageCellKeyboardDidShow
{
    [_tableView setContentOffset:CGPointMake(0, 410.f) animated:YES];
}
@end
