//
//  PublishMainViewController.m
//  Love
//
//  Created by use on 15-3-30.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "PublishMainViewController.h"
#import "PublishProductViewController.h"
#import "LOVNavigationController.h"
#import "EditePicureViewController.h"
#import "LoginViewController.h"

#import "PublicModel.h"
#import "UserManager.h"
#import "UploadReturnImageModel.h"
#import "GenerationImage.h"

#import "SVProgressHUD.h"

@interface PublishMainViewController ()<UITextViewDelegate,ImageDataDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    int                 choiceNum;
    UILabel             *tagLabel;
    UITextField         *myTextField;
    UIView              *imageBgView;
    UIView              *bottomView;
    UILabel             *titleLabel;
}
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) NSDictionary *addressDic;

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) NSMutableArray *imgUrlArray;

@property (nonatomic, strong) UIPickerView *myPickerView;

@property (nonatomic, strong) NSMutableArray *dataArray;//获取到的标签列表模型数组
@property (nonatomic, strong) NSMutableArray *tagNameArray;
@property (nonatomic, strong) NSMutableArray *tagIdArray;

@property (nonatomic, strong) EditePicureViewController *editePictureController;

@end

@implementation PublishMainViewController

#pragma mark -- UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_dataArray count];
}

#pragma mark -- UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _tagNameArray[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    choiceNum = (int)row;
    tagLabel.text = _tagNameArray[row];
}


#pragma mark -- ImageDataDelegate
- (void)imageDataWith:(UIImage *)image andUrl:(NSString *)imgUrl{
    _choiceImage = image;
    _imgUrl = imgUrl;
}
#pragma mark -- UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    textView.text = nil;
    return YES;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    _bgScrollView.contentOffset = CGPointMake(kScreenWidth, 568);
    _imageArray = [[NSMutableArray alloc] init];
    _imgUrlArray = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    _tagNameArray = [[NSMutableArray alloc] init];
    _tagIdArray = [[NSMutableArray alloc] init];
    imageBgView = [[UIView alloc] initWithFrame:CGRectZero];
    [_topBgView addSubview:imageBgView];
    _bgScrollView.showsVerticalScrollIndicator = NO;
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getTagListData:) name:kPublishTagListNotificationName
                                               object:nil];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    leftButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [leftButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = backBarButton;
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = doneBarButton;
    
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 100.f;
    if (isLocation) {
        //        [_locationManager requestAlwaysAuthorization];
        [_locationManager startUpdatingLocation];
    }else{
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"请打开定位权限" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [myAlertView show];
    }
    
    [PublicModel getPublishTagList];
    
    [self setCenterView];
    
    if (_isShare) {
        bottomView = nil;
        [self setBottomView];
    }
}

- (void)setBottomView{
    [_bottomBgView removeFromSuperview];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 10, 80, 20)];
    titleLabel.text = @"美妆类型:";
    titleLabel.font = [UIFont systemFontOfSize:18.f];
    [bottomView addSubview:titleLabel];
    
    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, kScreenWidth - 120, 25)];
    myTextField.backgroundColor = [UIColor clearColor];
    myTextField.placeholder = @"夏日清新妆感";
    [bottomView addSubview:myTextField];
}

- (void)getTagListData:(NSNotification *)noti{
    
    [_dataArray addObjectsFromArray:noti.object];
    for (int i = 0; i < [_dataArray count]; i++) {
        PublicModel *model = _dataArray[i];
        [_tagNameArray addObject:[NSString stringWithFormat:@"# %@",model.tagName]];
        [_tagIdArray addObject:model.tagId];
    }
    [_myPickerView reloadAllComponents];
}

- (void)hiddenBntAction:(UIButton *)sender{
    tagLabel.text = _tagNameArray[choiceNum];
    _myPickerView.hidden = YES;
    [bottomView setHidden:NO];
    _centerBgView.frame = CGRectMake(0, CGRectGetMaxY(_topBgView.frame) + 13, kScreenWidth, 73);
}

