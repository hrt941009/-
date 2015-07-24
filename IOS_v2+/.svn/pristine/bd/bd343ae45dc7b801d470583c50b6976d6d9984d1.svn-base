//
//  AddSubjectViewController.m
//  Love
//
//  Created by lee wei on 14-10-1.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "AddSubjectViewController.h"
#import "SelectSubjectViewController.h"
#import "SubjectModel.h"
#import "UIImageView+WebCache.h"
#import "MySubjectModel.h"
#import "UserManager.h"
#import "UIScrollView+MJRefresh.h"

static NSString *const startPage = @"1";
static NSString *const pageNumber = @"10";
@interface AddSubjectViewController ()<UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UIButton *leftButton;
    UIButton *rightButton;
    UILabel *placehoder;
    UILabel *titleNameLabel;
    UIImageView *cellImageView;
    UIView *myBgView;
    UIView *createView;
    int nextPage;
}
@property (nonatomic, strong) IBOutlet UITextField *titleTextField;
@property (nonatomic, strong) IBOutlet UIButton *selectSubjectButton;
@property (nonatomic, strong) IBOutlet UITextView  *descTextView;
@property (nonatomic, strong) IBOutlet UIButton *doneButton;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
//@property (nonatomic, strong) UIImageView *cellImageView;
//@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) NSString *albumID;
@property (weak, nonatomic) IBOutlet UIView *bgView;

- (IBAction)selectSubjectAction:(id)sender;
- (IBAction)doneButtonAction:(id)sender;

@end

@implementation AddSubjectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"加入专辑");
        _dataArray = [[NSMutableArray alloc] init];
        nextPage = 1;
    }
    return self;
}

- (void)headerRefreshData{
    NSString *userID = [UserManager readUid];
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加下拉刷新尾部控件
    [self.tableView addHeaderWithCallback:^{
        if ([mySelf.dataArray count] > 0) {
            [mySelf.dataArray removeAllObjects];
            [mySelf.tableView reloadData];
        }
        [MySubjectModel getMySubjectListWithUserID:userID page:startPage pageNumber:pageNumber];
    }];
    
    [self.tableView headerBeginRefreshing];
}

- (void)footerRefershData{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf moreMyAlbumDataAciton];
        
    }];
}

- (void)moreMyAlbumDataAciton{
    nextPage = nextPage + 1;
    NSString *userID = [UserManager readUid];
    [MySubjectModel getMySubjectListWithUserID:userID page:[NSString stringWithFormat:@"%d",nextPage] pageNumber:pageNumber];
    [_tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _bgView.frame = CGRectMake(0, 10, kScreenWidth, 110);
    _titleName.frame = CGRectMake(106, 2, kScreenWidth - 116, 30);
    _introduce.frame = CGRectMake(106, 34, kScreenWidth - 116, 72);
    _doneButton.frame = CGRectMake((kScreenWidth - 100)/2, 136, 100, 30);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mySubjectListData:)
                                                 name:kMySubjectNotificationName
                                               object:nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, kScreenHeight - 64 - 200) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    myBgView = [[UIView alloc] initWithFrame:self.view.bounds];
    myBgView.backgroundColor = [UIColor blackColor];
    myBgView.alpha = 0.7;
    [self.view bringSubviewToFront:myBgView];
    [self.view addSubview:myBgView];
    myBgView.hidden = YES;
    
    _doneButton.layer.masksToBounds = YES;
    _doneButton.layer.cornerRadius = 4.f;
    _titleName.text = _titleStr;
    _titleName.font = [UIFont systemFontOfSize:14.f];
    _titleName.numberOfLines = 0;
    _introduce.text = _intro;
    _introduce.font = [UIFont systemFontOfSize:12.f];
    _introduce.numberOfLines = 0;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_imgUrl] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    
    [self headerRefreshData];
    [self footerRefershData];
    
    
}
//点击分享事件
- (void)shareQQImageViewClicked:(UITapGestureRecognizer*)tap{
    NSLog(@"点击分享至QQ");
    
}
- (void)shareQzoneImageViewClicked:(UITapGestureRecognizer*)tap{
    NSLog(@"分享至QQ空间");
    
}
- (void)shareWechatImageViewClicked:(UITapGestureRecognizer*)tap{
    NSLog(@"点击分享至微信");
    
}
- (void)shareWechatFImageViewClicked:(UITapGestureRecognizer*)tap{
    NSLog(@"分享至微信朋友圈");
    
}
- (void)shareSinaImageViewClicked:(UITapGestureRecognizer*)tap{
    NSLog(@"分享至新浪微博");
    
}

- (void)mySubjectListData:(NSNotification*)noti{
    NSArray *array = noti.object;
    [_dataArray addObjectsFromArray:array];
    [_tableView reloadData];
    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMySubjectNotificationName object:nil];
}

