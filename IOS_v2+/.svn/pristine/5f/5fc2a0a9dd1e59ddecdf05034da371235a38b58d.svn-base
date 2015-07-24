//
//  MyMessageTableViewCell.m
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MyMessageTableViewCell.h"
#import "BuyBackgroundView.h"

@implementation MyMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        BuyBackgroundView *bgView = [[BuyBackgroundView alloc] initWithFrame:CGRectMake(5.f, 0, self.frame.size.width - 10.f, 72.f)];
        [self.contentView addSubview:bgView];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300.f, 72.f)];
        textView.backgroundColor = [UIColor clearColor];
        textView.delegate = self;
        textView.returnKeyType = UIReturnKeyDone;
        textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textView.font = [UIFont systemFontOfSize:14.f];
        textView.textColor = [UIColor darkGrayColor];
        textView.text = MyLocalizedString(@"留言提示");
        textView.layer.cornerRadius = 6.f;
        [bgView addSubview:textView];
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


#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    
    [_delegate myMessageCellKeyboardDidShow];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
