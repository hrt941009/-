//
//  ProductMyDetailCollectionViewCell.m
//  Love
//
//  Created by use on 15-3-24.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ProductMyDetailCollectionViewCell.h"

@implementation ProductMyDetailCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ProductMyDetailCollectionViewCell" owner:self options:nil];
        
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
        self.layer.borderWidth = 2.f;
        
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _bgImageView.backgroundColor = [UIColor blackColor];
    _bgImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width *125/150);
    _title.frame = CGRectMake(2, CGRectGetMaxY(_bgImageView.frame), self.frame.size.width - 4, self.frame.size.width*21/150);
    _rmbIcon.frame = CGRectMake(3, self.frame.size.height - 13, 8, 8);
//    _price.frame = CGRectMake(15, self.frame.size.height - 21, 30, 21);
//    _markedPrice.frame = CGRectMake(45, self.frame.size.height - 18, 40, 18);
    _discount.frame = CGRectMake(self.frame.size.width - 36, self.frame.size.height - 16, 26, 13);
//    _price.adjustsFontSizeToFitWidth = YES;
//    _markedPrice.adjustsFontSizeToFitWidth = YES;
    _lineView.backgroundColor = [UIColor blackColor];
    
}

- (void)awakeFromNib {
    // Initialization code
}

@end
