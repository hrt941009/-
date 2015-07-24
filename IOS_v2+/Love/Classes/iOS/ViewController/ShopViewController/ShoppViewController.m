//
//  ShoppViewController.m
//  Love
//
//  Created by lee wei on 14/12/17.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ShoppViewController.h"
#import "ShopDiscountViewController.h"

#import "ShopHeaderCell.h"
#import "ShopPicCell.h"
#import "ShopCollectionCell.h"


#import "ShopModel.h"

#import "UIImageView+WebCache.h"

@interface ShoppViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ShopHeaderCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) ShopDiscountViewController *discountController;

@end

@implementation ShoppViewController

static NSString * const reuseIdentifierHeader = @"HeaderCell";
static NSString * const reuseIdentifierPic = @"PicCell";
static NSString * const reuseIdentifierContent = @"ContentCell";

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //--
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5.f, 2.f, CGRectGetWidth(self.view.frame) - 10.f, self.view.frame.size.height - 70.f) collectionViewLayout:flowLayout];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[ShopHeaderCell class] forCellWithReuseIdentifier:reuseIdentifierHeader];
    [_collectionView registerClass:[ShopPicCell class] forCellWithReuseIdentifier:reuseIdentifierPic];
    [_collectionView registerClass:[ShopCollectionCell class] forCellWithReuseIdentifier:reuseIdentifierContent];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    _discountController = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection view data source methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 6;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ShopHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        cell.delegate = self;
        
        ShopModel *model = [[ShopModel alloc] init];
        [model getShopInfoWithId:_shopId block:^(NSDictionary *dic) {
            cell.titleLabel.text = dic[model.shopName];
            self.title = cell.titleLabel.text;
            cell.funsNumLabel.text = [NSString stringWithFormat:@"%@粉丝", dic[model.funsNum]];
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:dic[model.shopLogo]]
                                  placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            
            int isAtttent = [dic[model.isAttent] intValue];
            if (isAtttent == 0) {
                [cell.followButton setTitle:MyLocalizedString(@"关注") forState:UIControlStateNormal];
                cell.followButton.backgroundColor = [UIColor colorRGBWithRed:223.f green:35.f blue:84.f alpha:1.f];
                cell.followButton.enabled = NO;
            }
            if (isAtttent == 1) {
                [cell.followButton setTitle:MyLocalizedString(@"已关注") forState:UIControlStateNormal];
                cell.followButton.backgroundColor = [UIColor lightGrayColor];
                cell.followButton.enabled = YES;
            }
            
            cell.allProductNumLabel.text = dic[model.allCount];
            cell.allProductLabel.text = @"全部宝贝";
            
            cell.shopNewNumLabel.text = dic[model.itemNum];
            cell.shopNewLabel.text = @"上新";
            
            cell.discountNumLabel.text = dic[model.returnCount];
            cell.discountLabel.text = @"优惠返利";
        }];
        return cell;
    }
    if (indexPath.section == 1) {
        ShopPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierPic forIndexPath:indexPath];

        return cell;
    }
    if (indexPath.section == 2) {
        ShopCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierContent forIndexPath:indexPath];

        return cell;
    }
    
    // Configure the cell
    
    return nil;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(self.view.frame.size.width, 110);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(self.view.frame.size.width, 125);
    }
    if (indexPath.section == 2) {
        if (indexPath.row % 2 > 0) {
            return CGSizeMake(90, 120);
        }else {
            return CGSizeMake(200, 125);
        }
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2) {
        return UIEdgeInsetsMake(5.f, 5.f, 0, 5.f);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - delegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
}

#pragma mark - shop header delegate
- (void)followButtonAction
{
    
}

- (void)allProductButtonAction
{
    
}

- (void)shopNewButtonProduct
{
    
}

- (void)discountButtonAction
{
    if (_discountController == nil) {
        _discountController = [[ShopDiscountViewController alloc] init];
        _discountController.shopID = _shopId;
        [self.navigationController pushViewController:_discountController animated:YES];
    }
}
    
@end