- (void)setImageScrollView{
//    _topScrollView.backgroundColor = [UIColor clearColor];
//    _topScrollView.contentSize = CGSizeMake(([_imageArray count] * 90) > kScreenWidth?([_imageArray count] * 90):kScreenWidth, 60);
    [_topScrollView removeFromSuperview];
    if ([_imageArray count] < 10) {
        if ([_imageArray count] == 9) {
            _topBgView.frame = CGRectMake(0, 0, kScreenWidth, 275 + (kScreenWidth - 60)/3 * (8/3));
            imageBgView.frame = CGRectMake(0, 105, kScreenWidth, 110 + (kScreenWidth - 60)/3 * (8/3));
        }else{
            _topBgView.frame = CGRectMake(0, 0, kScreenWidth, 275 + (kScreenWidth - 60)/3 * ([_imageArray count]/3));
            imageBgView.frame = CGRectMake(0, 105, kScreenWidth, 110 + (kScreenWidth - 60)/3 * ([_imageArray count]/3));
        }
    }
    _bgScrollView.contentSize = CGSizeMake(kScreenWidth, _topBgView.frame.size.height + _centerBgView.frame.size.height + _bottomBgView.frame.size.height + 100);
    if ([_imageArray count] > 0 && [_imageArray count] < 10) {
        for (int i = 0; i < [_imageArray count]; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 + (((kScreenWidth - 60)/3) + 15) * (i%3),  (((kScreenWidth - 60)/3) + 5) * (i/3), (kScreenWidth - 60)/3, (kScreenWidth - 60)/3)];
            imageView.image = _imageArray[i];
//            imageView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//            imageView.layer.borderWidth = 1.f;
            imageView.userInteractionEnabled = YES;
            [imageBgView addSubview:imageView];
            
            UIButton *cancleBnt = [[UIButton alloc] initWithFrame:CGRectMake(-5, -5 , 15, 15)];
            cancleBnt.backgroundColor = [UIColor clearColor];
            cancleBnt.tag = 200 + i;
            [cancleBnt setBackgroundImage:[UIImage imageNamed:@"image_delete"] forState:UIControlStateNormal];
            [cancleBnt addTarget:self action:@selector(cacleImageAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:cancleBnt];
        }
    }
    if ([_imageArray count] < 9) {
        UIImageView *addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 + (((kScreenWidth - 60)/3) + 15) * ([_imageArray count]%3),  (((kScreenWidth - 60)/3) + 5) * ([_imageArray count]/3), (kScreenWidth - 60)/3, (kScreenWidth - 60)/3)];
        addImageView.backgroundColor = [UIColor clearColor];
        addImageView.userInteractionEnabled = YES;
        addImageView.image = [UIImage imageNamed:@"icon_addImage"];
        [imageBgView addSubview:addImageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choiceImageAction:)];
        [addImageView addGestureRecognizer:tap];
    }
    _locationImageView.frame = CGRectMake(13, CGRectGetMaxY(_topBgView.frame) - 34, 15, 20);
    _addressLabel.frame = CGRectMake(36, CGRectGetMaxY(_topBgView.frame) - 34, kScreenWidth - 36 - 60, 21);
    _topSwitch.frame = CGRectMake(kScreenWidth - 55, CGRectGetMaxY(_topBgView.frame) - 40, 49, 31);
    _centerBgView.frame = CGRectMake(0, CGRectGetMaxY(_topBgView.frame) + 13, kScreenWidth, 73);
    _bottomBgView.frame = CGRectMake(0, CGRectGetMaxY(_centerBgView.frame) + 13, kScreenWidth, 140);
    if (_isShare) {
        bottomView.frame = CGRectMake(0, CGRectGetMaxY(_centerBgView.frame) + 13, kScreenWidth, 45);
    }
}

- (void)cacleImageAction:(UIButton *)sender{
    int number = (int)[sender tag] - 200;
    [_imageArray removeObjectAtIndex:number];
//    [_imgUrlArray removeObjectAtIndex:number];
//    _topScrollView = nil;
    for (UIView *vi in imageBgView.subviews) {
        [vi removeFromSuperview];
    }
    [self setImageScrollView];
}

- (void)choiceImageAction:(UIButton *)sender{
    PublishProductViewController *productController = [[PublishProductViewController alloc] init];
    productController.isAddImage = YES;
    productController.delegate = self;
    [self.navigationController pushViewController:productController animated:YES];
}


