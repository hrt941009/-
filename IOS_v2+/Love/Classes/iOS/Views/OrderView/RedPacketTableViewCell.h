//
//  RedPacketTableViewCell.h
//  Love
//
//  Created by 李伟 on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RedPacketCellDelegate <NSObject>

- (void)redPacketCellKeyboardDidShow;

@end

@interface RedPacketTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *redPacketTextField;

@property (nonatomic, weak) id<RedPacketCellDelegate> delegate;

@end
