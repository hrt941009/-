//
//  CommissionSKUViewController.m
//  Love
//
//  Created by lee wei on 14/11/12.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CommissionSKUViewController.h"
#import "MyCartViewController.h"
#import "OrderConfirmationViewController.h"

#import "SKUImageViewTableViewCell.h"
#import "SKUValueTableViewCell.h"
#import "SKUNumbersTableViewCell.h"
#import "SKUDoneTableViewCell.h"
#import "SKUValueCell.h"

#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"

#import "SKUModel.h"
#import "PutCartModel.h"

@interface CommissionSKUViewController ()<UITableViewDataSource, UITableViewDelegate, SKUValueCellDelegate, SKUNumbersTableCellDelegate, SKUCollectionCellDelegate>
{
    NSString *commoKey1;
    NSString *commoKey2;
    
    int skuNumbers;
    
    NSIndexPath *skuNumbersIndexPath;
}

@property (nonatomic, strong)  UITableView *tableView;
@property (nonatomic, strong)  UILabel *priceLabel;
@property (nonatomic, strong)  UINib *nib1;
@property (nonatomic, strong)  UINib *nib4;

@property (nonatomic, strong) NSString *keyColor;
@property (nonatomic, strong) NSString *keySize;

@property (nonatomic, strong) NSString *totalPrice;

@end

@implementation CommissionSKUViewController


#pragma mark - set footer
- (void)setFooterViewWithFrame:(CGRect)frame
{
    UIView *footerView = [[UIView alloc] initWithFrame:frame];
    footerView.backgroundColor = [UIColor colorRGBWithRed:143.f green:143.f blue:143.f alpha:1.f];
    [self.view addSubview:footerView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8.f, 0, 40.f, footerView.frame.size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.text = MyLocalizedString(@"合计");
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:12.f];
    [footerView addSubview:label];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.f, 0, 100.f, footerView.frame.size.height)];
    _priceLabel.backgroundColor = [UIColor clearColor];
    _priceLabel.textColor = [UIColor colorRGBWithRed:223.f green:32.f blue:84.f alpha:1.f];
    _priceLabel.font = [UIFont systemFontOfSize:22.f];
    _priceLabel.adjustsFontSizeToFitWidth = YES;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", _defaultPrice];
    _totalPrice = _defaultPrice;
    [footerView addSubview:_priceLabel];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.backgroundColor = [UIColor colorRGBWithRed:224.f green:30.f blue:84.f alpha:1.f];
    doneButton.frame = CGRectMake(footerView.frame.size.width - 100.f, 5.f, 80.f, 34.f);
    doneButton.layer.cornerRadius = 5.f;
    [doneButton setTitle:MyLocalizedString(@"Done") forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [footerView addSubview:doneButton];
}

#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"商品属性");
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    skuNumbers = 1;
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    CGRect tvRect = CGRectMake(0, 9.f, kScreenWidth, kScreenHeight - 64.f - 52.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [self setFooterViewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), kScreenWidth, 44.f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 不同数量 不同价格
//商品数量范围
- (NSArray *)skuNumbersWithSection1:(NSString *)section1 section2:(NSString *)section2
{
    NSArray *array = nil;
    
    NSString *detail1 = [NSString stringWithFormat:@"%@1~%@%@", MyLocalizedString(@"购买"), section1, MyLocalizedString(@"件")];
    NSString *detail2 = [NSString stringWithFormat:@"%@%d~%@%@", MyLocalizedString(@"购买"), [section1 intValue] + 1, section2, MyLocalizedString(@"件")];
    NSString *detail3 = [NSString stringWithFormat:@"%@>%@%@", MyLocalizedString(@"购买"), section2, MyLocalizedString(@"件")];
    
    array = @[detail1, detail2, detail3];
    return array;
}

//商品价格范围
- (NSArray *)skuNumbersWithPrice1:(NSString *)price1 price2:(NSString *)price2 price3:(NSString *)price3
{
    NSArray *array = nil;
    
    NSString *p1 = [NSString stringWithFormat:@"￥%@", price1];
    NSString *p2 = [NSString stringWithFormat:@"￥%@", price2];
    NSString *p3 = [NSString stringWithFormat:@"￥%@", price3];
    
    array = @[p1, p2, p3];
    return array;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return [_skuValueArr count];
    }
    if (section == 2) {
        return 1;
    }

    return 0;
}