- (void)setIbFrame{
    _bgScrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
//    _bgScrollView.contentSize = CGSizeMake(kScreenWidth, 568);
    _topBgView.frame = CGRectMake(0, 0, kScreenWidth, 235);
    _centerBgView.frame = CGRectMake(0, 248, kScreenWidth, 73);
    _bottomBgView.frame = CGRectMake(0, 337, kScreenWidth, 140);
    _topTextView.frame = CGRectMake(8, 0, kScreenWidth - 16, 100);
    _topScrollView.frame = CGRectMake(8, 110, kScreenWidth - 16, 85);
    _topScrollView.backgroundColor = [UIColor lightGrayColor];
    _topSwitch.frame = CGRectMake(kScreenWidth - 61, 196, 51, 31);
    _addressLabel.frame=  CGRectMake(36, 201, kScreenWidth - 36 - 61, 21);
    _productTextField.frame = CGRectMake(91, 4, kScreenWidth - 101, 30);
    _productTextField.borderStyle = UITextBorderStyleNone;
    _priceTextField.frame = CGRectMake(91, 55, kScreenWidth - 101, 30);
    _priceTextField.borderStyle = UITextBorderStyleNone;
    _stockTextField.frame = CGRectMake(91, 99, kScreenWidth - 101, 30);
    _stockTextField.borderStyle = UITextBorderStyleNone;
    _line1.frame = CGRectMake(8, 44, kScreenWidth - 8, 1);
    _line2.frame = CGRectMake(8, 92, kScreenWidth - 8, 1);
    
    _topTextView.delegate = self;
}

- (void)setMySwitch{
    _topSwitch.onTintColor = [UIColor colorRGBWithRed:225 green:62 blue:106 alpha:0.8];
    [_topSwitch setOn:YES animated:YES];
    [_topSwitch addTarget:self action:@selector(switchOpenAction:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)setCenterView{
    UIButton *centerRightBnt = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 70, 10, 60, 20)];
    [centerRightBnt setTitle:@"确定" forState:UIControlStateNormal];
    [centerRightBnt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    centerRightBnt.titleLabel.textAlignment = NSTextAlignmentRight;
    [centerRightBnt addTarget:self action:@selector(hiddenBntAction:) forControlEvents:UIControlEventTouchUpInside];
    [_centerBgView addSubview:centerRightBnt];
    
    _myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(8, 50, kScreenWidth - 16, 100)];
    _myPickerView.backgroundColor = [UIColor whiteColor];
    _myPickerView.delegate = self;
    _myPickerView.dataSource = self;
    _myPickerView.hidden = YES;
    [_centerBgView addSubview:_myPickerView];
    
    tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 35, kScreenWidth - 16, 25)];
    tagLabel.text = @"  # 美白";
    tagLabel.layer.masksToBounds = YES;
    tagLabel.layer.cornerRadius = 3.f;
    tagLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    tagLabel.layer.borderWidth = 1.f;
    tagLabel.userInteractionEnabled = YES;
    [_centerBgView addSubview:tagLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choiceTagAction:)];
    [tagLabel addGestureRecognizer:tap];
}

