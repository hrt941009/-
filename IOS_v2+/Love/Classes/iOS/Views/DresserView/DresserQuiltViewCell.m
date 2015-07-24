//
//  DresserQuiltViewCell.m
//  Love
//
//  Created by lee wei on 14-10-6.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "DresserQuiltViewCell.h"


@implementation DresserQuiltViewCell

//- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        // 初始化时加载collectionCell.xib文件
//        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"DresserQuiltViewCell" owner:self options:nil];
//        
//        // 如果路径不存在，return nil
//        if (arrayOfViews.count < 1)
//        {
//            return nil;
//        }
//        // 如果xib中view不属于UICollectionViewCell类，return nil
//        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
//        {
//            return nil;
//        }
//        // 加载nib
//        self = [arrayOfViews objectAtIndex:0];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        _photoView = [[UIImageView alloc] init];
        _photoView.contentMode = UIViewContentModeScaleAspectFill;
        _photoView.clipsToBounds = YES;
        [self addSubview:_photoView];
        
        _headerIconView = [[UIView alloc] init];
        _headerIconView.backgroundColor = [UIColor clearColor];
        [self addSubview:_headerIconView];
        
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.backgroundColor = [UIColor clearColor];
        _userNameLabel.textColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.6];
        _userNameLabel.font = [UIFont systemFontOfSize:14.f];
        _userNameLabel.textAlignment = NSTextAlignmentCenter;
        _userNameLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_userNameLabel];
        
        _addressIconView = [[UIImageView alloc] init];
        _addressIconView.image = [UIImage imageNamed:@"icon_location"];
        [self addSubview:_addressIconView];
        
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.backgroundColor = [UIColor clearColor];
        _addressLabel.textColor = [UIColor darkGrayColor];
        _addressLabel.font = [UIFont systemFontOfSize:11.f];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_addressLabel];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor clearColor];
        _lineView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _lineView.layer.borderWidth = 0.3;
        [self addSubview:_lineView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _publishTimeLabel = [[UILabel alloc] init];
        _publishTimeLabel.backgroundColor = [UIColor clearColor];
        _publishTimeLabel.textColor = [UIColor darkGrayColor];
        _publishTimeLabel.font = [UIFont systemFontOfSize:11.f];
        _publishTimeLabel.textAlignment = NSTextAlignmentCenter;
        _publishTimeLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_publishTimeLabel];
        
        _likeIconView = [[UIImageView alloc] init];
        _likeIconView.image = [UIImage imageNamed:@"喜欢白"];
        [self addSubview:_likeIconView];
        
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.backgroundColor = [UIColor clearColor];
        _likeLabel.textColor = [UIColor darkGrayColor];
        _likeLabel.font = [UIFont systemFontOfSize:12.f];
        _likeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_likeLabel];
        
        _commentIconView = [[UIImageView alloc] init];
        _commentIconView.image = [UIImage imageNamed:@"评论"];
        [self addSubview:_commentIconView];
        
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.backgroundColor = [UIColor clearColor];
        _commentLabel.textColor = [UIColor darkGrayColor];
        _commentLabel.font = [UIFont systemFontOfSize:12.f];
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_commentLabel];
    }
    return self;
}

