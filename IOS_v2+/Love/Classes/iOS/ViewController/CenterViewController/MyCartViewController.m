//
//  MyCartViewController.m
//  Love
//
//  Created by lee wei on 14-10-4.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MyCartViewController.h"
#import "MyCartTableViewCell.h"
#import "MyCartTableViewForHeaderView.h"
#import "MyCartFooterView.h"
#import "OrderConfirmationViewController.h"

#import "UIImageView+WebCache.h"

#import "CartModel.h"
#import "PutCartModel.h"

typedef NS_ENUM(NSInteger, MyCartViewTag)
{
    MyCartViewForHeaderInSection = 100,
};

#define indexPathMark(section, row)  [NSString stringWithFormat:@"%d-%d", section, row];
#define TotalPriceText(P) [NSString stringWithFormat:@"总计:￥%0.2lf", P]

static NSString * const rowSelectValue = @"YES";
static NSString * const rowUnSelectValue = @"NO";


@interface MyCartViewController ()<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIAlertViewDelegate, MyCartTableViewCellDelegate, MyCartTableViewForHeaderViewDelegate, MyCartFooterViewDelegate>
{
    double productPrice;
}

@property (nonatomic, strong) OrderConfirmationViewController *orderViewController;

@property (nonatomic, strong) UIBarButtonItem *doneBarButton;
@property (nonatomic, strong) UIBarButtonItem *editBarButton;

@property (nonatomic, strong) MyCartFooterView *footerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UINib *nib;


@property (nonatomic, assign) BOOL isCellEdit;

@property (nonatomic, strong) NSMutableArray *cartIDArray; //提交订单
@property (nonatomic, strong) NSMutableArray *cellArray; //修改购物车，包括commo_id，num。
@property (nonatomic, strong) NSMutableDictionary *sectionDic; //存储section和row， section=key
@end

@implementation MyCartViewController

#pragma mark - init