- (void)cancleButtonAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//上传发布
- (void)doneButtonAction:(UIButton *)sender{
    NSString *sig = [UserManager readSig];
    if (sig.length > 0) {
        if (_isShare) {
            if (_topTextView.text.length == 0 || [_topTextView.text isEqual:@"填写商品介绍或特点，让你的商品更生动"]){
                [SVProgressHUD showErrorWithStatus:@"请填写商品简介"];
            }else if ([_imageArray count] == 0){
                [SVProgressHUD showWithStatus:@"请至少添加一张图片"];
            }else if (myTextField.text.length == 0){
                [SVProgressHUD showErrorWithStatus:@"请填写美妆类型"];
            }else{
                [SVProgressHUD showWithStatus:@"正在上传图片，请稍等..."];
                for (int i = 0; i < [_imageArray count]; i++) {
                    UIImage *image = [GenerationImage cutImage:[_imageArray objectAtIndex:i]];
                    [UploadReturnImageModel uploadReturnImage:image imageName:nil parmas:nil block:^(int code, NSString *msg) {
                        [_imgUrlArray addObject:msg];
                        if ([_imgUrlArray count] == [_imageArray count]) {
                            [SVProgressHUD dismiss];
                            
                            NSString *imgUrlList = _imgUrlArray[0];
                            if ([_imgUrlArray count] > 1) {
                                for (int i = 1; i < [_imgUrlArray count]; i++) {
                                    imgUrlList = [NSString stringWithFormat:@"%@_%@",imgUrlList,_imgUrlArray[i]];
                                }
                            }
                            [PublicModel publicShareWithTagId:_tagIdArray[choiceNum] Title:myTextField.text Intro:_topTextView.text ImgList:imgUrlList Location:_addressLabel.text block:^(int code, NSString *msg) {
                                if (code == 1) {
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                    if ([_delegate respondsToSelector:@selector(dismissTheViewController)]) {
                                        [_delegate dismissTheViewController];
                                    }
                                }else{
                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                    [alertView show];
                                }
                            }];
                        }
                    }];
                }
            }
        }else{
            if (_productTextField.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请填写商品名称"];
            }else if (_topTextView.text.length == 0 || [_topTextView.text isEqual:@"填写商品介绍或特点，让你的商品更生动"]){
                [SVProgressHUD showErrorWithStatus:@"请填写商品简介"];
            }else if (_stockTextField.text.length == 0){
                [SVProgressHUD showErrorWithStatus:@"请填写商品库存"];
            }else if ([_imageArray count] == 0){
                [SVProgressHUD showErrorWithStatus:@"请选择至少一张图片"];
            }else if (_priceTextField.text.length == 0){
                [SVProgressHUD showErrorWithStatus:@"请填写商品价格"];
            }else{
                [SVProgressHUD showWithStatus:@"正在上传图片，请稍等..."];
                for (int i = 0; i < [_imageArray count]; i++) {
                    UIImage *image = [GenerationImage cutImage:[_imageArray objectAtIndex:i]];
                    [UploadReturnImageModel uploadReturnImage:image imageName:nil parmas:nil block:^(int code, NSString *msg) {
                        [_imgUrlArray addObject:msg];
                        if ([_imgUrlArray count] == [_imageArray count]) {
                            [SVProgressHUD dismiss];
                            
                            NSString *imgUrlList = _imgUrlArray[0];
                            if ([_imgUrlArray count] > 1) {
                                for (int i = 1; i < [_imgUrlArray count]; i++) {
                                    imgUrlList = [NSString stringWithFormat:@"%@_%@",imgUrlList,_imgUrlArray[i]];
                                }
                            }
                            [PublicModel publicProductWithTagId:_tagIdArray[choiceNum] ProductName:_productTextField.text Intro:_topTextView.text Stock:_stockTextField.text ImgList:imgUrlList Location:_addressLabel.text Price:_priceTextField.text blcok:^(int code, NSString *msg) {
                                if (code == 1) {
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                    if ([_delegate respondsToSelector:@selector(dismissTheViewController)]) {
                                        [_delegate dismissTheViewController];
                                    }
                                }else{
                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                                    [alertView show];
                                }
                            }];
                        }
                    }];
                }
            }
        }
    }else{
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [self.navigationController pushViewController:login animated:YES];
    }
}

- (void)switchOpenAction:(id)sender{
    UISwitch *mySwitch = (UISwitch *)sender;
    if (mySwitch.isOn) {
//        NSLog(@"kai");
        [_locationManager startUpdatingLocation];
    }else{
//        NSLog(@"guan");
        [_locationManager stopUpdatingLocation];
    }
}
//展示标签选择
- (void)choiceTagAction:(UITapGestureRecognizer *)sender{
    _myPickerView.hidden = NO;
    _centerBgView.frame = CGRectMake(0, CGRectGetMaxY(_topBgView.frame) + 13, kScreenWidth, 273);
    [bottomView setHidden:YES];
    [self.view bringSubviewToFront:_centerBgView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([CLLocationManager locationServicesEnabled]) {
        [_locationManager startUpdatingLocation];
    }else{
        UIAlertView *aleryView = [[UIAlertView alloc] initWithTitle:nil message:@"请在隐私设置里打开定位服务" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [aleryView show];
    }
    [_imageArray addObject:_choiceImage];
//    [_imgUrlArray addObject:_imgUrl];
    [self setIbFrame];
    [self setMySwitch];
    [self setImageScrollView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_myPickerView setHidden:YES];
    [bottomView setHidden:NO];
}

#pragma mark -- CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray *)locations{
    
    CLLocation *currentLocation = [locations lastObject];
    CLLocationCoordinate2D coor = currentLocation.coordinate;
    NSLog(@"%f,%f",coor.latitude,coor.longitude);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *mark = [placemarks objectAtIndex:0];
        _addressDic = mark.addressDictionary;
        NSLog(@"%@",_addressDic);
        _addressLabel.text = [NSString stringWithFormat:@"%@ %@",[_addressDic objectForKey:@"State"],[_addressDic objectForKey:@"City"]];
        
    }];
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied) {
        NSLog(@"访问被拒绝");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
    }
    [_locationManager stopUpdatingLocation];
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
