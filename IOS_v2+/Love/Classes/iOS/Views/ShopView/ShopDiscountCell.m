//
//  ShopDiscountCell.m
//  Love
//
//  Created by lee wei on 14/12/21.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ShopDiscountCell.h"

@implementation ShopDiscountCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ShopDiscountCell" owner:self options:nil];
        
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
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
