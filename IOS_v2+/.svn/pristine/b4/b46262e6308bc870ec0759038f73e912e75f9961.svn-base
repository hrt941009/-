//
//  MyMessageTableViewCell.h
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyMessageCellDelegate <NSObject>

- (void)myMessageCellKeyboardDidShow;

@end

@interface MyMessageTableViewCell : UITableViewCell<UITextViewDelegate>

@property (nonatomic, weak) id<MyMessageCellDelegate> delegate;

@end
