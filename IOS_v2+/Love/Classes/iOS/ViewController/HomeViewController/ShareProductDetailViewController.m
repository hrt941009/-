//
//  ShareProductDetailViewController.m
//  Love
//
//  Created by use on 15-3-20.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "ShareProductDetailViewController.h"
#import "CommentViewController.h"
#import "LoginViewController.h"
#import "LOVShareActivityView.h"
#import "UserHomeViewController.h"
#import "BigImageViewController.h"
#import "CommissionSKUViewController.h"
#import "MyCartViewController.h"

#import "ShareProductBottomView.h"
#import "CCBottomView.h"
#import "ChoiceTagView.h"

#import "ShareDetialDataModel.h"
#import "FollowMeModel.h"
#import "CommentReplayModel.h"
#import "UserManager.h"
#import "AddTagModel.h"
#import "SKUModel.h"

#import "LOVPhotoScrollView.h"
#import "LOVWriteCommentView.h"
#import "LOVCircle.h"
#import "SVProgressHUD.h"

@interface ShareProductDetailViewController ()<UITableViewDataSource,UITableViewDelegate,LOVPhotoScrollViewDelegate,LOVWriteCommentViewDelegate,UITextFieldDelegate,CCBottomViewDelegate, ChoiceTagDelegate,UITextViewDelegate>
{
    CGPoint tableViewContentOffset;
    UIView *mainView;
    BOOL isNewTag;//判断是否是新建标签
}
@property (nonatomic, strong) UIWindow *myWindow;
@property (nonatomic, strong) NSMutableArray *dataArray;//评论列表
@property (nonatomic, strong) NSMutableArray *productArray;//产品列表
@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) NSMutableArray *imageArray;//轮播图片
@property (nonatomic, strong) NSMutableArray *tagArray;
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *addTag;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITextField *myTextField;
@property (nonatomic, strong) UITextView *myTextView;
@property (nonatomic, strong) NSMutableArray *tagNameArray;

@property (nonatomic, assign) BOOL isShare;

@property (nonatomic, strong) NSString *productIntro;
@property (nonatomic, strong) NSString *stock;//库存
@property (nonatomic, strong) NSString *markedPrice;//市场价
@property (nonatomic, strong) NSString *price;//现价
@property (nonatomic, strong) NSString *sales;//销量
@property (nonatomic, strong) NSString *discussNum;//评论数量
@property (nonatomic, strong) NSString *userName;//用户名
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *header;
@property (nonatomic, strong) NSString *userIntro;
@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, strong) NSString *discount;//折扣
@property (nonatomic, strong) NSString *isLove;//是否喜欢,0未喜欢  1喜欢
@property (nonatomic, strong) NSString *inTag;//是否加入标签，0未加入   1加入

@property (nonatomic, strong) LOVPhotoScrollView *photoScrollView;
@property (nonatomic, strong) LOVWriteCommentView *writeCommentView;
@property (nonatomic, strong) CCBottomView *bottomView;
@property (nonatomic, strong) ChoiceTagView *choiceTagView;
@property (nonatomic, strong) CommissionSKUViewController *skuViewController;

@end

@implementation ShareProductDetailViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _skuViewController = nil;
}

#pragma mark -- ChoiceTagDelegate
- (void)addNewTag{
    NSLog(@"新建标签");
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [_myWindow addSubview:_backView];
    [_myWindow bringSubviewToFront:_backView];
    
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
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth - 20, 30)];
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

- (void)sureButtonAction:(UIButton *)sender andCheckNumber:(NSInteger)checkNum{
    NSLog(@"确认");
    if (checkNum != 0) {
        checkNum = checkNum - 1;
    }
    AddTagModel *model = _tagArray[checkNum];
    [AddTagModel addTagWithTagId:model.tagId ProductId:_productId block:^(int code, NSString *msg) {
        if (code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"加入成功"];
            _myWindow.hidden = YES;
            _myWindow = nil;
        }else{
            _myWindow.hidden = YES;
            _myWindow = nil;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }];
}
- (void)cancleButtonAction:(UIButton *)sender{
    _myWindow.hidden = YES;
    _myWindow = nil;
}
- (void)choiceTagWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
}

#pragma mark -- CCBottomViewDelegate
- (void)writeMyComment{
    
}
- (void)putCart{
    [self pushSKUViewController:YES ProductId:_productId ProductIntro:_productIntro];
}
- (void)buyNow{
    [self pushSKUViewController:NO ProductId:_productId ProductIntro:_productIntro];
}