#pragma mark - button action
- (IBAction)doneButtonAction:(id)sender
{
    createView = [[UIView alloc] initWithFrame:CGRectMake(10, 80, 300, 280)];
    createView.backgroundColor = [UIColor whiteColor];
    createView.layer.masksToBounds = YES;
    createView.layer.cornerRadius = 4.f;
    [self.view bringSubviewToFront:createView];
    [self.view addSubview:createView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 120)/2, 10, 100, 20)];
    title.textColor = [UIColor colorRGBWithRed:220 green:60 blue:100 alpha:1];
    title.text = @"创建专辑";
    title.textAlignment = NSTextAlignmentCenter;
    [createView addSubview:title];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, 280, 40)];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.layer.masksToBounds = YES;
    _textField.layer.cornerRadius = 4.f;
    _textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _textField.layer.borderWidth = 1.f;
    _textField.placeholder = @"请输入专辑名称";
    [createView addSubview:_textField];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 90, 280, 120)];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 4.f;
    _textView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _textView.layer.borderWidth = 1.f;
    _textView.delegate = self;
    [createView addSubview:_textView];
    
    placehoder = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 200, 30)];
    placehoder.backgroundColor = [UIColor clearColor];
    placehoder.text = @"请输入专辑简介";
    placehoder.textColor = [UIColor lightGrayColor];
    placehoder.hidden = NO;
    [createView addSubview:placehoder];
    
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10, 220, 120, 40);
    leftButton.layer.masksToBounds = YES;
    leftButton.layer.cornerRadius = 4.f;
    leftButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    leftButton.layer.borderWidth = 1.f;
    [leftButton addTarget:self action:@selector(cancleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [createView addSubview:leftButton];
    UILabel *lBntText = [[UILabel alloc] initWithFrame:leftButton.bounds];
    lBntText.text = @"取消";
    lBntText.textAlignment = NSTextAlignmentCenter;
    [leftButton addSubview:lBntText];
    
    rightButton = [[UIButton alloc] initWithFrame:CGRectMake(170, 220, 120, 40)];
    rightButton.layer.masksToBounds = YES;
    rightButton.layer.cornerRadius = 4.f;
    rightButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    rightButton.layer.borderWidth = 1.f;
    [rightButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [createView addSubview:rightButton];
    UILabel *rBntText = [[UILabel alloc] initWithFrame:rightButton.bounds];
    rBntText.text = @"确定";
    rBntText.textAlignment = NSTextAlignmentCenter;
    [rightButton addSubview:rBntText];
    
    myBgView.hidden = NO;
    
    
    
}

- (void)cancleButtonClicked:(UIButton *)bnt{
    myBgView.hidden = YES;
    createView.hidden = YES;
}

- (void)confirmButtonClicked:(UIButton *)bnt{
    if (_textField.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入专辑名称" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
        [alert show];
    }else if (_textView.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请输入专辑介绍" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
        [alert show];
    }else{
    [SubjectModel addSubjectWithName:_textField.text
                                desc:_textView.text
                               thumb:_imgUrl
                               block:^(int code) {
                                   UIAlertView *alertView = nil;
                                   if (code == 1) {
                                       alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                              message:@"已成功创建专辑"
                                                                             delegate:self
                                                                    cancelButtonTitle:MyLocalizedString(@"OK")
                                                                    otherButtonTitles:nil];
                                       myBgView.hidden = YES;
                                       createView.hidden = YES;
                                       [self.tableView headerBeginRefreshing];
                                       [alertView show];
                                   }else {
                                       alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                              message:@"创建专辑失败"
                                                                             delegate:self
                                                                    cancelButtonTitle:MyLocalizedString(@"OK")
                                                                    otherButtonTitles:nil];
                                       alertView.tag = 2;
                                       alertView.delegate = self;
                                       [alertView show];
                                   }
                                   
                               }];
    }
}

- (IBAction)selectSubjectAction:(id)sender
{
    SelectSubjectViewController *viewController = [[SelectSubjectViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (alertView.tag == 2) {
        
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _descTextView.text = nil;
    placehoder.hidden = YES;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_dataArray count] > 0) {
        return [_dataArray count];
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID1 = @"cellID1";
    static NSString *cellID2 = @"cellID2";
    if ([_dataArray count] > 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        }
        cell.textLabel.text = nil;
        
        MySubjectModel *model = (MySubjectModel*)_dataArray[indexPath.row];
        cell.textLabel.text = model.subjectName;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        }
        cell.textLabel.text = MyLocalizedString(@"还没有添加任何专辑");
        return cell;
    }
    
}

#pragma mark -- UITableViewDelegate;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MySubjectModel *model = (MySubjectModel*)_dataArray[indexPath.row];
    _albumID = model.subjectID;
    [SubjectModel albumAddSubjectWithItem:_itemId
                                 andAlbum:_albumID
                                    block:^(int code) {
                                        UIAlertView *alertView = nil;
                                        if (code == 1) {
                                            alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                   message:@"已成功加入专辑"
                                                                                  delegate:self
                                                                         cancelButtonTitle:MyLocalizedString(@"OK")
                                                                         otherButtonTitles:nil];
                                            alertView.tag = 1;
                                            alertView.delegate = self;
                                            [alertView show];
                                        }else {
                                            alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                   message:@"该商品已经加入过该专辑"
                                                                                  delegate:self
                                                                         cancelButtonTitle:MyLocalizedString(@"OK")
                                                                         otherButtonTitles:nil];
                                            alertView.tag = 2;
                                            alertView.delegate = self;
                                            [alertView show];
                                        }
                                    }];

}

@end