- (void)skuValueButton:(UIButton *)button{
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier3 = @"Cell3";
    static NSString *CellIdentifier4 = @"Cell4";
//    static NSString *CellIdentifier5 = @"Cell5";
    static NSString *CellIdentifier6 = @"Cell6";
    
    NSInteger section = [indexPath section];
    if (section == 0) {
        if (!_nib1) {
            _nib1 = [UINib nibWithNibName:@"SKUImageViewTableViewCell" bundle:nil];
            [tableView registerNib:_nib1 forCellReuseIdentifier:CellIdentifier1];
        }
        SKUImageViewTableViewCell *cell = (SKUImageViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        [cell.photoView sd_setImageWithURL:[NSURL URLWithString:_thumbPath]
                          placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        
        cell.priceLabel.text = [NSString stringWithFormat:@"￥%@", _defaultPrice];;
        [cell getStockLabelTextWithNumbers:_stocksNum];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (section == 1) {
        SKUValueCell *cell = (SKUValueCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        
        if (cell == nil) {
            cell = [[SKUValueCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier3];
        }
        cell.delegate = self;
       
        SKUModel *skuModel = [[SKUModel alloc] init];
        cell.typeLabel.text = [_skuValueArr[indexPath.row] objectForKey:skuModel.skuKeyName];
        cell.dataArray = [_skuValueArr[indexPath.row] objectForKey:skuModel.skuKeyValue];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else if (section == 2) {
        if (!_nib4) {
            _nib4 = [UINib nibWithNibName:@"SKUNumbersTableViewCell" bundle:nil];
            [tableView registerNib:_nib4 forCellReuseIdentifier:CellIdentifier4];
        }
        SKUNumbersTableViewCell *skuNumbersCell = (SKUNumbersTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        skuNumbersCell.delegate = self;
        skuNumbersIndexPath = indexPath;
        
        NSArray *detailArr =  [self skuNumbersWithSection1:_section1 section2:_section2];
        NSArray *priceArr = [self skuNumbersWithPrice1:_price1 price2:_price2 price3:_price3];
        skuNumbersCell.detailLabel1.text = detailArr[0];
        skuNumbersCell.detailLabel2.text = detailArr[1];
        skuNumbersCell.detailLabel3.text = detailArr[2];
        skuNumbersCell.priceLabel1.text = priceArr[0];
        skuNumbersCell.priceLabel2.text = priceArr[1];
        skuNumbersCell.priceLabel3.text = priceArr[2];
        
        skuNumbersCell.accessoryType = UITableViewCellAccessoryNone;
        skuNumbersCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return skuNumbersCell;
    }
    else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier6];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier6];
        }
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    if (section == 0) {
        SKUImageViewTableViewCell *imageCell = (SKUImageViewTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        return imageCell.frame.size.height;
    }
    if (section == 1) {
        SKUValueCell *valueCell = (SKUValueCell  *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        CGFloat height = [valueCell cellHeight];
        NSLog(@"valueCell.collectionView.frame.size.height = %f",height);
        return height;
    }
    if (section == 2) {
        //SKUNumbersTableViewCell *numbersCell = (SKUNumbersTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
        //CGFloat height = [numbersCell cellHeight];
        return 66.f;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - SKUNumbersTableCellDelegate
//商品数量
- (void)skuNumbers:(int)numbers
{
    skuNumbers = numbers;
    if (numbers == 1) {
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", [_defaultPrice floatValue]];
        _totalPrice = [NSString stringWithFormat:@"%.2f",[_defaultPrice floatValue]];
    }
    if (1 < numbers <=10) {
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", [_price1 floatValue] * numbers];
        _totalPrice = [NSString stringWithFormat:@"%.2f",[_price1 floatValue] * numbers];
    }
    if (10 < numbers <= 50) {
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", [_price2 floatValue] * numbers];
        _totalPrice = [NSString stringWithFormat:@"%.2f",[_price2 floatValue] * numbers];
    }
    if (numbers > 50) {
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f", [_price3 floatValue] * numbers];
        _totalPrice = [NSString stringWithFormat:@"%.2f",[_price3 floatValue] *numbers];
    }
}

#pragma mark - SKUCollectionCellDelegate
- (void)choiceColorOrSize:(NSString *)colorOrSize andCell:(SKUValueCell *)cell{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSInteger row = indexPath.row;
    if (row == 0) {
        _keyColor = colorOrSize;
    }
    if (row == 1) {
        _keySize = colorOrSize;
    }
    
    
    
    NSString *commoKey = nil;
    if ([_skuValueArr count] > 1) {
        commoKey = [NSString stringWithFormat:@"%@:%@", _keyColor, _keySize];
        [self productSKUPriceKey:commoKey];
    }
    if ([_skuValueArr count] == 1) {
        commoKey = _keyColor;
        [self productSKUPriceKey:commoKey];
    }
}

#pragma mark - 根据商品属性，获得价格
- (void)productSKUPriceKey:(NSString *)ckey
{
    SKUNumbersTableViewCell *cell = (SKUNumbersTableViewCell *)[_tableView cellForRowAtIndexPath:skuNumbersIndexPath];
    cell.productNumbers = 1;
    cell.textField.text = @"1";
    
    NSArray *commlistKeyArr = [_commList allKeys];
    if ([commlistKeyArr containsObject:ckey]) {
        SKUCommissionModel *commissionModel = [[SKUCommissionModel alloc] init];
        NSDictionary *commoDic = [_commList objectForKey:ckey];
        _defaultPrice = [commoDic objectForKey:commissionModel.nowPrice];
        _priceLabel.text = [NSString stringWithFormat:@"￥%@", _defaultPrice];
        if ([commoDic isKindOfClass:[NSDictionary class]]) {
            NSDictionary *rangeDic = [commoDic objectForKey:commissionModel.discountRange];
            if ([rangeDic isKindOfClass:[NSDictionary class]]) {
                _section1 = [rangeDic objectForKey:@"section_1"];
                _section2 = [rangeDic objectForKey:@"section_2"];
                _price1 = [rangeDic objectForKey:@"price_1"];
                _price2 = [rangeDic objectForKey:@"price_2"];
                _price3 = [rangeDic objectForKey:@"price_3"];
                
                NSArray *detailArr =  [self skuNumbersWithSection1:_section1 section2:_section2];
                NSArray *priceArr = [self skuNumbersWithPrice1:_price1 price2:_price2 price3:_price3];
                cell.detailLabel1.text = detailArr[0];
                cell.detailLabel2.text = detailArr[1];
                cell.detailLabel3.text = detailArr[2];
                cell.priceLabel1.text = priceArr[0];
                cell.priceLabel2.text = priceArr[1];
                cell.priceLabel3.text = priceArr[2];
            }
        }
    }
}

#pragma mark - button action
//发送sku数据，_isCart=YES 购物车； _isCart=NO 直接提交订单
- (void)postSKUDataWithKey:(NSString *)ckey
{
    NSLog(@"%@|%@ %@", ckey, _keyColor, _keySize);
    __block UIAlertView *alertView = nil;
    SKUCommissionModel *commissionModel = [[SKUCommissionModel alloc] init];

    NSArray *keyArr = [_commList allKeys];
    if ([keyArr containsObject:ckey]) {
        NSDictionary *commoDic = [_commList objectForKey:ckey];
        NSString *commoId = [commoDic objectForKey:commissionModel.cid];
        if (_isCart) {
            //加入购物车
            [PutCartModel putCartWithCommo:commoId
                                       num:[NSString stringWithFormat:@"%d", skuNumbers]
                                     block:^(NSString *code, NSString *msg) {
                                         
                                         if ([code intValue] == 1) {
//                                             MyCartViewController *cartViewController = [[MyCartViewController alloc] init];
//                                             [self.navigationController pushViewController:cartViewController animated:YES];
                                             [SVProgressHUD showSuccessWithStatus:@"加入成功"];
                                             [self.navigationController popViewControllerAnimated:YES];
                                             
                                         }
                                         if ([code intValue] == 0) {
                                             alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                   message:MyLocalizedString(@"Error")
                                                                                  delegate:self
                                                                         cancelButtonTitle:MyLocalizedString(@"OK")
                                                                         otherButtonTitles:nil];
                                             [alertView show];
                                         }
                                     }];
        }
        if (!_isCart) {
            //生成订单页面
            OrderConfirmationViewController *orderConfirmationVC = [[OrderConfirmationViewController alloc] init];
            orderConfirmationVC.thumbPath = _thumbPath;
            orderConfirmationVC.skuValueArr = _skuValueArr;
            orderConfirmationVC.commonList = _commList;
            orderConfirmationVC.intro = _intro;
            orderConfirmationVC.colorStr = _keyColor;
            orderConfirmationVC.sizeStr = _keySize;
            orderConfirmationVC.money = _totalPrice;
            orderConfirmationVC.code = commoId;
            orderConfirmationVC.isCart = NO;
            orderConfirmationVC.dresserId = _dresserId;
            [self.navigationController pushViewController:orderConfirmationVC animated:YES];
        }
    }else{
        alertView = [[UIAlertView alloc] initWithTitle:nil
                                               message:MyLocalizedString(@"服务器错误")
                                              delegate:self
                                     cancelButtonTitle:MyLocalizedString(@"OK")
                                     otherButtonTitles:nil];
        [alertView show];
    }
}

// 提交订单
- (void)doneButtonAction:(id)sender
{
    UIAlertView *alertView = nil;
    NSString *commoKey = nil;
    if ([_skuValueArr count] > 1) {
        if ([_keyColor length] > 0 && [_keySize length] > 0) {
            commoKey = [NSString stringWithFormat:@"%@:%@", _keyColor, _keySize];
            [self postSKUDataWithKey:commoKey];
        }else{
            alertView = [[UIAlertView alloc] initWithTitle:nil
                                                   message:MyLocalizedString(@"请选择商品属性")
                                                  delegate:self
                                         cancelButtonTitle:MyLocalizedString(@"OK")
                                         otherButtonTitles:nil];
            [alertView show];
        }
    }else if ([_skuValueArr count] == 1) {
        if ([_keyColor length] > 0) {
            commoKey = _keyColor;
            [self postSKUDataWithKey:commoKey];
        }else{
            alertView = [[UIAlertView alloc] initWithTitle:nil
                                                   message:MyLocalizedString(@"请选择商品属性")
                                                  delegate:self
                                         cancelButtonTitle:MyLocalizedString(@"OK")
                                         otherButtonTitles:nil];
            [alertView show];
        }
    }else {
        alertView = [[UIAlertView alloc] initWithTitle:nil
                                               message:MyLocalizedString(@"该商品获取属性失败，无法购买")
                                              delegate:self
                                     cancelButtonTitle:MyLocalizedString(@"OK")
                                     otherButtonTitles:nil];
        [alertView show];
    }
}

@end
