//
//  MySubjectViewController.m
//  Love
//
//  Created by lee wei on 14-10-3.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "MySubjectViewController.h"

#import "SubjectViewController.h"
#import "MySubjectCell.h"
#import "MySubjectHeaderView.h"
#import "ChoiceTagView.h"

#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#import "LOVCircle.h"
#import "LOVPageConfig.h"

#import "MySubjectModel.h"
#import "SubjectInfoModel.h"
#import "MeTagListModel.h"
#import "AddTagModel.h"

#import "UserManager.h"

static CGFloat const kImageOriginHight = 161.f;


@interface MySubjectViewController ()<UITableViewDataSource, UITableViewDelegate, CreateNewTagDelegate, UITextFieldDelegate,UITextViewDelegate>
{
    CGRect headerRect;
    CGRect tableViewRect;
    int nextPage;
    UIView *mainView;
    BOOL isCreateTag;
}
@property (nonatomic, strong) SubjectViewController *subViewController;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MySubjectHeaderView *headerView;
@property (nonatomic, strong) ChoiceTagView *choiceTagView;
@property (nonatomic, strong) UIImageView *zoomImageView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITextField *myTextField;
@property (nonatomic, strong) UITextView *myTextView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *tempDataArray;
@property (nonatomic, strong) UIWindow *myWindow;
//@property (nonatomic, strong) NSString *albumImgUrl;
@property (nonatomic, strong) NSMutableArray *tagNameArray;


@end

@implementation MySubjectViewController

#pragma mark --UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.text = nil;
    return YES;
}

#pragma mark --UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _myTextField) {
        UIView *view = (UIView *)[mainView viewWithTag:200];
        for (int i = 0 ; i < [_tagNameArray count]; i++) {
            if ([_myTextField.text isEqual:_tagNameArray[i]]) {
                _myTextField.text = nil;
                view.hidden = NO;
                return;
            }
        }
        view.hidden = YES;
        return;
    }

}

#pragma mark -- CreateNewTagDelegate
- (void)careteNewTag{
//    _myWindow = [[UIWindow alloc] init];
//    _myWindow.frame = [[UIScreen mainScreen] bounds];
//    _myWindow.windowLevel = UIWindowLevelAlert;
//    _myWindow.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
//    [_myWindow makeKeyAndVisible];
//    _myWindow.hidden = NO;
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:_backView];
    [self.view bringSubviewToFront:_backView];
    
    mainView = [[UIView alloc] initWithFrame:CGRectMake(20, 100, kScreenWidth - 40, 230)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.masksToBounds = YES;
    mainView.layer.cornerRadius = 3.f;
    [_backView addSubview:mainView];
    
    _myTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 40, mainView.frame.size.width - 20, 38)];
    _myTextField.placeholder = @"1-10个字符";
    _myTextField.borderStyle = UITextBorderStyleRoundedRect;
    _myTextField.tag = 100;
    _myTextField.delegate = self; 
    [_myTextField becomeFirstResponder];
    [mainView addSubview:_myTextField];
    
    _myTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_myTextField.frame) + 20, mainView.frame.size.width - 20, 82)];
    _myTextView.layer.masksToBounds = YES;
    _myTextView.layer.cornerRadius = 3.f;
    _myTextView.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3] CGColor];
    _myTextView.layer.borderWidth = 1.f;
    _myTextView.text = @"商品简介......";
    _myTextView.delegate = self;
    [mainView addSubview:_myTextView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, mainView.frame.size.width - 20, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"新建标签";
    title.font = [UIFont systemFontOfSize:18.f];
    [mainView addSubview:title];
    
    //    提示信息
    UIView *noticeView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_myTextField.frame), kScreenWidth, 20)];
    noticeView.tag = 200;
    [mainView addSubview:noticeView];
    
    UILabel *noiceLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, kScreenWidth - 20, 20)];
    noiceLabel.textColor = [UIColor redColor];
    noiceLabel.text = @"此标签已存在，请修改标签";
    noiceLabel.font = [UIFont systemFontOfSize:11.f];
    [noticeView addSubview:noiceLabel];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 11, 11)];
    iconImageView.image = [UIImage imageNamed:@"icon_tagnotice"];
    [noticeView addSubview:iconImageView];
    
    noticeView.hidden = YES;
    
    UIButton *cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_myTextView.frame) + 10, (mainView.frame.size.width - 30)/2, 35)];
    cancleButton.layer.masksToBounds = YES;
    cancleButton.layer.cornerRadius = 3.f;
    cancleButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cancleButton.layer.borderWidth = 1.f;
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(newTagCancleAction:) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.backgroundColor = [UIColor clearColor];
    [mainView addSubview:cancleButton];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(20 + (mainView.frame.size.width - 30)/2, CGRectGetMaxY(_myTextView.frame) + 10, (mainView.frame.size.width - 30)/2, 35)];
    sureButton.layer.masksToBounds = YES;
    sureButton.layer.cornerRadius = 3.f;
    sureButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    sureButton.layer.borderWidth = 1.f;
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(newTagSuccessAction:) forControlEvents:UIControlEventTouchUpInside];
    sureButton.backgroundColor = [UIColor clearColor];
    [mainView addSubview:sureButton];

    
    
}