- (void)reloadTableView
{
    if ([_tableView isKindOfClass:[UITableView class]]) {
        [_tableView removeFromSuperview];
    }
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f - 40.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];

    [self.view addSubview:_tableView];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = MyLocalizedString(@"购物车");

        _cartIDArray = [[NSMutableArray alloc] init];
        _cellArray = [[NSMutableArray alloc] init];
        _sectionDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //-------
    self.view.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    
    if (VersionNumber_iOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;//view在导航栏下方
    }
    
    productPrice = 0.0;
    _isCellEdit = NO;
    
    //-- 服务器获取数据
    [CartModel getCartList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cartNotice:) name:kCartNotificationName object:nil];

    //-----
    _doneBarButton = [[UIBarButtonItem alloc] initWithTitle:MyLocalizedString(@"Done")
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(doneBarButtonAction)];
    _doneBarButton.tintColor = [UIColor whiteColor];
    
    
    _editBarButton = [[UIBarButtonItem alloc] initWithTitle:MyLocalizedString(@"Edit")
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(editBarButtonAction)];
    _editBarButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = _editBarButton;
 
    //
    [self reloadTableView];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsSelection = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //--- 底部view
    _footerView = [[MyCartFooterView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), kScreenWidth, 40.f)];
    [_footerView setBuyPriceView];
    [_footerView.allSelectButton addTarget:self action:@selector(allSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    _footerView.delegate = self;
    [self.view addSubview:_footerView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    _orderViewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notice
- (void)cartNotice:(NSNotification *)notice
{
    _dataArray = [notice object];
    
    //所有cell存入_sectionDic， section为key， row的数组为value，存入yes， no，yes=选中，no=为选中
    for (int i = 0; i < [_dataArray count]; i++) {
        NSString *sectionKey = [NSString stringWithFormat:@"%d", i];
        NSMutableArray *rowMutableArray = [[NSMutableArray alloc] init];
        CartModel *model = _dataArray[i];
        NSArray *productArray = model.productInfo;
        for (int j = 0; j < [productArray count]; j++) {
            //NSString *rowObject = [NSString stringWithFormat:@"%d", j];
            [rowMutableArray addObject:rowUnSelectValue];
        }
        [_sectionDic setObject:rowMutableArray forKey:sectionKey];
    }
    [self.tableView reloadData];
}

#pragma mark - button action
// 选择购物车的全部商品
- (void)allSelectAction:(id)sender{
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    
    productPrice = 0.0;
    
    if (button.selected) {
        //-----
        NSArray *KeyArray = [_sectionDic allKeys];
        for (NSString *sectionKey in KeyArray) {
            NSMutableArray *rowArray = [_sectionDic objectForKey:sectionKey];
            for (NSUInteger i = 0; i < [rowArray count]; i++) {
                [rowArray replaceObjectAtIndex:i withObject:rowSelectValue];
            }
            [_sectionDic setObject:rowArray forKey:sectionKey];
        }
//        NSLog(@"select all sectionDic = %@", _sectionDic);
        
        double sum = 0;
        CartProductInfoModel *productInfoModel = [[CartProductInfoModel alloc] init];
        if ([_dataArray count] > 0) {
            for (int i = 0; i < [_dataArray count]; i++) {
                CartModel *model = _dataArray[i];
                double price = [model.allPrice doubleValue];
                sum = sum + price;
                
                NSArray *productArray = model.productInfo;
                if ([productArray count] > 0) {
                    for (NSDictionary *productInfoDic in productArray) {
                        NSString *cartID = productInfoDic[productInfoModel.cartId];
                        if (![_cartIDArray containsObject:cartID]) {
                            [_cartIDArray addObject:cartID];
                        }
                        
                    }
                }
            }
        }

        _footerView.totalPriceLabel.text = TotalPriceText(sum);// [NSString stringWithFormat:@"总计:￥%0.2lf", sum];
        
        [button setImage:[UIImage imageNamed:@"cart_select"] forState:UIControlStateNormal];
        
    }else{
        if ([_cartIDArray count] > 0) {
            [_cartIDArray removeAllObjects];
        }
        
        NSArray *KeyArray = [_sectionDic allKeys];
        for (NSString *sectionKey in KeyArray) {
            NSMutableArray *rowArray = [_sectionDic objectForKey:sectionKey];
            for (NSUInteger i = 0; i < [rowArray count]; i++) {
                [rowArray replaceObjectAtIndex:i withObject:rowUnSelectValue];
            }
            [_sectionDic setObject:rowArray forKey:sectionKey];
        }
        
//        NSLog(@"select all sectionDic = %@", _sectionDic);
        
        //--
        _footerView.totalPriceLabel.text = @"";

        [button setImage:[UIImage imageNamed:@"cart_unselect"] forState:UIControlStateNormal];
    }
    
    [_tableView reloadData];
}

- (void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

//完成显示结算按钮，价格label
- (void)displayEditBarButton
{
    self.navigationItem.rightBarButtonItem = _editBarButton;
    
    [_footerView setBuyPriceView];
    
    _isCellEdit = NO;
    
    [_tableView reloadData];
}
- (void)doneBarButtonAction
{
    if ([_cellArray count] > 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:MyLocalizedString(@"是否修改")
                                                           delegate:self
                                                  cancelButtonTitle:MyLocalizedString(@"Cancel")
                                                  otherButtonTitles:MyLocalizedString(@"OK"), nil];
        alertView.tag = 1000;
        [alertView show];
    }else {
        [self displayEditBarButton];
    }
}

//编辑 显示删除按钮
- (void)editBarButtonAction
{
    self.navigationItem.rightBarButtonItem = _doneBarButton;
    [_footerView setDeleteButton];
    _isCellEdit = YES;
    [_tableView reloadData];
}

#pragma mark - footer view delegate
//删除商品
- (void)deleteProductAction
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

//结算
- (void)settleUpProductAction
{
    //code, id:num:price:recom
    NSLog(@"----- 结算 -------");
    NSMutableArray *codeArray = [[NSMutableArray alloc] init];
    NSMutableArray *imgUrlArr = [[NSMutableArray alloc] init];//选中商品图片
    NSMutableArray *introArr = [[NSMutableArray alloc] init];//选中商品简介
    NSMutableArray *skuArr = [[NSMutableArray alloc] init];//选中商品属性
    NSMutableArray *idArr = [[NSMutableArray alloc] init];//选中商品id

    double totalPrice = 0.0;
    NSArray *keyArray = [_sectionDic allKeys];
    for (NSString *keyObject in keyArray) {
        NSArray *rowArray = [_sectionDic objectForKey:keyObject];
        
        NSInteger idx = [keyObject integerValue];
        if (idx < [_dataArray count]) {
            CartModel *model = (CartModel *)_dataArray[idx];
            NSArray *infoArr = model.productInfo;
            for (NSInteger i = 0; i < [rowArray count]; i++) {
                NSString *string = rowArray[i];
                if ([string isEqualToString:rowSelectValue]) {
                    if ([infoArr count] > 0) {
                        NSDictionary *productInfoDic = infoArr[i];
                        CartProductInfoModel *productInfoModel = [[CartProductInfoModel alloc] init];
                        NSString *idString = productInfoDic[productInfoModel.cartId];
                        [idArr addObject:idString];
                        NSString *commonId = productInfoDic[productInfoModel.commoId];
                        NSString *number = productInfoDic[productInfoModel.numInfo];
                        NSString *price = productInfoDic[productInfoModel.priceInfo];
                        NSString *recomId = productInfoDic[productInfoModel.recomId];
                        double allPrice = [productInfoDic[productInfoModel.allPrice] doubleValue];
                        totalPrice = totalPrice + allPrice;
                        if ([idString length] > 0 && [number length] > 0 && [price length] > 0) {
                            NSString *codeString = [NSString stringWithFormat:@"%@:%@:%@:%@", commonId, number, price, recomId];
                            [codeArray addObject:codeString];
                        }
                        
                        NSString *imgUrl = productInfoDic[productInfoModel.thumbPath];
                        [imgUrlArr addObject:imgUrl];
                        NSString *intro = productInfoDic[productInfoModel.productName];
                        [introArr addObject:intro];
//                        NSString *sku = productInfoDic[productInfoModel.commoStandard];
//                        [skuArr addObject:sku];
                        NSArray *standardArr = (NSArray *)productInfoDic[productInfoModel.commoStandard];
                        NSString *sku = [standardArr componentsJoinedByString:@"；"];
                        [skuArr addObject:sku];
                        
                    }
                }
            }            
        }
        
    }

    NSLog(@"codeArray = %@", codeArray);
    if ([codeArray count] > 0) {

        if (_orderViewController == nil) {
            _orderViewController = [[OrderConfirmationViewController alloc] init];
            NSString *codes = [codeArray componentsJoinedByString:@"_"];
            _orderViewController.code = codes;
            _orderViewController.money = [NSString stringWithFormat:@"%f", totalPrice];
            _orderViewController.isCart = YES;
            _orderViewController.dataArray = codeArray;
            
            _orderViewController.imgUrlArr = imgUrlArr;
            _orderViewController.introArr = introArr;
            _orderViewController.skuArr = skuArr;
            _orderViewController.idArr = idArr;
            
            
            [self.navigationController pushViewController:_orderViewController animated:YES];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                          message:MyLocalizedString(@"您还没有选择商品，请选择商品然后下单")
                                                         delegate:self
                                                cancelButtonTitle:MyLocalizedString(@"OK")
                                                otherButtonTitles:nil, nil];
        alertView.delegate = self;
        alertView.tag = 100001;
        [alertView show];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_dataArray count] > 0) {
        return [_dataArray count];
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_dataArray count] > 0) {
        
        CartModel *model = (CartModel *)_dataArray[section];
        NSArray *infoArr = model.productInfo;
       
        return [infoArr count];
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"kMyCartCellIdentifier";
    static NSString *noDataCellIdentifier = @"noDataCellIdentifier";
    
    if ([_dataArray count] > 0) {
        if (!_nib) {
            _nib = [UINib nibWithNibName:@"MyCartTableViewCell" bundle:nil];
            [tableView registerNib:_nib forCellReuseIdentifier:CellIdentifier];
        }
        MyCartTableViewCell *cell = (MyCartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell.delegate = self;
        
        CartModel *model = (CartModel *)_dataArray[indexPath.section];
        NSArray *infoArr = model.productInfo;
        if ([infoArr count] > 0) {
            NSDictionary *productInfoDic = infoArr[indexPath.row];
            
            CartProductInfoModel *productInfoModel = [[CartProductInfoModel alloc] init];
            
            [cell.previewImageView sd_setImageWithURL:[NSURL URLWithString:productInfoDic[productInfoModel.thumbPath]]
                                     placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            cell.titleLabel.text = productInfoDic[productInfoModel.productName];
            cell.priceLabel.text = productInfoDic[productInfoModel.priceInfo];
            cell.numbersLabel.text = [NSString stringWithFormat:@"X%@", productInfoDic[productInfoModel.numInfo]];
            cell.buyNumberTextField.text = productInfoDic[productInfoModel.numInfo];
            
            NSString *cartID = productInfoDic[productInfoModel.cartId];
            
            NSArray *standardArr = (NSArray *)productInfoDic[productInfoModel.commoStandard];
            cell.skuLabel.text = [standardArr componentsJoinedByString:@"；"];
            
            //[cell cellEdit:_isCellEdit];
            cell.numbersView.hidden = !_isCellEdit;
            cell.titleLabel.hidden = _isCellEdit;
            
            //判断_sectionDic中是yes，还是no，yes为选择，no为取消
            NSArray *KeyArray = [_sectionDic allKeys];
            NSString *sectionKey = [NSString stringWithFormat:@"%ld", (unsigned long)indexPath.section];
            NSUInteger row = indexPath.row;
            if ([KeyArray containsObject:sectionKey]) {
                NSArray *rowArray = [_sectionDic objectForKey:sectionKey];
                if (row < [rowArray count]) {
                    NSString *rowValue = rowArray[row];
                    if ([rowValue isEqualToString:rowUnSelectValue]) {
                        [cell.selectButton setImage:[UIImage imageNamed:@"cart_unselect"] forState:UIControlStateNormal];
                        if ([_cartIDArray count] > 0) {
                            if ([_cartIDArray containsObject:cartID]) {
                                [_cartIDArray removeObject:cartID];
                            }
                        }
                    }
                    if ([rowValue isEqualToString:rowSelectValue]) {
                        [cell.selectButton setImage:[UIImage imageNamed:@"cart_select"] forState:UIControlStateNormal];
                        if (![_cartIDArray containsObject:cartID]) {
                            [_cartIDArray addObject:cartID];
                        }
                    }
                }
            }
        }

        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:noDataCellIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:noDataCellIdentifier];
        }
        cell.detailTextLabel.text = MyLocalizedString(@"购物车为空");
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

#pragma mark - Table view delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyCartTableViewForHeaderView *headerView = [[MyCartTableViewForHeaderView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 36.f)];
    [headerView commitInitInSection:section];
    headerView.delegate = self;
    NSArray *KeyArray = [_sectionDic allKeys];
    NSString *sectionKey = [NSString stringWithFormat:@"%ld", (unsigned long)section];
    if ([KeyArray containsObject:sectionKey]) {
        NSUInteger noCount = 0;
        NSUInteger yesCount = 0;
        NSArray *rowArray = [_sectionDic objectForKey:sectionKey];
        for (NSString *string in rowArray) {
            if ([string isEqualToString:rowUnSelectValue]) {
                noCount = noCount + 1;
            }
            if ([string isEqualToString:rowSelectValue]) {
                yesCount = yesCount + 1;
            }
        }
        if (noCount == [rowArray count]) {
            [headerView headerViewButtonSelected:NO];
        }else if (yesCount == [rowArray count]) {
            [headerView headerViewButtonSelected:YES];
        }else {
           [headerView headerViewButtonSelected:NO];
        }
    }else {
        [headerView headerViewButtonSelected:NO];
    }

    CartModel *model = (CartModel *)_dataArray[section];
    headerView.shopNameLabel.text = model.sellerName;
    
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *sectionFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 30.f)];
    sectionFooterView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10.f, 0, sectionFooterView.frame.size.width - 10.f, 0.6)];
    lineView.backgroundColor = [UIColor colorRGBWithRed:201.f green:201.f blue:201.f alpha:0.8];
    [sectionFooterView addSubview:lineView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 1.f, sectionFooterView.frame.size.width - 30.f, sectionFooterView.frame.size.height - 11.f)];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:12.f];
    label.adjustsFontSizeToFitWidth = YES;
    [sectionFooterView addSubview:label];
    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), sectionFooterView.frame.size.width, 10.f)];
    spaceView.backgroundColor = [UIColor colorRGBWithRed:223.f green:223.f blue:223.f alpha:1.f];
    [sectionFooterView addSubview:spaceView];

    //---  计算价格
    CartModel *model = _dataArray[section];
    NSArray *productInfoArr = model.productInfo;
    if ([productInfoArr count] > 0) {
        double sum = 0;
        CartProductInfoModel *productInfoModel = [[CartProductInfoModel alloc] init];
   
        NSArray *KeyArray = [_sectionDic allKeys];
        NSString *sectionKey = [NSString stringWithFormat:@"%ld", (unsigned long)section];
        if ([KeyArray containsObject:sectionKey]) {
            NSMutableArray *rowArray = [_sectionDic objectForKey:sectionKey];
            if ([rowArray count] == [productInfoArr count]) {
                for (int i = 0; i < [rowArray count]; i++) {
                    NSString *string = rowArray[i];

                    if ([string isEqualToString:rowUnSelectValue]) {
                        sum = sum + 0;
                    }
                    if ([string isEqualToString:rowSelectValue]) {
                        NSDictionary *productInfoDic = productInfoArr[i];
                        double price = [productInfoDic[productInfoModel.allPrice] doubleValue];
                        sum = sum + price;
                    }
                }
            }

        }
        
        NSString *sectionAllPrice = [NSString stringWithFormat:@"%0.2lf", sum];
        label.text = [NSString stringWithFormat:@"%@%@",
                      MyLocalizedString(@"合计："), sectionAllPrice];
    }

    return sectionFooterView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectio
{
    return 30.f;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Update the delete button's title based on how many items are selected.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Update the delete button's title based on how many items are selected.
}

