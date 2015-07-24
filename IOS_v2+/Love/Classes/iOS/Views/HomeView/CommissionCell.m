//
//  CommissionCell.m
//  Love
//
//  Created by 李伟 on 14-8-23.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CommissionCell.h"

const CGFloat kCommissionCellBgViewMargin = 14.f;
const CGFloat kCommissionCellBgViewWidth  = 150.f;

@implementation CommissionCell


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [[UIColor colorRGBWithRed:225.f green:224.f blue:220.f alpha:1] CGColor];
        self.layer.borderWidth = 1.f;
        self.layer.cornerRadius = 2.f;
    }
    return self;
}

- (UIImageView *)picImageView {
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.contentMode = UIViewContentModeScaleAspectFill;
        _picImageView.clipsToBounds = YES;
        [self addSubview:_picImageView];
    }
    return _picImageView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_lineView];
    }
    return _lineView;
}

//- (UIView *)discountView {
//    if (!_discountView) {
//        _discountView = [[UIView alloc] init];
//        _discountView.backgroundColor = [UIColor whiteColor];
//        [self.picImageView addSubview:_discountView];
//    }
//    return _discountView;
//}

- (UIImageView *)likeImageView {
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] init];
        _likeImageView.contentMode = UIViewContentModeScaleAspectFill;
        _likeImageView.clipsToBounds = YES;
        [self addSubview:_likeImageView];
    }
    return _likeImageView;
}

- (UIImageView *)subjectImageView {
    if (!_subjectImageView) {
        _subjectImageView = [[UIImageView alloc] init];
        _subjectImageView.contentMode = UIViewContentModeScaleAspectFill;
        _subjectImageView.clipsToBounds = YES;
        [self addSubview:_subjectImageView];
    }
    return _subjectImageView;
}


- (UIImageView *)commentImageView {
    if (!_commentImageView) {
        _commentImageView = [[UIImageView alloc] init];
        _commentImageView.contentMode = UIViewContentModeScaleAspectFill;
        _commentImageView.clipsToBounds = YES;
        [self addSubview:_commentImageView];
    }
    return _commentImageView;
}


- (UILabel *)sellerLabel {
    if (!_sellerLabel) {
        _sellerLabel = [[UILabel alloc] init];
        _sellerLabel.backgroundColor = [UIColor clearColor];
        _sellerLabel.textColor = [UIColor blackColor];
        _sellerLabel.numberOfLines = 1;
        _sellerLabel.textAlignment = NSTextAlignmentLeft;
        _sellerLabel.font = [UIFont systemFontOfSize:14.f];
        _sellerLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_sellerLabel];
    }
    return _sellerLabel;
}


- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.textColor = [UIColor darkGrayColor];
        _descLabel.numberOfLines = 2;
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.font = [UIFont systemFontOfSize:11.f];
        [self addSubview:_descLabel];
    }
    return _descLabel;
}

- (UILabel *)oldPriceLabel {
    if (!_oldPriceLabel) {
        _oldPriceLabel = [[UILabel alloc] init];
        _oldPriceLabel.backgroundColor = [UIColor clearColor];
        _oldPriceLabel.textColor = [UIColor lightGrayColor];
        _oldPriceLabel.numberOfLines = 1;
        _oldPriceLabel.textAlignment = NSTextAlignmentLeft;
        _oldPriceLabel.font = [UIFont systemFontOfSize:10.f];
        _oldPriceLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_oldPriceLabel];
    }
    return _oldPriceLabel;
}


- (UILabel *)newPriceLabel {
    if (!_newPriceLabel) {
        _newPriceLabel = [[UILabel alloc] init];
        _newPriceLabel.backgroundColor = [UIColor clearColor];
        _newPriceLabel.textColor = [UIColor Dribbble];
        _newPriceLabel.numberOfLines = 1;
        _newPriceLabel.textAlignment = NSTextAlignmentLeft;
        _newPriceLabel.font = [UIFont systemFontOfSize:14.f];
        _newPriceLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_newPriceLabel];
    }
    return _newPriceLabel;
}


- (UILabel *)discountDataLabel {
    if (!_discountDataLabel) {
        _discountDataLabel = [[UILabel alloc] init];
        _discountDataLabel.backgroundColor = [UIColor clearColor];
        _discountDataLabel.textColor = [UIColor lightGrayColor];
        _discountDataLabel.numberOfLines = 1;
        _discountDataLabel.textAlignment = NSTextAlignmentLeft;
        _discountDataLabel.font = [UIFont systemFontOfSize:10.f];
        _discountDataLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_discountDataLabel];
    }
    return _discountDataLabel;
}


- (UILabel *)commissonLabel {
    if (!_commissonLabel) {
        _commissonLabel = [[UILabel alloc] init];
        _commissonLabel.backgroundColor = [UIColor GoogleYellow];
        _commissonLabel.textColor = [UIColor whiteColor];
        _commissonLabel.numberOfLines = 1;
        _commissonLabel.textAlignment = NSTextAlignmentCenter;
        _commissonLabel.font = [UIFont systemFontOfSize:8.f];
        _commissonLabel.adjustsFontSizeToFitWidth = YES;
        [self.picImageView addSubview:_commissonLabel];
    }
    return _commissonLabel;
}