//跳转到SKU页面
- (void)pushSKUViewController:(BOOL)isCart ProductId:(NSString *)productId ProductIntro:(NSString *)productIntro
{
    NSString *sig = [UserManager readSig];
    if ([sig length] > 0) {
        if (_skuViewController == nil) {
            NSString *item = productId;
            [SKUModel getSKUWithItem:item block:^(NSString *thumbPath, NSString *stockNum,NSString *section1,
                                                  NSString *section2, NSString *price1, NSString *price2, NSString *price3, NSString *defaultPrice, NSDictionary *commoListDic, NSArray *skuValueArray) {
                
                _skuViewController = [[CommissionSKUViewController alloc] initWithNibName:@"CommissionSKUViewController" bundle:nil];
                _skuViewController.isCart = isCart;
                _skuViewController.commoStr = item;
                _skuViewController.thumbPath = thumbPath;
                _skuViewController.stocksNum = stockNum;
                _skuViewController.defaultPrice = defaultPrice;
                _skuViewController.commList = commoListDic;
                _skuViewController.skuValueArr = skuValueArray;
                _skuViewController.section1 = section1;
                _skuViewController.section2 = section2;
                _skuViewController.price1 = price1;
                _skuViewController.price2 = price2;
                _skuViewController.price3 = price3;
                
                _skuViewController.intro = productIntro;
                [self.navigationController pushViewController:_skuViewController animated:YES];
            }];
        }
    }else{
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}


#pragma mark -- LOVWriteCommentViewDelegate
- (void)cancelWirteComment
{
    [_writeCommentView hiddenViewAction];
}

- (void)postCommentContent:(NSString *)content
{
    NSString *sig = [UserManager readSig];
    if ([sig length] > 0){
        if ([content length] > 0) {
            NSString *toId = @"";
            [CommentReplayModel postReplayWithItem:_productId toId:toId content:content block:^(int code) {
                UIAlertView *alertView = nil;
                if (code == 0) {
                    alertView = [[UIAlertView alloc] initWithTitle:nil
                                                           message:@"发送失败"
                                                          delegate:self
                                                 cancelButtonTitle:MyLocalizedString(@"返回")
                                                 otherButtonTitles:nil];
                    alertView.tag = 111;
                    alertView.delegate = self;
                    [alertView show];
                }
                if (code == 1) {
                    [_writeCommentView hiddenViewAction];
                    [ShareDetialDataModel getShareProductDetailDataWithProductId:_productId block:^(NSDictionary *detailInfo) {
                        [_dataArray removeAllObjects];
                        _dataArray = [NSMutableArray arrayWithArray:[detailInfo objectForKey:@"discuss_list"]];
                        [self reloadTableView];
                    }];
                }
            }];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"请填写评论"
                                                               delegate:self
                                                      cancelButtonTitle:MyLocalizedString(@"返回")
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
    }else{
        [_writeCommentView closeKeyboard];
        LoginViewController *loginController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginController animated:YES];
    }
}

#pragma mark - lov photo delegate
- (void)getImageViewTag:(NSInteger)tag
{
    if ([_imageArray count] > 0) {
        BigImageViewController *bigImageVC = [[BigImageViewController alloc] init];
        [bigImageVC getImageArray:_imageArray selectedImageViewTag:tag];
        [self presentViewController:bigImageVC animated:YES completion:nil];
    }
}

- (void)newTagCancleAction:(UIButton *)sender{
    NSLog(@"取消新建标签");
    _backView.hidden = YES;
    _backView = nil;
    [_myTextField resignFirstResponder];
}

- (void)newTagSuccessAction:(UIButton *)sender{
    if (_myTextField.text.length == 0 || [_myTextField.text isEqual:@"1-10个字符"]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请填写标签名称" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else if (_myTextView.text.length == 0 || [_myTextView.text isEqual:@"商品简介......"]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请填写标签简介" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        _backView.hidden = YES;
        _backView = nil;
        [AddTagModel createNewTagWithIntro:_myTextView.text tagName:_myTextField.text block:^(int code) {
            if (code == 1) {
                isNewTag = YES;
                [AddTagModel getTagListData];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"创建标签失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }
    
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _dataArray = [[NSMutableArray alloc] init];
        _productArray = [[NSMutableArray alloc] init];
        _imageArray = [[NSMutableArray alloc] init];
        _tagArray = [[NSMutableArray alloc] init];
        _tagNameArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _productName;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(theTagListData:) name:kTagDataListNotificationName
                                               object:nil];
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.frame = CGRectMake(0, 0, 29, 20.f);
    cartButton.backgroundColor = [UIColor clearColor];
    [cartButton setBackgroundImage:[UIImage imageNamed:@"navBar_cart"] forState:UIControlStateNormal];
    [cartButton addTarget:self action:@selector(cartButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cartBarButton = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    
    self.navigationItem.rightBarButtonItem = cartBarButton;
    
    [AddTagModel getTagListData];
}
//跳转购物车
- (void)cartButtonAction{
    NSString *sig = [UserManager readSig];
    if (sig.length > 0) {
        MyCartViewController *myCart = [[MyCartViewController alloc] init];
        [self.navigationController pushViewController:myCart animated:YES];
    }else{
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:login animated:YES];
    }
    
}

- (void)keyboardWillShow:(NSNotification*)noti{
//    NSDictionary *dic = [noti object];
    if (kScreenHeight > 480) {
        
    }else{
        if (mainView.frame.origin.y > 0) {
            CGFloat y = mainView.frame.origin.y - 100;
            mainView.frame = CGRectMake(20, y, kScreenWidth - 40, 230);
        }
    }
}

- (void)keyboardWillHide:(NSNotification*)noti{
    if (kScreenHeight > 480) {
        
    }else{
        CGFloat y = mainView.frame.origin.y + 100;
        mainView.frame = CGRectMake(20, y, kScreenWidth - 40, 230);
    }
}

- (void)reloadTheDataWithShare:(BOOL)isShare{
    _isShare = isShare;
    if (isShare == YES) {
        [ShareDetialDataModel getShareProductDetailDataWithProductId:_productId block:^(NSDictionary *detailInfo) {
            [_imageArray addObjectsFromArray:[[detailInfo objectForKey:@"product_detail"] objectForKey:@"imgs"]];
            [_dataArray addObjectsFromArray:[detailInfo objectForKey:@"discuss_list"]];
            _productId = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"product_id"];
            _productName = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"product_name"];
            _productIntro = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"product_intro"];
            _stock = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"stock"];
            _markedPrice = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"marked_price"];
            _price = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"price"];
            _sales = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"sales"];
            _discussNum = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"discuss_number"];
            _userName = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"user_name"];
            _header = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"header"];
            _userIntro = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"user_intro"];
            _tagName = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"tag_name"];
            _discount = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"discount"];
            _isLove = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"is_love"];
            _inTag = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"in_tag"];
            _userId = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"user_id"];
            
            [self reloadTableView];
            
        }];
    }else{
        [ShareDetialDataModel getProductDetailDataWithProductId:_productId tagId:_tagId block:^(NSDictionary *detailInfo) {
            [_imageArray addObjectsFromArray:[[detailInfo objectForKey:@"product_detail"] objectForKey:@"imgs"]];
            [_dataArray addObjectsFromArray:[detailInfo objectForKey:@"discuss_list"]];
            _productId = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"product_id"];
            _productIntro = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"product_intro"];
            _stock = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"stock"];
            _markedPrice = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"marked_price"];
            _price = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"price"];
            _sales = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"sales"];
            _discussNum = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"discuss_number"];
            _userName = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"user_name"];
            _header = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"header"];
            _userIntro = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"user_intro"];
            _tagName = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"tag_name"];
            _discount = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"discount"];
            _isLove = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"is_love"];
            _inTag = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"in_tag"];
            _userId = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"user_id"];
            _productName = [[detailInfo objectForKey:@"product_detail"] objectForKey:@"product_name"];
            [self reloadTableView];
            
        }];
    }
}

