//
//  HomeSubjectCollectionCell.m
//  Love
//
//  Created by lee wei on 14-10-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "HomeSubjectCollectionCell.h"

@implementation HomeSubjectCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"HomeSubjectCollectionCell" owner:self options:nil];
        
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
        self.layer.borderColor = [[UIColor colorRGBWithRed:197.f green:197.f blue:197.f alpha:1.f] CGColor];
        self.layer.borderWidth = 1.f;
        //--
        _subjectId = [[UILabel alloc] init];
        _subjectTitleLabel.backgroundColor = [UIColor colorRGBWithRed:127 green:127 blue:127 alpha:0.7];
        _subjectTitleLabel.textColor = [UIColor colorRGBWithRed:255.f green:255.f blue:255.f alpha:0.7];
        _subjectTitleLabel.layer.masksToBounds = YES;
        _subjectTitleLabel.layer.cornerRadius = 2.f;
        _subjectTitleLabel.font = [UIFont systemFontOfSize:13.f];
        _likeNumLable.textColor = [UIColor colorRGBWithRed:188 green:188 blue:188 alpha:1];
        [self addSubview:_subjectId];
        _subjectTitleLabel.backgroundColor = [UIColor colorRGBWithRed:1.f green:1.f blue:1.f alpha:0.5];
        _followBackButton.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _subjectImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    _subjectTitleLabel.frame = CGRectMake(4.f, self.frame.size.height - 19.f, 35.f, 15.f);
    
    _followBackButton.frame = CGRectMake(self.frame.size.width - 50, 0, 50, 50);
    
    _followIconImage.frame = CGRectMake(self.frame.size.width - 23, 3, 20, 21);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)followTagAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(getClickedButton:)]) {
        [_delegate getClickedButton:sender];
    }
}
@end
