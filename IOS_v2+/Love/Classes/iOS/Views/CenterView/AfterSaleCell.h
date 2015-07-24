//
//  AfterSaleCell.h
//  Love
//
//  Created by use on 14-11-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol pushDelegate <NSObject>

- (void) pushComplainPage:(UIButton*)button;

@end
@interface AfterSaleCell : UITableViewCell

@property (nonatomic,weak) id<pushDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *introduce;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *dateTime;
@property (weak, nonatomic) IBOutlet UIButton *choiceButton;
- (IBAction)choiceCommodityClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *line;

@end
