//
//  CommissionCollectionCell.m
//  Love
//
//  Created by lee wei on 14-10-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CommissionCollectionCell.h"

const CGFloat kCommissionCellBgViewMargin = 14.f;
const CGFloat kCommissionCellBgViewWidth  = 150.f;

@implementation CommissionCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CommissionCollectionCell" owner:self options:nil];
        
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
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [[UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.1] CGColor];
        self.layer.borderWidth = 1.f;
        
        
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _myLabel.backgroundColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.5];
    
    _myLabel.layer.masksToBounds = YES;
    _myLabel.layer.cornerRadius = 3.f;
    _titleLabel.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.8f];
    _likeNum.textColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.6f];
    _lineView.backgroundColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.1];
    
    _picImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width * 125 / 148);
    _myLabel.frame = CGRectMake(4, _picImageView.frame.size.height - 19, 37, 15);
    _myLabel.font = [UIFont systemFontOfSize:13.f];
    _lineView.frame = CGRectMake(0, _picImageView.frame.size.height + 1, self.frame.size.width, 1);
    _titleLabel.frame = CGRectMake(5, _picImageView.frame.size.height + 2, self.frame.size.width - 2, 18);
    _introLabel.frame = CGRectMake(5, _picImageView.frame.size.height + 20, self.frame.size.width - 5, 15);
}

@end
