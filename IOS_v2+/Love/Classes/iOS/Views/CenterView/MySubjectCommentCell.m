//
//  MySubjectCommentCell.m
//  Love
//
//  Created by lee wei on 14-10-3.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MySubjectCommentCell.h"

@implementation MySubjectCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _detaileLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 8, 250, 20)];
        [self addSubview:_detaileLabel];
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

- (void)cellHeight
{
    [self layoutSubviews];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detaileLabel.textColor = [UIColor GooglePlus];
    self.detaileLabel.numberOfLines = 0;
    
    
    CGFloat sx = self.detaileLabel.frame.origin.x;
    CGFloat sy = self.detaileLabel.frame.origin.y;
    CGFloat sw = self.detaileLabel.frame.size.width;
    
//    CGSize size = [self.detaileLabel.text sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:CGSizeMake(sw, 1000.f) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize size = [self.detaileLabel.text boundingRectWithSize:CGSizeMake(sw, 1000.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
    self.detaileLabel.frame = CGRectMake(sx, sy, sw, size.height);
    
    CGFloat height = self.detailTextLabel.frame.size.height + 26.f;
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
    
    NSLog(@"%f | %f", size.height, self.frame.size.height);
}


@end
