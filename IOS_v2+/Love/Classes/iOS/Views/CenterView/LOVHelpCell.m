//
//  LOVHelpCell.m
//  Love
//
//  Created by lee wei on 14-10-4.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "LOVHelpCell.h"

@implementation LOVHelpCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 0, self.frame.size.width - 10.f, 24.f)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.numberOfLines = 0;
        [self addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.f, CGRectGetMaxY(_titleLabel.frame), _titleLabel.frame.size.width, 24.f)];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:14.f];
        _contentLabel.numberOfLines = 0;
        _contentLabel.hidden = NO;
        [self addSubview:_contentLabel];
    }
    return self;
}

- (void)setCellHeight
{
    [self layoutSubviews];
}

- (void)showContentLabel:(BOOL)show
{
    if (!show) {
        self.contentLabel.hidden = NO;
        CGRect rect = self.frame;
        rect.size.height = 44.f;
        self.frame = rect;
    }
    if (show) {

        self.contentLabel.hidden = NO;


    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGSize size = [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:CGSizeMake(300.f, 1000.f) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize size = [self.titleLabel.text boundingRectWithSize:CGSizeMake(300.f, 1000.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
    CGRect contentRect = self.titleLabel.frame;
    contentRect.size.height = size.height;
    self.titleLabel.frame = contentRect;
    
    CGRect rect = self.frame;
    rect.size.height = self.titleLabel.frame.size.height + 26.f;
    self.frame = rect;
    
    NSLog(@"--------------- %f", self.frame.size.height);
    
    [UIView animateWithDuration:1.f
                          delay:0
                        options:0
                     animations:^{
                         
                         
                     } completion:nil];
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

@end
