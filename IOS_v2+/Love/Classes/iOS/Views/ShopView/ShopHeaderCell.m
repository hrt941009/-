//
//  ShopHeaderCell.m
//  Love
//
//  Created by lee wei on 14/12/18.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ShopHeaderCell.h"

@implementation ShopHeaderCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ShopHeaderCell" owner:self options:nil];
        
        // 如果路径不存在，return nil
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
        
        //--
        //_followButton.layer.borderColor = [[UIColor colorRGBWithRed:224.f green:68.f blue:102.f alpha:1.f] CGColor];
        //_followButton.layer.borderWidth = 1.f;
        _followButton.layer.cornerRadius = 4.f;
    }
    return self;
}

- (IBAction)followAction:(id)sender
{
    [_delegate followButtonAction];
}

- (IBAction)allProductAction:(id)sender
{
    [_delegate allProductButtonAction];
}

- (IBAction)shopNewProductAction:(id)sender
{
    [_delegate shopNewButtonProduct];
}

- (IBAction)discountAction:(id)sender
{
    [_delegate discountButtonAction];
}

@end