- (void)reloadTableView{
    self.title = _productName;
    [_tabelView removeFromSuperview];
    _tabelView = nil;
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50) style:UITableViewStylePlain];
    _tabelView.dataSource = self;
    _tabelView.delegate = self;
    _tabelView.backgroundColor = [UIColor colorRGBWithRed:251 green:251 blue:251 alpha:1];
    _tabelView.showsHorizontalScrollIndicator = NO;
    _tabelView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tabelView];
    _tabelView.contentOffset = tableViewContentOffset;
    
    _bottomView = [[CCBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50 - 64, kScreenWidth, 50)];
    _bottomView.backgroundColor = [UIColor colorRGBWithRed:229 green:229 blue:229 alpha:1];
    _bottomView.delgate = self;
    _bottomView.alpha = 1.f;
    //        _bottomView.bottomPriceStr = _price;
    _bottomView.bottomOriginalPriceStr = _markedPrice;
    [_bottomView setBottomViewForWirte:NO];
    if ([_discount isEqual:@"10.0"]) {
        _bottomView.discountLabel.text = @"无折扣";
    }else{
        _bottomView.bottomDiscount = _discount;
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",_price]];
    [str addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]} range:NSMakeRange(0, 2)];
    
    _bottomView.priceLabel.text = [str string];
    [self.view addSubview:_bottomView];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    if (section == 1) {
        return 0;
    }
    if (section == 2) {
        return 0;
    }
    if (section == 3) {
        return 1;
    }
    if (section == 4) {
        if ([_dataArray count] > 0) {
            return [_dataArray count] + 1;
        }else{
            return 1;
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        static NSString *cellID1 = @"cellID1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        }
        cell.textLabel.text = _productIntro;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        return cell;
    }
    if (indexPath.section == 4) {
        static NSString *cellID2 = @"cellID2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        }
        for (UIView *vi in cell.contentView.subviews) {
            [vi removeFromSuperview];
        }
        if ([_dataArray count] > 0) {
            if (indexPath.row == [_dataArray count]) {
                cell.textLabel.text = @"查看更多评论>>";
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            }else if(indexPath.row < [_dataArray count]){
                NSDictionary *commityDic = nil;
                commityDic = (NSDictionary *)[_dataArray objectAtIndex:indexPath.row];
                LOVCircle *circle = [[LOVCircle alloc] initWithFrame:CGRectMake(5, 15, 40, 40) imageWithPath:[commityDic objectForKey:@"header"] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
                [cell.contentView addSubview:circle];
                
                UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, kScreenWidth - 70, 20)];
                nameLabel.textColor = [UIColor colorRGBWithRed:147 green:194 blue:214 alpha:1];
                nameLabel.text = [commityDic objectForKey:@"name"];
                [cell.contentView addSubview:nameLabel];
                
                UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, kScreenWidth - 70, 10)];
                timeLabel.font = [UIFont systemFontOfSize:12.f];
                timeLabel.text = [commityDic objectForKey:@"create_time"];
                [cell.contentView addSubview:timeLabel];
                
                UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, kScreenWidth - 70, 60)];
                content.numberOfLines = 0;
                content.text = [commityDic objectForKey:@"content"];
                content.font = [UIFont systemFontOfSize:15.f];
                [cell.contentView addSubview:content];
            }
        }else{
            cell.textLabel.text = @"还没有评论";
        }
        return cell;
    }
    /*
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        if (indexPath.section == 3) {
            cell.textLabel.text = _productIntro;
            cell.textLabel.numberOfLines = 0;
            cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        }else{
            if (indexPath.section == 4) {
                if ([_dataArray count] > 0) {
                    if (indexPath.row == [_dataArray count]) {
                        cell.textLabel.text = @"查看更多评论>>";
                        cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    }else if(indexPath.row < [_dataArray count]){
                        NSDictionary *commityDic = nil;
                        commityDic = (NSDictionary *)[_dataArray objectAtIndex:indexPath.row];
                        LOVCircle *circle = [[LOVCircle alloc] initWithFrame:CGRectMake(5, 15, 40, 40) imageWithPath:[commityDic objectForKey:@"header"] placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
                        [cell.contentView addSubview:circle];
                        
                        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, kScreenWidth - 70, 20)];
                        nameLabel.textColor = [UIColor colorRGBWithRed:147 green:194 blue:214 alpha:1];
                        nameLabel.text = [commityDic objectForKey:@"name"];
                        [cell.contentView addSubview:nameLabel];
                        
                        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, kScreenWidth - 70, 10)];
                        timeLabel.font = [UIFont systemFontOfSize:12.f];
                        timeLabel.text = [commityDic objectForKey:@"create_time"];
                        [cell.contentView addSubview:timeLabel];
                        
                        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(60, 40, kScreenWidth - 70, 60)];
                        content.numberOfLines = 0;
                        content.text = [commityDic objectForKey:@"content"];
                        content.font = [UIFont systemFontOfSize:15.f];
                        [cell.contentView addSubview:content];
                    }
                    }else{
                    cell.textLabel.text = @"还没有评论";
                    }
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
     */
    return nil;
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        CGSize constraint = CGSizeMake(kScreenWidth, 20000.0f);
        CGSize size = [_productIntro boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.f]} context:nil].size;
        
        CGFloat height = MAX(size.height, 44.0f);
        return height;
    }
    if (indexPath.section == 4) {
        if (indexPath.row == [_dataArray count]) {
            return 42;
        }
    }
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 370;
    }
    if (section == 1) {
        return 35;
    }
    if (section == 2) {
        return 60;
    }
    if (section == 3) {
        return 33;
    }
    if (section == 4) {
        return 36;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 4) {
        return 44;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth , 370)];
        view.backgroundColor = [UIColor clearColor];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 15, kScreenWidth - 20, 350)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.masksToBounds = YES;
        backView.layer.cornerRadius = 3.f;
        backView.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
        backView.layer.borderWidth = 1.f;
        [view addSubview:backView];
        
        _photoScrollView = [[LOVPhotoScrollView alloc] initWithFrame:CGRectMake(5, 5, backView.frame.size.width - 10, backView.frame.size.height - 45)];
        _photoScrollView.delegate = self;
        [backView addSubview:_photoScrollView];
        
        [_photoScrollView setImagePathArray:_imageArray];
        
        if (_isShare) {
            UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, backView.frame.size.height - 25 - 35, 40, 15)];
            tagLabel.backgroundColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.3];
            tagLabel.font = [UIFont systemFontOfSize:14.f];
            tagLabel.textColor = [UIColor whiteColor];
            tagLabel.text = [NSString stringWithFormat:@"#%@",_tagName];
            [backView addSubview:tagLabel];
        }
        UILabel *salesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, backView.frame.size.height - 35, backView.frame.size.width/3 - (kScreenWidth - backView.frame.size.width)/6, 35)];
        salesLabel.backgroundColor = [UIColor clearColor];
        salesLabel.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
        salesLabel.layer.borderWidth = 0.5f;
        salesLabel.textAlignment = NSTextAlignmentCenter;
        salesLabel.text = [NSString stringWithFormat:@"销量%@件",_sales];
        salesLabel.font = [UIFont systemFontOfSize:14.f];
        [backView addSubview:salesLabel];
        
        UILabel *stockLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(salesLabel.frame), backView.frame.size.height - 35, kScreenWidth/3, 35)];
        stockLabel.backgroundColor = [UIColor clearColor];
        stockLabel.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
        stockLabel.layer.borderWidth = 0.5f;
        stockLabel.textAlignment = NSTextAlignmentCenter;
        stockLabel.text = [NSString stringWithFormat:@"库存%@件",_stock];
        stockLabel.font = [UIFont systemFontOfSize:14.f];
        [backView addSubview:stockLabel];
        
        UILabel *discussLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(stockLabel.frame), backView.frame.size.height - 35, backView.frame.size.width/3, 35)];
        discussLabel.backgroundColor = [UIColor clearColor];
        discussLabel.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
        discussLabel.layer.borderWidth = 0.5f;
        discussLabel.textAlignment = NSTextAlignmentCenter;
        discussLabel.text = [NSString stringWithFormat:@"评论%@条",_discussNum];
        discussLabel.font = [UIFont systemFontOfSize:14.f];
        [backView addSubview:discussLabel];
        
        return view;
    }
    if (section == 1) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
        backView.backgroundColor = [UIColor colorRGBWithRed:251 green:251 blue:251 alpha:1];
        _likeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, backView.frame.size.height - 35, backView.frame.size.width/3, 35)];
        _likeButton.backgroundColor = [UIColor clearColor];
        if ([_isLove isEqual:@"0"]) {
            [_likeButton setTitle:@"喜欢" forState:UIControlStateNormal];
            [_likeButton setTitleColor:[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:1] forState:UIControlStateNormal];
            [_likeButton setImage:[UIImage imageNamed:@"commission_like"] forState:UIControlStateNormal];
            _likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        }else{
            [_likeButton setTitle:@"已喜欢" forState:UIControlStateNormal];
            [_likeButton setTitleColor:[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] forState:UIControlStateNormal];
            [_likeButton setImage:[UIImage imageNamed:@"icon_selectIcon"] forState:UIControlStateNormal];
            _likeButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        }
        _likeButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _likeButton.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
        _likeButton.layer.borderWidth = 0.5f;
        [_likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:_likeButton];
        
        _addTag = [[UIButton alloc] initWithFrame:CGRectMake(backView.frame.size.width/3, backView.frame.size.height - 35, backView.frame.size.width/3, 35)];
        _addTag.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _addTag.backgroundColor = [UIColor clearColor];
        [_addTag setTitle:@"加入标签" forState:UIControlStateNormal];
        [_addTag setImage:[UIImage imageNamed:@"commission_comment"] forState:UIControlStateNormal];
        _addTag.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        [_addTag setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _addTag.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
        _addTag.layer.borderWidth = 0.5f;
        [_addTag addTarget:self action:@selector(commityButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:_addTag];
        
        _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(backView.frame.size.width/3*2, backView.frame.size.height - 35, backView.frame.size.width/3, 35)];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        _shareButton.backgroundColor = [UIColor clearColor];
        [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:@"commission_share"] forState:UIControlStateNormal];
        _shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        [_shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _shareButton.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
        _shareButton.layer.borderWidth = 0.5f;
        [_shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:_shareButton];
        return backView;
    }
    if (section == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
        view.backgroundColor = [UIColor colorRGBWithRed:251 green:251 blue:251 alpha:1];
        view.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
        view.layer.borderWidth = 0.5;
        UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
        [view addSubview:imageView];
        LOVCircle *circle = [[LOVCircle alloc] initWithFrame:CGRectMake(0, 0, 40, 40) imageWithPath:_header placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
        [imageView addSubview:circle];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, kScreenWidth - 60, 30)];
        nameLabel.textColor = [UIColor colorRGBWithRed:244 green:161 blue:180 alpha:1];
        nameLabel.text = _userName;
        nameLabel.font = [UIFont systemFontOfSize:15.f];
        [view addSubview:nameLabel];
        UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 35, kScreenWidth - 60, 20)];
        introLabel.font = [UIFont systemFontOfSize:12.f];
        introLabel.text = _userIntro;
        [view addSubview:introLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userMainInfo:)];
        [view addGestureRecognizer:tap];
        
        return view;
    }
    if (section == 3) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        view.backgroundColor = [UIColor colorRGBWithRed:251 green:251 blue:251 alpha:1];
        view.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
        view.layer.borderWidth = 0.5;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, kScreenWidth - 20, 30)];
        label.text = @"商品详情介绍";
        [view addSubview:label];
        return view;
    }
    if (section == 4) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        view.backgroundColor = [UIColor colorRGBWithRed:251 green:251 blue:251 alpha:1];
        view.layer.borderColor = [[UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
        view.layer.borderWidth = 0.5;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 22, 20)];
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = [UIImage imageNamed:@"icon_discuss"];
        [view addSubview:imageView];
        
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x + 30, 3, 165, 30)];
        myLabel.backgroundColor = [UIColor clearColor];
        myLabel.text = [NSString stringWithFormat:@"累计评价（%@）",_discussNum];
        myLabel.textColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.6];
        [view addSubview:myLabel];
        
        UILabel *saleLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 95, 3, 85, 30)];
        saleLable.text = [NSString stringWithFormat:@"销量%@>>",_sales];
        saleLable.font = [UIFont systemFontOfSize:16.f];
        saleLable.textColor = [UIColor colorWithWhite:0 alpha:0.6];
        [view addSubview:saleLable];
        return view;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 4) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
        view.backgroundColor = [UIColor clearColor];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 90, 5, 80, 35)];
        [button addTarget:self action:@selector(discussAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"评论" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 3.f;
        button.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        button.layer.borderWidth = 1.f;
        [view addSubview:button];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 5, kScreenWidth - 100, 35)];
        textField.backgroundColor = [UIColor whiteColor];
        //        textField.borderStyle = UITextBorderStyleLine;
        textField.placeholder = @" 您想说点什么";
        textField.font = [UIFont systemFontOfSize:15.f];
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 3.f;
        textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        textField.layer.borderWidth = 1.f;
        textField.delegate = self;
        [view addSubview:textField];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4&&indexPath.row == [_dataArray count]) {
        CommentViewController *commentVC = [[CommentViewController alloc] init];
        commentVC.commentStatu = MyCommentStatusProduct;
        commentVC.productId = _productId;
        commentVC.totleDiscussNum = _discussNum;
        [self.navigationController pushViewController:commentVC animated:YES];
    }
}