#pragma mark - MyCartTableViewForHeaderView Delegate - 选择店铺内的全部商品
// 选择店铺内的全部商品
- (void)selectSectionHeader:(BOOL)select inSection:(NSInteger)section
{
    double allPrice = 0;
    CartModel *model = (CartModel *)_dataArray[section];
    NSArray *infoArr = model.productInfo;
    if ([infoArr count] > 0) {
        for (NSDictionary *productInfoDic in infoArr) {
            CartProductInfoModel *productInfoModel = [[CartProductInfoModel alloc] init];
            double price = [productInfoDic[productInfoModel.allPrice] doubleValue];
            allPrice = allPrice + price;
        }
    }
    
    NSArray *KeyArray = [_sectionDic allKeys];
    NSString *sectionKey = [NSString stringWithFormat:@"%ld", (unsigned long)section];
    if ([KeyArray containsObject:sectionKey]) {
        NSMutableArray *rowArray = [_sectionDic objectForKey:sectionKey];
        for (int i = 0; i < [rowArray count]; i++) {
            NSString *string = rowArray[i];
            if ([string isEqualToString:rowUnSelectValue]) {
                [rowArray replaceObjectAtIndex:i withObject:rowSelectValue];
                
                productPrice = productPrice + allPrice;
            }
            if ([string isEqualToString:rowSelectValue]) {
                [rowArray replaceObjectAtIndex:i withObject:rowUnSelectValue];
                double newPrice = productPrice - allPrice;
                if (newPrice > 0.0) {
                    productPrice = newPrice;
                }else{
                    productPrice = 0.0;
                }
            }
        }
        [_sectionDic setObject:rowArray forKey:sectionKey];
    }
    [_tableView reloadData];
    
    _footerView.totalPriceLabel.text = TotalPriceText(productPrice);// [NSString stringWithFormat:@"￥%0.2lf", productPrice];

}


