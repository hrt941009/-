//
//  CCCommentTableViewCell.m
//  Love
//
//  Created by lee wei on 14-9-1.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CCCommentTableViewCell.h"

@implementation CCCommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorRGBWithRed:229.f green:229.f blue:229.f alpha:1.f];
        replayHeight = 0;
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

- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_headerView];
    }
    return _headerView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font = [UIFont systemFontOfSize:12.f];
        _nameLabel.textColor = [UIColor colorRGBWithRed:37.f green:114.f blue:165.f alpha:1.f];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)cdateLabel
{
    if (!_cdateLabel) {
        _cdateLabel = [[UILabel alloc] init];
        _cdateLabel.backgroundColor = [UIColor clearColor];
        _cdateLabel.font = [UIFont systemFontOfSize:12.f];
        _cdateLabel.textColor = [UIColor darkGrayColor];
        _cdateLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_cdateLabel];
    }
    return _cdateLabel;
}

- (UILabel *)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.backgroundColor = [UIColor clearColor];
        _commentLabel.font = [UIFont systemFontOfSize:14.f];
        _commentLabel.textColor = [UIColor darkGrayColor];
        _commentLabel.numberOfLines = 0;
        [self.contentView addSubview:_commentLabel];
    }
    return _commentLabel;
}

/*
- (UILabel *)iLabel
{
    if (!_iLabel) {
        _iLabel = [[UILabel alloc] init];
        _iLabel.backgroundColor = [UIColor clearColor];
        _iLabel.font = [UIFont systemFontOfSize:15.f];
        _iLabel.textColor = [UIColor GooglePlus];
        [self addSubview:_iLabel];
    }
    return _iLabel;
}
- (UILabel *)replayLabel
{
    if (!_replayLabel) {
        _replayLabel = [[UILabel alloc] init];
        _replayLabel.backgroundColor = [UIColor clearColor];
        _replayLabel.font = [UIFont systemFontOfSize:14.f];
        _replayLabel.textColor = [UIColor darkGrayColor];
        _replayLabel.numberOfLines = 0;
        [self addSubview:_replayLabel];
    }
    return _replayLabel;
}
*/

- (CGFloat)setCellHeight
{
    [self layoutSubviews];
    CGFloat height = 0;
    height =  CGRectGetMaxY(_nameLabel.frame) + _commentLabel.frame.size.height;// + _replayLabel.frame.size.height;
    return height;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _headerView.frame = CGRectMake(5.f, 2.f, 40.f, 40.f);
    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headerView.frame) + 10.f, 0, 180.f, 22.f);
    _cdateLabel.frame = CGRectMake(kScreenWidth - 90.f, 0, 80.f, 22.f);
    
//    CGSize commentSize = [_commentLabel.text sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:CGSizeMake(_commentLabel.frame.size.width, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    CGSize commentSize = [_commentLabel.text boundingRectWithSize:CGSizeMake(_commentLabel.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
    _commentLabel.frame = CGRectMake(_nameLabel.frame.origin.x, CGRectGetMaxY(_nameLabel.frame), kScreenWidth - 70.f, commentSize.height);

    /*
    _iLabel.frame = CGRectMake(20.f, CGRectGetMaxY(_commentLabel.frame) + 1.f, 40.f, 30.f);
    if ([_replayLabel.text length] < 30.f) {
        replayHeight = 30.f;
    }else{
        CGSize replaySize = [_replayLabel.text sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:CGSizeMake(_replayLabel.frame.size.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        replayHeight = replaySize.height;
    }
    _replayLabel.frame = CGRectMake(CGRectGetMaxX(_iLabel.frame) + 1.f, _iLabel.frame.origin.y, 220.f, replayHeight);
     */
    
//    CGRect commentRect = _commentLabel.frame;
//    commentRect.size.height = commentSize.height;
//    _commentLabel.frame = commentRect;
// 
//    CGRect replayRect = _replayLabel.frame;
//    replayRect.size.height = replaySize.height;
//    replayRect.origin.y = CGRectGetMaxY(_commentLabel.frame) + 1.f;

}

@end
