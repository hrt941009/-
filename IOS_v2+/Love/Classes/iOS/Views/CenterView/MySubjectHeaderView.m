//
//  MySubjectHeaderView.m
//  Love
//
//  Created by lee wei on 14-10-3.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MySubjectHeaderView.h"

@implementation MySubjectHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MySubjectHeaderView" owner:self options:nil] lastObject];
        
        self.backgroundColor = [UIColor clearColor];
        
        _nickNameLabel.textColor = [UIColor colorRGBWithRed:254.f green:100.f blue:138.f alpha:1.f];
        _signLabel.textColor = [UIColor whiteColor];
        _emailLabel.textColor = [UIColor whiteColor];
        
        _createTag.layer.masksToBounds = YES;
        _createTag.layer.cornerRadius = 3.f;
        
        [_createTag setTitle:@"+ 创建标签" forState:UIControlStateNormal];
        [_createTag setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    CGFloat sx = self.signLabel.frame.origin.x;
//    CGFloat sy = self.signLabel.frame.origin.y;
//    CGFloat sw = self.signLabel.frame.size.width;
////    CGSize size = [self.signLabel.text sizeWithFont:[UIFont systemFontOfSize:12.f] constrainedToSize:CGSizeMake(sw, 50.f) lineBreakMode:NSLineBreakByWordWrapping];
//    CGSize size = [self.signLabel.text boundingRectWithSize:CGSizeMake(sw, 50.f) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} context:nil].size;
    
    self.signLabel.frame = CGRectMake(8, 83, kScreenWidth - 16, 30);
    self.iconView.frame = CGRectMake((kScreenWidth - 75)/2, 16, 75, 75);
    self.createTag.frame = CGRectMake((kScreenWidth - 98)/2, 114, 98, 29);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)createNewTagAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(careteNewTag)]) {
        [_delegate careteNewTag];
    }
}
@end