#pragma mark -- 监听事件

//发表评论触发按钮
- (void)discussAction:(UIButton *)sender{
    //---写评论页面
    _writeCommentView = [[LOVWriteCommentView alloc] init];
    _writeCommentView.alpha = 1.f;
    [_writeCommentView showWirteView];
    _writeCommentView.delegate = self;
    [self.view addSubview:_writeCommentView];
}
//喜欢按钮点击事件
- (void)likeButtonAction:(UIButton *)sender{
    NSLog(@"喜欢");
    NSString *sig = [UserManager readSig];
    if (sig.length > 0) {
        NSLog(@"喜欢");
        [FollowMeModel doFollowWithId:_productId type:1 block:^(int code) {
            if (code == 1) {
                _isLove = @"1";
                [self.tabelView reloadData];
            }else{
                _isLove = @"0";
                [self.tabelView reloadData];
            }
        }];
        
        
        
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    
}

//加入标签按钮点击事件
- (void)commityButtonAction:(UIButton *)sender{
    NSLog(@"加入标签");
    NSString *sig = [UserManager readSig];
    if (sig.length > 0) {
        _myWindow = [[UIWindow alloc] init];
        _myWindow.frame = [[UIScreen mainScreen] bounds];
        _myWindow.windowLevel = UIWindowLevelAlert;
        _myWindow.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [_myWindow makeKeyAndVisible];
        _myWindow.hidden = NO;
        
        [self reloadChoiceTagView];
    }else{
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:login animated:YES];
    }
    
}

