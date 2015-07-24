//
//  CommodityDetailTableViewCell.m
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CommodityDetailTableViewCell.h"
#import "BuyBackgroundView.h"
#import "UIImageView+WebCache.h"

@implementation CommodityDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _imageArray = [[NSMutableArray alloc] init];
        
        _bgView = [[BuyBackgroundView alloc] initWithFrame:CGRectMake(5.f, 0, self.frame.size.width - 10.f, 130.f)];
        [self.contentView addSubview:_bgView];

        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 100.f, _bgView.frame.size.width - 10.f, 24.f)];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.font = [UIFont systemFontOfSize:12.f];
        _detailLabel.numberOfLines = 0;
        [_bgView addSubview:_detailLabel];

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (CGFloat)setCellHeight
{
    CGFloat height = 0;
    
    CGSize imageSize = CGSizeMake(94.f, 94.f);
    UIImageView *imageView = nil;
    if ([_imageArray count] > 0) {
        NSUInteger count = 0;
        NSUInteger imageCount = [_imageArray count];
        if (imageCount <= 3) {
            count = imageCount;
        }else{
            count = 3;
        }
        for (NSUInteger i = 0; i < count; i++) {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(4.f + i * (imageSize.width + 5.f) , 4.f, imageSize.width, imageSize.height)];
            [imageView sd_setImageWithURL:_imageArray[i] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            imageView.tag = i;
            imageView.backgroundColor = [UIColor clearColor];
            imageView.userInteractionEnabled = YES;
            [_bgView addSubview:imageView];
            
            //UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
            //[imageView addGestureRecognizer:tgr];
        }
    }
    
//    CGSize size = [_detailLabel.text sizeWithFont:[UIFont systemFontOfSize:12.f]
//                                constrainedToSize:CGSizeMake(_detailLabel.frame.size.width, 2000)
//                                    lineBreakMode:NSLineBreakByCharWrapping];
    CGSize size = [_detailLabel.text boundingRectWithSize:CGSizeMake(_detailLabel.frame.size.width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} context:nil].size;
    CGRect detailRect = _detailLabel.frame;
    detailRect.size.height = size.height;
    _detailLabel.frame = detailRect;
    
    CGRect bgViewRect = _bgView.frame;
    bgViewRect.size.height = 100.f + size.height;
    _bgView.frame = bgViewRect;
    
    height = _bgView.frame.size.height;
    
    return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