//
//- (UIImageView *)photoView {
//    if (!_photoView) {
//        _photoView = [[UIImageView alloc] init];
//        _photoView.contentMode = UIViewContentModeScaleAspectFill;
//        _photoView.clipsToBounds = YES;
//        [self addSubview:_photoView];
//    }
//    return _photoView;
//}
//
//- (UIView *)headerIconView {
//    if (!_headerIconView) {
//        _headerIconView = [[UIView alloc] init];
//        _headerIconView.backgroundColor = [UIColor clearColor];
//        [self addSubview:_headerIconView];
//    }
//    return _headerIconView;
//}
//
//- (UILabel *)userNameLabel {
//    if (!_userNameLabel) {
//        _userNameLabel = [[UILabel alloc] init];
//        _userNameLabel.backgroundColor = [UIColor clearColor];
//        _userNameLabel.textColor = [UIColor GooglePlus];
//        _userNameLabel.font = [UIFont systemFontOfSize:14.f];
//        _userNameLabel.textAlignment = NSTextAlignmentLeft;
//        _userNameLabel.adjustsFontSizeToFitWidth = YES;
//        [self addSubview:_userNameLabel];
//    }
//    return _userNameLabel;
//}
//
//- (UIImageView *)addressIconView {
//    if (!_addressIconView) {
//        _addressIconView = [[UIImageView alloc] init];
//        _addressIconView.image = [UIImage imageNamed:@"卖家位置icon"];
//        [self addSubview:_addressIconView];
//    }
//    return _addressIconView;
//}
//
//- (UILabel *)addressLabel {
//    if (!_addressLabel) {
//        _addressLabel = [[UILabel alloc] init];
//        _addressLabel.backgroundColor = [UIColor clearColor];
//        _addressLabel.textColor = [UIColor darkGrayColor];
//        _addressLabel.font = [UIFont systemFontOfSize:11.f];
//        _addressLabel.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:_addressLabel];
//    }
//    return _addressLabel;
//}
//
//- (UIView *)lineView {
//    if (!_lineView) {
//        _lineView = [[UIView alloc] init];
//        _lineView.backgroundColor = [UIColor clearColor];
//        _lineView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//        _lineView.layer.borderWidth = 0.3;
//        [self addSubview:_lineView];
//    }
//    return _lineView;
//}
//
//- (UILabel *)titleLabel {
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.backgroundColor = [UIColor clearColor];
//        _titleLabel.textColor = [UIColor blackColor];
//        _titleLabel.font = [UIFont systemFontOfSize:14.f];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        [self addSubview:_titleLabel];
//    }
//    return _titleLabel;
//}
//
//- (UILabel *)publishTimeLabel {
//    if (!_publishTimeLabel) {
//        _publishTimeLabel = [[UILabel alloc] init];
//        _publishTimeLabel.backgroundColor = [UIColor clearColor];
//        _publishTimeLabel.textColor = [UIColor darkGrayColor];
//        _publishTimeLabel.font = [UIFont systemFontOfSize:11.f];
//        _publishTimeLabel.textAlignment = NSTextAlignmentCenter;
//        _publishTimeLabel.adjustsFontSizeToFitWidth = YES;
//        [self addSubview:_publishTimeLabel];
//    }
//    return _publishTimeLabel;
//}
//
//- (UIImageView *)likeIconView {
//    if (!_likeIconView) {
//        _likeIconView = [[UIImageView alloc] init];
//        _likeIconView.image = [UIImage imageNamed:@"喜欢白"];
//        [self addSubview:_likeIconView];
//    }
//    return _likeIconView;
//}
//
//- (UILabel *)likeLabel {
//    if (!_likeLabel) {
//        _likeLabel = [[UILabel alloc] init];
//        _likeLabel.backgroundColor = [UIColor clearColor];
//        _likeLabel.textColor = [UIColor darkGrayColor];
//        _likeLabel.font = [UIFont systemFontOfSize:12.f];
//        _likeLabel.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:_likeLabel];
//    }
//    return _likeLabel;
//}
//
//
//- (UIImageView *)commentIconView {
//    if (!_commentIconView) {
//        _commentIconView = [[UIImageView alloc] init];
//        _commentIconView.image = [UIImage imageNamed:@"评论"];
//        [self addSubview:_commentIconView];
//    }
//    return _commentIconView;
//}
//
//- (UILabel *)commentLabel {
//    if (!_commentLabel) {
//        _commentLabel = [[UILabel alloc] init];
//        _commentLabel.backgroundColor = [UIColor clearColor];
//        _commentLabel.textColor = [UIColor darkGrayColor];
//        _commentLabel.font = [UIFont systemFontOfSize:12.f];
//        _commentLabel.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:_commentLabel];
//    }
//    return _commentLabel;
//}
//
//- (void)setCellHeight
//{
////    [self layoutSubviews];
////    CGRect rect = self.frame;
////    rect.size.height = CGRectGetMaxY(self.commentLabel.frame) + 4.f;
////    self.frame = rect;
//}


- (void)layoutSubviews {
    [super layoutSubviews];
//    CGFloat photoHeight = self.photoView.image.size.height;
//    self.photoView.frame = CGRectMake(0, 0, self.frame.size.width, photoHeight);
    self.headerIconView.frame = CGRectMake(8.f, CGRectGetMaxY(self.photoView.frame) - 6.f, 30.f, 30.f);
    self.userNameLabel.frame = CGRectMake(0, CGRectGetMaxY(self.photoView.frame), self.frame.size.width, 24.f);
    self.addressIconView.frame = CGRectMake(2.f, CGRectGetMaxY(self.headerIconView.frame) + 1.f, 11.f, 15.f);
    self.addressLabel.frame = CGRectMake(18.f, CGRectGetMaxY(self.headerIconView.frame), self.frame.size.width - 20.f, 18.f);
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.addressLabel.frame), self.frame.size.width, 1.f);
    self.titleLabel.frame = CGRectMake(2.f, CGRectGetMaxY(self.lineView.frame), self.frame.size.width - 4.f, 26.f);
    self.publishTimeLabel.frame = CGRectMake(2.f, CGRectGetMaxY(self.titleLabel.frame), self.frame.size.width - 4.f, 18.f);
    self.likeIconView.frame = CGRectMake(30.f, CGRectGetMaxY(self.publishTimeLabel.frame) + 4.f, 12.f, 10.f);
    self.likeLabel.frame = CGRectMake(45.f, self.likeIconView.frame.origin.y - 4.f, 42.f, 18.f);
    self.commentIconView.frame = CGRectMake(CGRectGetMaxX(self.likeLabel.frame)+ 5.f, self.likeIconView.frame.origin.y, 12.f, 12.f);
    self.commentLabel.frame = CGRectMake(CGRectGetMaxX(self.commentIconView.frame) + 5.f, self.likeIconView.frame.origin.y - 4.f, 42.f, 18.f);
    
    
}

@end