- (void)reloadChoiceTagView{
    _choiceTagView = [[ChoiceTagView alloc] initWithFrame:CGRectMake(25, 85, kScreenWidth - 50, kScreenHeight - 190)];
    _choiceTagView.dataArray = _tagArray;
    _choiceTagView.delegate = self;
    _choiceTagView.backgroundColor = [UIColor whiteColor];
    _choiceTagView.layer.masksToBounds = YES;
    _choiceTagView.layer.cornerRadius = 3;
    //    [choiceTagView getTheDataArray:_dataArray];
    [_choiceTagView getTagDataListWithData:_tagNameArray];
    [_myWindow addSubview:_choiceTagView];

}

- (void)theTagListData:(NSNotification *)noti{
    [_tagArray removeAllObjects];
    [_tagNameArray removeAllObjects];
    [_tagArray addObjectsFromArray:noti.object];
    for (int i = 0; i < [_tagArray count]; i++) {
        AddTagModel *model = _tagArray[i];
        [_tagNameArray addObject:model.tagName];
    }
//    新建标签之后刷新标签列表
    if (isNewTag) {

        _choiceTagView = nil;
        [self reloadChoiceTagView];
    }
}

//- (void)hideWindow:(UITapGestureRecognizer *)tap{
//    _myWindow.hidden = YES;
//    _myWindow = nil;
//}

