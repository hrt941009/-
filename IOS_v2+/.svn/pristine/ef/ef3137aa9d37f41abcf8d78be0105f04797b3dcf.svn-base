//
//  MyCartTableViewCell.h
//  Love
//
//  Created by lee wei on 14-10-4.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, MyCartButtonTag)
{
    MyCartButtonTagWithSection = 100,
    MyCartButtonTagWithCell = 101
};


@protocol MyCartTableViewCellDelegate <NSObject>

- (void)buyNumber:(int)number button:(UIButton *)button;
- (void)selectDelRowAtIndexPath:(BOOL)select;
- (void)selectButton:(UIButton *)button select:(BOOL)select;

@end

@interface MyCartTableViewCell : UITableViewCell


@property (nonatomic, weak) id<MyCartTableViewCellDelegate> delegate;

@property (nonatomic, strong) IBOutlet UIImageView *previewImageView;
@property (nonatomic ,strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *skuLabel;
@property (nonatomic ,strong) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) IBOutlet UIView  *numbersView;
@property (nonatomic, strong) IBOutlet UILabel *numbersLabel;
@property (nonatomic ,strong) IBOutlet UITextField *buyNumberTextField;
@property (nonatomic ,strong) IBOutlet UIButton *minusButton, *addButton;
@property (nonatomic, strong) IBOutlet UIButton *selectButton;

- (IBAction)minusButtonAction:(id)sender;
- (IBAction)addButtonAction:(id)sender;
- (IBAction)selectButtonAction:(id)sender;

- (void)cellEdit:(BOOL)edit;
- (void)cellButtonSelect:(BOOL)select;


@end