#pragma mark - MyCartTableViewCell Delegate
//购买数量
- (void)buyNumber:(int)number button:(UIButton *)button
{    
    NSIndexPath *indexPath = nil;
    if (VersionNumber_iOS_8) {
        indexPath = [_tableView indexPathForCell:(MyCartTableViewCell *)[[[button superview] superview] superview]];
    }else{
        indexPath = [_tableView indexPathForCell:(MyCartTableViewCell *)[[[[button superview] superview] superview] superview]];
    }
    MyCartTableViewCell *cell = (MyCartTableViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
    
    cell.numbersLabel.text = [NSString stringWithFormat:@"X%d", number];
    
    if ([_cellArray count] > 0) {
        if (![_cellArray containsObject:cell]) {
            [_cellArray addObject:cell];
        }
    }else {
        [_cellArray addObject:cell];
    }
}

- (void)selectDelRowAtIndexPath:(BOOL)select
{
    
}

//选择单个商品
- (void)selectButton:(UIButton *)button select:(BOOL)select
{
    NSIndexPath *indexPath = nil;
    if (VersionNumber_iOS_8) {
        indexPath = [_tableView indexPathForCell:(MyCartTableViewCell *)[[button superview] superview]];
    }else{
        indexPath = [_tableView indexPathForCell:(MyCartTableViewCell *)[[[button superview] superview] superview]];
    }
    
    double price = 0;
    CartModel *model = (CartModel *)_dataArray[indexPath.section];
    NSArray *infoArr = model.productInfo;
    if ([infoArr count] > 0) {
        NSDictionary *productInfoDic = infoArr[indexPath.row];
        
        CartProductInfoModel *productInfoModel = [[CartProductInfoModel alloc] init];
        price = [productInfoDic[productInfoModel.allPrice] doubleValue];
    }

    NSArray *KeyArray = [_sectionDic allKeys];
    
    NSString *sectionKey = [NSString stringWithFormat:@"%ld", (unsigned long)indexPath.section];
    NSUInteger rowValue = indexPath.row;
    if ([KeyArray containsObject:sectionKey]) {
        NSMutableArray *rowArray = [_sectionDic objectForKey:sectionKey];
        if (rowValue < [rowArray count]) {
            NSString *string = rowArray[rowValue];
            if ([string isEqualToString:rowUnSelectValue]) {
                [rowArray replaceObjectAtIndex:rowValue withObject:rowSelectValue];
                productPrice = productPrice + price;
                //[cell cellButtonSelect:YES];
            }
            if ([string isEqualToString:rowSelectValue]) {
                [rowArray replaceObjectAtIndex:rowValue withObject:rowUnSelectValue];
                double newPrice = productPrice - price;
                if (newPrice > 0.0) {
                    productPrice = newPrice;
                }else{
                    productPrice = 0.0;
                }
               // [cell cellButtonSelect:NO];
            }
        }

        [_sectionDic setObject:rowArray forKey:sectionKey];
    }
    NSLog(@"_sectionDic  = %@", _sectionDic);
   
    _footerView.totalPriceLabel.text = TotalPriceText(productPrice);// [NSString stringWithFormat:@"￥%0.2lf", productPrice];
    
    [_tableView reloadData];
}

#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// The user tapped one of the OK/Cancel buttons.
	if (buttonIndex == 0)
	{
        if ([_cartIDArray count] > 0) {
            NSString *cartIds = nil;
            NSUInteger delType = 0;
            if ([_cartIDArray count] == 1) {
                cartIds = [_cartIDArray lastObject];
                delType = DelCartProductOne;
            }else{
                cartIds = [_cartIDArray componentsJoinedByString:@"_"];
                delType = DelCartProductMultiple;
            }
            [CartModel delCartProductWithID:cartIds
                                       type:[NSString stringWithFormat:@"%ld", (unsigned long)delType]
                                      block:^(NSString *code, NSString *msg) {
                                          UIAlertView *alertView = nil;
                                          if ([code intValue] == 1) {
                                              alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                     message:MyLocalizedString(@"删除成功")
                                                                                    delegate:self
                                                                           cancelButtonTitle:MyLocalizedString(@"OK")
                                                                           otherButtonTitles:nil, nil];
                                              alertView.delegate = self;
                                              alertView.tag = 1001;
                                              [alertView show];
                                          }else {
                                              alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                     message:MyLocalizedString(@"删除失败")
                                                                                    delegate:self
                                                                           cancelButtonTitle:MyLocalizedString(@"OK")
                                                                           otherButtonTitles:nil, nil];
                                              alertView.delegate = self;
                                              alertView.tag = 1002;
                                              [alertView show];
                                          }
                                      }];
        }
	}
}