//分享按钮点击事件
- (void)shareButtonAction:(UIButton *)sender{
    NSLog(@"分享");
    LOVShareActivityView *shareView = [[LOVShareActivityView alloc] initWithShareType:LOVShareTypeSinaWeibo shareTitle:_productName shareDesc:_productIntro shareURL:[NSString stringWithFormat:@"%@%@",kShareMyLikeURL,_productId] shareImageURL:nil];
    [shareView show];
}

//进入个人主页
- (void)userMainInfo:(UITapGestureRecognizer *)tap{
    UserHomeViewController *userHomeVC = [[UserHomeViewController alloc] init];
    userHomeVC.userId = _userId;
    userHomeVC.userName = _userName;
    [self.navigationController pushViewController:userHomeVC animated:YES];
}


#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField != _myTextField) {
        //---写评论页面
        _writeCommentView = [[LOVWriteCommentView alloc] init];
        _writeCommentView.alpha = 1.f;
        [_writeCommentView showWirteView];
        _writeCommentView.delegate = self;
        [self.view addSubview:_writeCommentView];
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [_myTextField resignFirstResponder];
    return YES;
}

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

#pragma mark -- UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _myTextView.text = nil;
    return YES;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _tabelView) {
        tableViewContentOffset = _tabelView.contentOffset;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
