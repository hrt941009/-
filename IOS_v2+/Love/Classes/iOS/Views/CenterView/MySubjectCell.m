//
//  MySubjectCell.m
//  Love
//
//  Created by 李伟 on 14/11/10.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MySubjectCell.h"

//static CGFloat const headerHeight = 23.f;

@implementation MySubjectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _conImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 15, 100, 80)];
        _conImageView.backgroundColor = [UIColor clearColor];
//        _conImageView.layer.borderColor = [[UIColor colorRGBWithRed:165.f green:165.f blue:165.f alpha:1.f] CGColor];
//        _conImageView.layer.borderWidth = 1.f;
        _conImageView.layer.masksToBounds = YES;
        _conImageView.layer.cornerRadius = 3.f;
        [self.contentView addSubview:_conImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 15, kScreenWidth - 150, 30)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.numberOfLines = 4;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        _introLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 45, kScreenWidth - 150, 50)];
        _introLabel.textColor = [UIColor lightGrayColor];
        _introLabel.font = [UIFont systemFontOfSize:14.f];
        _introLabel.numberOfLines = 0;
        _introLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_introLabel];
        
        
        
        
//        _conImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5.f, 5.f, self.frame.size.width - 10.f, 217.f)];
//        _conImageView.backgroundColor = [UIColor clearColor];
//        _conImageView.layer.borderColor = [[UIColor colorRGBWithRed:165.f green:165.f blue:165.f alpha:1.f] CGColor];
//        _conImageView.layer.borderWidth = 1.f;
//        [self.contentView addSubview:_conImageView];
//        
//        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.backgroundColor = [UIColor colorRGBWithRed:56.f green:55.f blue:53.f alpha:0.75];
//        _titleLabel.textColor = [UIColor whiteColor];
//        _titleLabel.font = [UIFont systemFontOfSize:14.f];
//        _titleLabel.numberOfLines = 4;
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        [_conImageView addSubview:_titleLabel];
//        
//        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _conImageView.frame.size.height - headerHeight, _conImageView.frame.size.width, headerHeight)];
//        bottomView.backgroundColor = [UIColor colorRGBWithRed:56.f green:55.f blue:53.f alpha:0.75];
//        [_conImageView addSubview:bottomView];
//
//        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(180.f, 0, 60.f, headerHeight)];
//        _commentLabel.backgroundColor = [UIColor clearColor];
//        _commentLabel.textColor = [UIColor colorRGBWithRed:255.f green:68.f blue:114.f alpha:1.f];
//        _commentLabel.font = [UIFont systemFontOfSize:11.f];
//        _commentLabel.adjustsFontSizeToFitWidth = YES;
//        [bottomView addSubview:_commentLabel];
//        
//        
//        _likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_commentLabel.frame) + 5.f, 0, 60.f, headerHeight)];
//        _likeLabel.backgroundColor = [UIColor clearColor];
//        _likeLabel.textColor = [UIColor colorRGBWithRed:255.f green:68.f blue:114.f alpha:1.f];
//        _likeLabel.font = [UIFont systemFontOfSize:11.f];
//        _likeLabel.adjustsFontSizeToFitWidth = YES;
//        [bottomView addSubview:_likeLabel];
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

//- (void)layoutSubviews
//{
//    CGSize size = [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:CGSizeMake(_conImageView.frame.size.width, 86.f) lineBreakMode:NSLineBreakByWordWrapping];
//    CGFloat height = 0;
//    if (size.height < headerHeight) {
//        height = headerHeight;
//    }else{
//        height = size.height;
//    }
//    self.titleLabel.frame = CGRectMake(0, 0, _conImageView.frame.size.width, height);
//}

@end