- (UILabel *)discountLabel {
    if (!_discountLabel) {
        _discountLabel = [[UILabel alloc] init];
        _discountLabel.backgroundColor = [UIColor GooglePlus];
        _discountLabel.textColor = [UIColor whiteColor];
        _discountLabel.numberOfLines = 1;
        _discountLabel.textAlignment = NSTextAlignmentCenter;
        _discountLabel.font = [UIFont systemFontOfSize:8.f];
        _discountLabel.adjustsFontSizeToFitWidth = YES;
        [self.picImageView addSubview:_discountLabel];
    }
    return _discountLabel;
}


- (UILabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.backgroundColor = [UIColor clearColor];
        _likeLabel.textColor = [UIColor darkGrayColor];
        _likeLabel.numberOfLines = 1;
        _likeLabel.textAlignment = NSTextAlignmentLeft;
        _likeLabel.font = [UIFont systemFontOfSize:11.f];
        _likeLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_likeLabel];
    }
    return _likeLabel;
}

- (UILabel *)subjectLabel {
    if (!_subjectLabel) {
        _subjectLabel = [[UILabel alloc] init];
        _subjectLabel.backgroundColor = [UIColor clearColor];
        _subjectLabel.textColor = [UIColor darkGrayColor];
        _subjectLabel.numberOfLines = 1;
        _subjectLabel.textAlignment = NSTextAlignmentLeft;
        _subjectLabel.font = [UIFont systemFontOfSize:11.f];
        _subjectLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_subjectLabel];
    }
    return _subjectLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.backgroundColor = [UIColor clearColor];
        _commentLabel.textColor = [UIColor darkGrayColor];
        _commentLabel.numberOfLines = 1;
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        _commentLabel.font = [UIFont systemFontOfSize:11.f];
        _commentLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_commentLabel];
    }
    return _commentLabel;
}

- (void)layoutSubviews {
        
    CGFloat picOriginX = 4.f;
    CGFloat picWidth = kCommissionCellBgViewWidth - picOriginX * 5;
    
    self.picImageView.frame = CGRectMake(picOriginX, 2.f, picWidth, 126.f);
    
    //self.discountView.frame = CGRectMake(picWidth - 42.f, 2.f, 42.f, 39.f);
    self.commissonLabel.frame = CGRectMake(picWidth - 40.f, 1.f, 42.f, 16.f);
    self.discountLabel.frame = CGRectMake(picWidth - 42.f, 21.f, 42.f, 16.f);
    
    //--------
    self.sellerLabel.frame = CGRectMake(picOriginX, CGRectGetMaxY(self.picImageView.frame), picWidth, 20.f);
    
    self.descLabel.frame = CGRectMake(picOriginX, CGRectGetMaxY(self.sellerLabel.frame), picWidth, 30.f);
    
    self.oldPriceLabel.frame = CGRectMake(picOriginX, CGRectGetMaxY(self.descLabel.frame), 50.f, 14.f);
    self.lineView.frame = CGRectMake(picOriginX - 1.f, CGRectGetMaxY(self.descLabel.frame) + 7.f, 52.f, 1.f);
    
    self.discountDataLabel.frame = CGRectMake(CGRectGetMaxX(self.oldPriceLabel.frame) + 20.f, self.oldPriceLabel.frame.origin.y, 40.f, 14.f);
    
    self.newPriceLabel.frame = CGRectMake(picOriginX, CGRectGetMaxY(self.oldPriceLabel.frame), 90, 20.f);

    //------------
    self.likeImageView.frame = CGRectMake(picOriginX + 4.f, CGRectGetMaxY(self.newPriceLabel.frame), 14.f, 12.f);
    self.likeImageView.image = [UIImage imageNamed:@"喜欢白"];
    self.likeLabel.frame = CGRectMake(CGRectGetMaxX(self.likeImageView.frame) + 2.f, self.likeImageView.frame.origin.y, 32.f, 14.f);
    
    self.subjectImageView.frame = CGRectMake(CGRectGetMaxX(self.likeLabel.frame) + 2.f, CGRectGetMaxY(self.newPriceLabel.frame), 12.f, 12.f);
    self.subjectImageView.image = [UIImage imageNamed:kDefalutFlagImageDownload];
    self.subjectLabel.frame = CGRectMake(CGRectGetMaxX(self.subjectImageView.frame)+ 2.f, self.likeImageView.frame.origin.y, 32.f, 14.f);
    
    self.commentImageView.frame = CGRectMake(CGRectGetMaxX(self.subjectLabel.frame) + 2.f, CGRectGetMaxY(self.newPriceLabel.frame), 12.f, 12.f);
    self.commentImageView.image = [UIImage imageNamed:@"评论"];
    self.commentLabel.frame = CGRectMake(CGRectGetMaxX(self.commentImageView.frame)+ 2.f, self.likeImageView.frame.origin.y, 32.f, 14.f);
    
    
}

@end
