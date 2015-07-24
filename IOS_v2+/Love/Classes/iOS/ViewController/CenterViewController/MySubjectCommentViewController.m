//
//  MySubjectCommentViewController.m
//  Love
//
//  Created by lee wei on 14-10-3.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MySubjectCommentViewController.h"
#import "MySubjectCommentCell.h"
#import "CommentListModel.h"
#import "MJRefresh.h"
#import "LOVPageConfig.h"
#import "UIImageView+WebCache.h"
#import "AddAlbumDiscussModel.h"

#import "LOVCircle.h"
#import "LOVWriteCommentView.h"

@interface MySubjectCommentViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate, LOVWriteCommentViewDelegate>
{
    int nextPage;
    UITextField *textField;
    UITextView *myTextView;
    UIView *bottomView;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UINib *nib;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) LOVWriteCommentView *writeCommentView;
@end

@implementation MySubjectCommentViewController
#pragma mark - 刷新
- (void)addSubjectCommentDataHeader
{
    
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加下拉刷新头部控件
    [_tableView addHeaderWithCallback:^{
        // 进入刷新状态就会回调这个Block
        //----- get data
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        if (mySelf.isLive) {
            [CommentListModel getCommentWithLiveID:mySelf.subjectID page:kLovStartPage pnum:kLovPageNumber];
        }else{
            // 增加数据
            [CommentListModel getCommentWithAlbumID:mySelf.subjectID page:kLovStartPage pnum:kLovPageNumber];
        }
//        [mySelf.tableView headerEndRefreshing];
    }];
    
    //自动刷新(一进入程序就下拉刷新)
    [_tableView headerBeginRefreshing];
}

- (void)addSubjectCommentDataFooter
{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [_tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf loadCommentData];
        
    }];
}

- (void)loadCommentData
{
    nextPage = nextPage + 1;
    if (self.isLive) {
        [CommentListModel getCommentWithLiveID:_subjectID page:[NSString stringWithFormat:@"%d", nextPage] pnum:kLovPageNumber];
    }else{
        [CommentListModel getCommentWithAlbumID:_subjectID page:[NSString stringWithFormat:@"%d", nextPage] pnum:kLovPageNumber];
    }
}

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        self.title = MyLocalizedString(@"评论");
        nextPage = 1;
        _isLive = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    //----
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(albumCommentNotice:)
                                                 name:kAlbumCommentNotificationName
                                               object:nil];
    
    //-----
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 64 - 40, kScreenWidth, 40)];
    bottomView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bottomView];
    [self.view bringSubviewToFront:bottomView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, 3, kScreenWidth - 10, 34)];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitle:@"写评论" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(writeComment:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    
    //--
    [self addSubjectCommentDataHeader];
    [self addSubjectCommentDataFooter];
}

- (void)writeComment:(UIButton *)sender{
    //---写评论页面
    _writeCommentView = [[LOVWriteCommentView alloc] init];
    _writeCommentView.alpha = 1.f;
    [_writeCommentView showWirteView];
    _writeCommentView.delegate = self;
    [self.view addSubview:_writeCommentView];
}

#pragma mark - LOVWriteCommentViewDelegate 提交评论
- (void)cancelWirteComment
{
    [_writeCommentView hiddenViewAction];
}