- (void)newTagCancleAction:(UIButton *)sender{
    _backView.hidden = YES;
    _backView = nil;
}

- (void)newTagSuccessAction:(UIButton *)sender{
    if (_myTextField.text.length == 0 || [_myTextField.text isEqual:@"1-10个字符"]) {
        //        [SVProgressHUD showErrorWithStatus:@"请填写标签名称"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请填写标签名称" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (_myTextView.text.length == 0 || [_myTextView.text isEqual:@"商品简介......"]){
        //        [SVProgressHUD showErrorWithStatus:@"请填写标签简介"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请填写标签简介" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        _backView.hidden = YES;
        _backView = nil;
        [AddTagModel createNewTagWithIntro:_myTextView.text tagName:_myTextField.text block:^(int code) {
            if (code == 1) {
                isCreateTag = YES;
                [MeTagListModel getTagListDataWithPage:kLovStartPage PageNum:kLovPageNumber];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"创建标签失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }

}

- (void)keyboardWillShow:(NSNotification *)noti{
    if (kScreenHeight > 480) {
        
    }else{
        if (mainView.frame.origin.y > 0) {
            CGFloat y = mainView.frame.origin.y - 100;
            mainView.frame = CGRectMake(20, y, kScreenWidth - 40, 230);
        }
    }
}

- (void)keyboardWillHide:(NSNotification *)noti{
    if (kScreenHeight > 480) {
        
    }else{
        CGFloat y = mainView.frame.origin.y + 100;
        mainView.frame = CGRectMake(20, y, kScreenWidth - 40, 230);
    }
}

#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc] init];
        _tagNameArray = [[NSMutableArray alloc] init];
        nextPage = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [AddTagModel getTagListData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mySubjectDataNotice:)
                                                 name:kMeTagListNotificationName
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tagListData:) name:kTagDataListNotificationName
                                               object:nil];

    //---
    self.view.backgroundColor = [UIColor whiteColor];
    
    //--
    self.title = [NSString stringWithFormat:@"%@", _titleStr];
    
    CGRect tvRect = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];
    
    //------- 顶部个人信息背景效果
    _zoomImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_bg"]];
    _zoomImageView.frame = CGRectMake(0, -kImageOriginHight, self.tableView.frame.size.width, kImageOriginHight);
    _zoomImageView.userInteractionEnabled = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(kImageOriginHight, 0, 0, 0);
    [self.tableView addSubview:_zoomImageView];
    
    _headerView = [[MySubjectHeaderView alloc] initWithFrame:CGRectMake(0, 0, _zoomImageView.frame.size.width, kImageOriginHight)];
    [_zoomImageView addSubview:_headerView];
    
    LOVCircle *iconView = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, 60.f, 60.f)
                                             imageWithPath:_userHeader
                                          placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    [_headerView.iconView addSubview:iconView];
//    _headerView.nickNameLabel.text = _titleStr;
    _headerView.signLabel.text = _signStr;
    _headerView.delegate = self;
    _headerView.signLabel.textAlignment = NSTextAlignmentCenter;
    
    [MeTagListModel getTagListDataWithPage:kLovStartPage PageNum:kLovPageNumber];
//    [self addHeaderRefresh];
    [self addFooterRefresh];
    
//    _userID = [UserManager readUid];
    
//    [MySubjectModel getMySubjectListWithUserID:_userID
//                                          page:kLovStartPage
//                                    pageNumber:kLovPageNumber];
    
    
    //-------
    
}

- (void)tagListData:(NSNotification *)noti{
    [_tagNameArray removeAllObjects];
    NSArray *array = [NSArray arrayWithArray:noti.object];
    for (int i = 0; i < [array count]; i++) {
        AddTagModel *model = array[i];
        [_tagNameArray addObject:model.tagName];
    }

}

