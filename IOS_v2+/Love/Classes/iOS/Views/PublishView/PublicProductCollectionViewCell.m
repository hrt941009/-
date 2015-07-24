//
//  PublicProductCollectionViewCell.m
//  Love
//
//  Created by use on 15-3-27.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "PublicProductCollectionViewCell.h"

@implementation PublicProductCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"PublicProductCollectionViewCell" owner:self options:nil];
        
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
        self.layer.borderWidth = 0.5f;
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    _bgImageView.frame = CGRectMake(0, 0, (kScreenWidth - 30)/3, (kScreenWidth - 30)/3);
    _bgImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _tagLabel.frame = CGRectMake(2, self.frame.size.height - 14, 29, 11);
    _tagLabel.font = [UIFont systemFontOfSize:9.f];
    _tagLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _tagLabel.textColor = [UIColor colorWithWhite:1 alpha:0.8];
    _tagLabel.layer.masksToBounds = YES;
    _tagLabel.layer.cornerRadius = 3.f;
    _tagLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