- (void)postCommentContent:(NSString *)content
{
    if (content.length > 0) {
        if (_isLive) {
            [AddAlbumDiscussModel addLiveCommentLive:_subjectID To_id:nil Content:content Block:^(int code, NSString *msg) {
                if (code == 1) {
                    [_writeCommentView hiddenViewAction];
                    [self.tableView headerBeginRefreshing];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:MyLocalizedString(@"评论发送失败，请重试！") otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }];
        }else{
            [AddAlbumDiscussModel addAlbumDiscussAlbum:_subjectID To_id:nil Content:content Block:^(int code, NSString *msg) {
                if (code == 1) {
                    [_writeCommentView hiddenViewAction];
                    [self.tableView headerBeginRefreshing];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:MyLocalizedString(@"评论发送失败，请重试！") otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"请填写评论"
                                                           delegate:self
                                                  cancelButtonTitle:MyLocalizedString(@"返回")
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}


#pragma mark - notice
- (void)albumCommentNotice:(NSNotification *)notice
{
    [_dataArray addObjectsFromArray:[notice object]];

    [_tableView reloadData];
    
    [_tableView headerEndRefreshing];
    [_tableView footerEndRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_dataArray count] > 0) {
        return  [_dataArray count];
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *commentCellIdentifier = @"commentCellIdentifier";
    static NSString *commentCellIdentifier1 = @"commentCellIdentifier1";
    if (_dataArray.count > 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellIdentifier];
        }
    
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [detailLabel setLineBreakMode:NSLineBreakByWordWrapping];
        [detailLabel setMinimumScaleFactor:14.f];
        [detailLabel setNumberOfLines:0];
        [detailLabel setFont:[UIFont systemFontOfSize:14.f]];
        [detailLabel setTag:1];
        [cell.contentView addSubview:detailLabel];
    
        CommentListModel *model = (CommentListModel *)_dataArray[indexPath.row];
        CGSize constraint = CGSizeMake(200.f, 20000.0f);
//        CGSize size = [model.commentMessage sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        CGSize size = [model.commentMessage boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
            if (detailLabel) {
                detailLabel = (UILabel *)[cell viewWithTag:1];
                [detailLabel setText:model.commentMessage];
                [detailLabel setFrame:CGRectMake(100, 30, 200, MAX(size.height, 44.f))];
            }
        
        
        LOVCircle *imageView = [[LOVCircle alloc] initWithFrame:CGRectMake(8, 8, 60, 60) imageWithPath:model.fromHeader placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        [cell.contentView addSubview:imageView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 8, 200, 20)];
        nameLabel.textColor = [UIColor colorRGBWithRed:195 green:55 blue:85 alpha:1.f];
        nameLabel.text = model.fromName;
        [cell.contentView addSubview:nameLabel];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:commentCellIdentifier1];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:commentCellIdentifier1];
        }
        cell.detailTextLabel.text = MyLocalizedString(@"还没有评论，赶快加入评论吧！");
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray count] > 0) {
        CommentListModel *model = (CommentListModel *)_dataArray[indexPath.row];
        NSString *text = model.commentMessage;
        CGSize consitraint = CGSizeMake(200, 20000.0f);
//        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:consitraint lineBreakMode:NSLineBreakByWordWrapping];
        CGSize size = [text boundingRectWithSize:consitraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f]} context:nil].size;
        CGFloat height = MAX(size.height, 44.f);
        
        return height + 40;
    }else{
        return 44.f;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 70;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *bgview = [[UIView alloc] init];
//    bgview.backgroundColor = [UIColor lightGrayColor];
//    
////    textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 90, 30)];
////    textField.borderStyle = UITextBorderStyleRoundedRect;
////    textField.placeholder = @"请输入评论内容";
////    textField.delegate = self;
////    [bgview addSubview:textField];
//    
//    myTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 90, 50)];
//    myTextView.layer.masksToBounds = YES;
//    myTextView.layer.cornerRadius = 4.f;
//    myTextView.text = @"请输入评论内容";
//    myTextView.delegate = self;
//    [bgview addSubview:myTextView];
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(kScreenWidth - 70, 20, 60, 30);
//    button.layer.masksToBounds = YES;
//    button.layer.cornerRadius = 4.f;
//    [button setTitle:@"发送" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor colorRGBWithRed:230 green:63 blue:105 alpha:1]];
//    [button addTarget:self action:@selector(reciveMessage:) forControlEvents:UIControlEventTouchUpInside];
//    [bgview addSubview:button];
//    
//    return bgview;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -- UITextFieldDelegate

#pragma mark -- UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    myTextView.text = nil;
}
//字数限制
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString * aString = [textView.text stringByReplacingCharactersInRange:range withString:myTextView.text];
    if (myTextView == textView)
    {
        if ([aString length] > 100) {
            textView.text = [aString substringToIndex:100];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"超过最大字数不能输入了"
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

#pragma mark -- 发表评论按钮
- (void)reciveMessage:(UIButton *)sender{
    NSLog(@"发送评论");
    if (myTextView.text.length == 0 || [myTextView.text isEqual:@"请输入评论内容"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请输入评论内容" delegate:self cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil
                                  , nil];
        [alertView show];
    }else{
        [AddAlbumDiscussModel addAlbumDiscussAlbum:_subjectID To_id:nil Content:myTextView.text Block:^(int code, NSString *msg) {
            if (code == 1) {
                [self.tableView headerBeginRefreshing];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }
}

@end