//- (void)addHeaderRefresh{
//    // 添加下拉刷新头部控件
//    __unsafe_unretained typeof(self) mySelf = self;
//    [self.tableView addHeaderWithCallback:^{
//        if ([mySelf.dataArray count] > 0) {
//            [mySelf.dataArray removeAllObjects];
//            [mySelf.tableView reloadData];
//        }
////        [ShareLabelListModel getShareLabelListWithTagId:mySelf.labelId page:@"1" pageNumber:@"10"];
//        [MeTagListModel getTagListDataWithPage:kLovStartPage PageNum:kLovPageNumber];
//    }];
//    
//    [self.tableView headerBeginRefreshing];
//}

- (void)addFooterRefresh{
    __unsafe_unretained typeof(self) mySelf = self;
    // 添加上拉刷新尾部控件
    [self.tableView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        [mySelf loadingDataAction];
    }];
}

- (void)loadingDataAction{
    nextPage = nextPage + 1;
//    [ShareLabelListModel getShareLabelListWithTagId:_labelId page:[NSString stringWithFormat:@"%d",nextPage] pageNumber:@"10"];
    [MeTagListModel getTagListDataWithPage:[NSString stringWithFormat:@"%d",nextPage] PageNum:kLovPageNumber];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    _subViewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kMySubjectNotificationName object:nil];
}

#pragma mark -
#pragma mark -  scrollViewDidScroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -kImageOriginHight) {
        CGRect f = _zoomImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        _zoomImageView.frame = f;
    }
}

#pragma mark - notice
- (void)mySubjectDataNotice:(NSNotification *)notice
{
    if (isCreateTag) {
        [_dataArray removeAllObjects];
        isCreateTag = NO;
    }
    [_dataArray addObjectsFromArray:[notice object]];
    
    [_tableView reloadData];
    
//    [self.tableView headerEndRefreshing];
    [self.tableView footerEndRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_dataArray count] > 0)
    {
      return [_dataArray count];
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
    
    if ([_dataArray count] > 0) {
        MySubjectCell *cell = (MySubjectCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            cell = [[MySubjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            
        }
        MeTagListModel *model = (MeTagListModel *)_dataArray[indexPath.row];
        
        [cell.conImageView sd_setImageWithURL:[NSURL URLWithString:model.tagHeader]
                             placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        cell.titleLabel.text = [NSString stringWithFormat:@"# %@",model.tagName];
//        cell.commentLabel.text = [NSString stringWithFormat:@"评论 %@+",  model.discussNum];
//        cell.likeLabel.text = [NSString stringWithFormat:@"关注 %@+",  model.fllowNum];
        cell.introLabel.text = model.tagIntro;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier2];
        }
        cell.detailTextLabel.text = MyLocalizedString(@"还没有添加内容");
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    editingStyle = UITableViewCellEditingStyleDelete;
//    MySubjectModel *model = (MySubjectModel *)_dataArray[indexPath.row];;
//    [MySubjectModel deleteSubjectWithSubjectID:model.subjectID block:^(int code, NSString *msg) {
//        if (code == 1) {
//            if (_dataArray.count == 1) {
//                [_dataArray removeObjectAtIndex:indexPath.row];
//                [_tableView reloadData];
//            }else{
//                [_dataArray removeObjectAtIndex:indexPath.row];
//                [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//            }
//        }else{
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"删除失败，请重试！" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
//            [alertView show];
//        }
//    }];
//}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataArray count] > 0) {
       return 110.f;
    }else{
        return 40.f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataArray.count > 0) {
//        MySubjectModel *model = (MySubjectModel *)_dataArray[indexPath.row];
        MeTagListModel *model = (MeTagListModel *)_dataArray[indexPath.row];
        _subViewController = [[SubjectViewController alloc] initWithNibName:@"SubjectViewController" bundle:nil];
        _subViewController.header = model.tagHeader;
        _subViewController.tagName = model.tagName;
        _subViewController.tagId = model.tagId;
//        _subViewController.subjectId = model.subjectID;//@"96";//
//        _subViewController.titleStr = model.subjectName;
//        _subViewController.infoStr = nil;
//        _subViewController.isMySubject = YES;
        [self.navigationController pushViewController:_subViewController animated:YES];
    }
}

//#pragma mark -- 刷新
//- (void)reload{
//    [MySubjectModel getMySubjectListWithUserID:_userID
//                                          page:kLovStartPage
//                                    pageNumber:kLovPageNumber];
//}

@end
