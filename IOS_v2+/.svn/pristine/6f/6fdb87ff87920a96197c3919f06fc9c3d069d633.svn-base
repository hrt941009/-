//
//  ChoiceTagView.m
//  Love
//
//  Created by use on 15-3-23.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ChoiceTagView.h"
#import "SVProgressHUD.h"
#import "AddTagModel.h"

@implementation ChoiceTagView
{
    NSUInteger checkNum;
    CGPoint tableViewContentOffset;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
        
    }
    return self;
}

- (void)reloadTableView{
    _tableView = nil;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, self.frame.size.width, self.frame.size.height - 120) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    _tableView.contentOffset = tableViewContentOffset;
}

- (void)getTagDataListWithData:(NSMutableArray *)myDataArray{
    _dataArray = myDataArray;
    
    [self reloadTableView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 80)/2, 0, 80, 60)];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:18.f];
    title.text = @"选择标签";
    [topView addSubview:title];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 60, self.frame.size.width, 60)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    UIButton *cancleButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 250)/2, 10, 120, 35)];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleButton.backgroundColor = [UIColor clearColor];
    [cancleButton addTarget:self action:@selector(cancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.layer.masksToBounds = YES;
    cancleButton.layer.cornerRadius = 3.f;
    cancleButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cancleButton.layer.borderWidth = 1.f;
    [bottomView addSubview:cancleButton];
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancleButton.frame)+10, 10, 120, 35)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sureButton.backgroundColor = [UIColor clearColor];
    [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 3.f;
    sureButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    sureButton.layer.borderWidth = 1.f;
    [bottomView addSubview:sureButton];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(theTagListData:) name:kTagDataListNotificationName object:nil];
//    
//    [AddTagModel getTagListData];
//    [SVProgressHUD show];
    
    
    
}
//- (void)getTheDataArray:(NSMutableArray *)dataArray{
//    _dataArray = dataArray;
//    [self.tableView reloadData];
//    [SVProgressHUD dismiss];
//}
//- (void)theTagListData:(NSNotification *)noti{
//    [_dataArray removeAllObjects];
//    [_dataArray addObjectsFromArray:noti.object];
//    [self.tableView reloadData];
//    [SVProgressHUD dismiss];
//}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray count] + 1;
//    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }else{
        cell.textLabel.text = nil;
        for (UIView *vi in cell.contentView.subviews) {
            [vi removeFromSuperview];
        }
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"+新建标签";
    }else{
//            AddTagModel *model = _dataArray[indexPath.row - 1];
        cell.textLabel.text = [NSString stringWithFormat:@"#%@",_dataArray[indexPath.row - 1]];
        cell.tag = indexPath.row;
        
        UIButton *checkBox = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 30, 10, 20, 20)];
        if (indexPath.row == checkNum) {
            [checkBox setImage:[UIImage imageNamed:@"icon_checkBox2"] forState:UIControlStateNormal];
        }else{
            [checkBox setBackgroundImage:[UIImage imageNamed:@"icon_checkBox1"] forState:UIControlStateNormal];
        }
        [checkBox addTarget:self action:@selector(checkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:checkBox];
//        QCheckBox *checkBox = [[QCheckBox alloc] initWithDelegate:self];
//        checkBox.frame = CGRectMake(self.frame.size.width - 30, 10, 20, 20);
//        [checkBox setBackgroundImage:[UIImage imageNamed:@"icon_checkBox1"] forState:UIControlStateNormal];
//        [checkBox addTarget:self action:@selector(checkButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.contentView addSubview:checkBox];
//        checkBox.checked = NO;
//        if (indexPath.row == checkNum) {
//            checkBox.checked = YES;
//        }else{
//            [checkBox setChecked:NO];
//        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if ([_delegate respondsToSelector:@selector(addNewTag)]) {
            [_delegate addNewTag];
        }
        
    }else{
        if ([_delegate respondsToSelector:@selector(choiceTagWithIndexPath:)]) {
            [_delegate choiceTagWithIndexPath:indexPath];
        }
    }
}

- (void)cancleButtonClick:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(cancleButtonAction:)]) {
        [_delegate cancleButtonAction:sender];
    }
}

- (void)sureButtonClick:(UIButton *)sender{
    if ([_delegate respondsToSelector:@selector(sureButtonAction:andCheckNumber:)]) {
        [_delegate sureButtonAction:sender andCheckNumber:checkNum];
    }
}

- (void)checkButtonAction:(UIButton *)sender{
    UITableViewCell *cell;
    if (VersionNumber_iOS_8) {
        cell = (UITableViewCell *)[[sender superview] superview];
    }else{
        cell = (UITableViewCell *)[[[sender superview] superview] superview];
    }
    checkNum = cell.tag;
    [self reloadTableView];
}

#pragma mark - QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
//    NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
    if (checked) {
//        UITableViewCell *cell = (UITableViewCell *)[[checkbox superview] superview];
//        checkNum = cell.tag;
//        [self.tableView reloadData];
        checkbox.checked = NO;
    NSLog(@"%@",[[checkbox superview] superview]);
    
    }else{
        checkbox.checked = YES;
    }
//    [self.tableView reloadData];
//    [self reloadTableView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _tableView) {
        tableViewContentOffset = _tableView.contentOffset;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
