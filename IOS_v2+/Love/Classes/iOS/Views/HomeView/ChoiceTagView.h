//
//  ChoiceTagView.h
//  Love
//
//  Created by use on 15-3-23.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"
@protocol ChoiceTagDelegate <NSObject>

- (void)addNewTag;
- (void)sureButtonAction:(UIButton *)sender andCheckNumber:(NSInteger)checkNum;
- (void)cancleButtonAction:(UIButton *)sender;
- (void)choiceTagWithIndexPath:(NSIndexPath *)indexPath;

@end


@interface ChoiceTagView : UIView<UITableViewDataSource,UITableViewDelegate,QCheckBoxDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) id<ChoiceTagDelegate>delegate;
//- (void)getTheDataArray:(NSMutableArray *)dataArray;

- (void)getTagDataListWithData:(NSMutableArray *)myDataArray;

@end