#pragma mark - alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1000) {
        if (buttonIndex == 0) {
            [self displayEditBarButton];
        }
        if (buttonIndex == 1) {
            NSLog(@"cellArray = %@", _cellArray);
            self.navigationItem.rightBarButtonItem = _editBarButton;
            
            [_footerView setBuyPriceView];
            
            _isCellEdit = NO;
            
            NSArray *tempArray = [NSArray arrayWithArray:_cellArray];
            for (MyCartTableViewCell *cell in tempArray) {
                //int updateNumber = [cell.numbersLabel.text intValue];
                if ([cell.numbersLabel.text length] >= 2) {
                    NSString *updateNumbers = [cell.numbersLabel.text substringFromIndex:1];
                    NSLog(@"numbersLabel %@", updateNumbers);
                    
                    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
                    CartModel *model = (CartModel *)_dataArray[indexPath.section];
                    NSArray *infoArr = model.productInfo;
                    if ([infoArr count] > 0) {
                        NSDictionary *productInfoDic = infoArr[indexPath.row];
                        CartProductInfoModel *productInfoModel = [[CartProductInfoModel alloc] init];
                        NSString * oldNumber =productInfoDic[productInfoModel.numInfo];
                        if (![updateNumbers isEqualToString:oldNumber]) {
                            NSString *commoID = productInfoDic[productInfoModel.commoId];
                            [CartModel editCartWithCommo:commoID
                                                     num:updateNumbers
                                                   block:^(NSString *code, NSString *msg) {
                                                       if ([code intValue] == 1) {
                                                           //cell.numbersLabel.text = [NSString stringWithFormat:@"X%@",oldNumber];
                                                       }
                                                       
                                                   }];
                        }
                    }

                }
                
            }
            if ([_cellArray count] > 0) {
                [_cellArray removeAllObjects];
            }
            [CartModel getCartList];
            [_tableView reloadData];
        }
    }
    if (alertView.tag == 1001) {
        _dataArray = nil;
        [_tableView reloadData];
        [CartModel getCartList];
    }
}

@end
