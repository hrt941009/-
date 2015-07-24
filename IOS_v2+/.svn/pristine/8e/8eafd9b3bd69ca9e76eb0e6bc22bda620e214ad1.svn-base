//
//  CCDetailTableViewCell.m
//  Love
//
//  Created by lee wei on 14-9-1.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CCDetailTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation CCDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 320.f)];
        _cImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_cImageView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)commImageView:(CGRect)frame
{
    _cImageView.frame = frame;// = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 320.f)];
   // _cImageView.backgroundColor = [UIColor clearColor];
    //[self addSubview:_cImageView];
}

@end
