//
//  NewReciveAdressController.m
//  Love
//
//  Created by use on 14-12-3.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "NewReciveAdressController.h"
#import "CreateNewAdressModel.h"
#import "SVProgressHUD.h"
//-----获取省市区
//#define kAllAddressKey     @"ProvinceCityDistrict"

@interface NewReciveAdressController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
{
    NSString *provinceID;
    NSString *cityID;
    NSString *districtID;
    NSString *provinceName;
    NSString *cityName;
    NSString *districtName;
}
@property (nonatomic ,strong) UIPickerView *pickerView;
@property (nonatomic ,strong) UIToolbar *pickerToolbar;

@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableArray *cityDataArray;
@property (nonatomic ,strong) NSMutableArray *districtDataArray;
@property (nonatomic ,strong) NSMutableArray *provinceArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic ,strong) NSMutableArray *districtArray;

@property (nonatomic, strong) NSMutableArray *provinceIDArr;
@property (nonatomic, strong) NSMutableArray *cityIDArr;
@property (nonatomic, strong) NSMutableArray *districtIDArr;

@end

@implementation NewReciveAdressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = MyLocalizedString(@"新建地址");
    _dataArray = [[NSMutableArray alloc] init];//存放所有的地址数据
    _cityDataArray = [[NSMutableArray alloc] init];//存放对应城市的数据
    _districtDataArray = [[NSMutableArray alloc] init];//存放对应区县的数据
    _provinceArray = [[NSMutableArray alloc] init];//存放所有省名称数据
    _cityArray = [[NSMutableArray alloc] init];//存放对应省下的城市名称
    _districtArray = [[NSMutableArray alloc] init];//存放对应区县下的区县名称
    
    _provinceIDArr = [[NSMutableArray alloc] init];//省id
    _cityIDArr = [[NSMutableArray alloc] init];//市ID
    _districtIDArr = [[NSMutableArray alloc] init];//区县id
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAllAddressData:)
                                                 name:kAllAddressNotificationName
                                               object:nil];
    
    
    [self changeTextFieldHeight];
    
    UIButton *withdrawButton = [UIButton buttonWithType:UIButtonTypeCustom];
    withdrawButton.frame = CGRectMake(0, 0, 80, 36.f);
    withdrawButton.backgroundColor = [UIColor clearColor];
    [withdrawButton setTitle:MyLocalizedString(@"保存") forState:UIControlStateNormal];
    [withdrawButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    withdrawButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [withdrawButton addTarget:self action:@selector(saveAddress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithCustomView:withdrawButton];
    self.navigationItem.rightBarButtonItem = saveBarButton;
    
}

- (void)getAllAddressData:(NSNotification*)noti{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _dataArray = [userDefaults objectForKey:kAllAddressKey];
    [SVProgressHUD dismiss];
    for (int i = 0 ; i < [_dataArray count]; i++) {
        [_provinceArray addObject:[_dataArray[i] objectForKey:@"name"]];
        [_provinceIDArr addObject:[_dataArray[i] objectForKey:@"id"]];
    }
    
    [_cityDataArray addObject:[_dataArray[0] objectForKey:@"shi"]];
    for (int i = 0 ; i < [[_cityDataArray lastObject] count]; i++) {
        [_cityArray addObject:[[_cityDataArray lastObject][i] objectForKey:@"name"]];
    }
    [_districtDataArray addObject:[[_cityDataArray lastObject][0] objectForKey:@"qu"]];
    for (int i = 0; i < [[_districtDataArray lastObject] count]; i++) {
        [_districtArray addObject:[[_districtDataArray lastObject][i] objectForKey:@"name"]];
    }
    provinceName = _provinceArray[0];
    provinceID = _provinceIDArr[0];
    cityName = [[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"name"];
    cityID = [[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"id"];
    if ([[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] count] > 0) {
        districtName = [[[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] objectAtIndex:0] objectForKey:@"name"];
        districtID = [[[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] objectAtIndex:0] objectForKey:@"id"];
    }
    _address.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
    [self initDataSource];
    [self.pickerView reloadAllComponents];
}

- (void)saveAddress:(UIButton*)button{
    if (provinceID.length == 0 || cityID.length == 0 || districtID.length == 0 || _detailAddress.text.length == 0 || _phoneNum.text.length == 0 || _postCode.text.length == 0 || _reciveName.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"所有项均为必填项") delegate:self cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [CreateNewAdressModel getCreateNewsAddressDataPostType:@"1"
                                                   andProvince:provinceID
                                                       andCity:cityID
                                                   andDistrict:districtID
                                                    andAddress:_detailAddress.text
                                                     andMobile:_phoneNum.text
                                                    andZipcode:_postCode.text
                                                  andConsignee:_reciveName.text block:^(int code, NSString *msg) {
                                                      if (code == 1) {
                                                          if ([self.delegate respondsToSelector:@selector(reloadTableViewData)]) {
                                                              [self.delegate reloadTableViewData];
                                                          }
                                                          [self.navigationController popViewControllerAnimated: YES];
                                                      }else{
                                                          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"创建地址失败") delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                                                          [alertView show];
                                                      }
                                                  }];
    }
    
}

//修改textField的高度
- (void)changeTextFieldHeight{
    _address.frame = CGRectMake(18, 8, kScreenWidth - 28, 25);
    
    _line1.frame = CGRectMake(0, 60, kScreenWidth, 1);
    _line2.frame = CGRectMake(0, 130, kScreenWidth, 1);
    _line3.frame = CGRectMake(0, 200, kScreenWidth, 1);
    _line5.frame = CGRectMake(0, 270, kScreenWidth, 1);
    _line4.frame = CGRectMake(0, 340, kScreenWidth, 1);
    
    CGRect rect = _detailAddress.frame;
    rect.size.height = 50;
    rect.size.width = kScreenWidth - 20;
    _detailAddress.frame = rect;
    _detailAddress.delegate = self;
    _detailAddress.placeholder = MyLocalizedString(@"详细地址");
    
    CGRect rect1 = _reciveName.frame;
    rect1.size.height = 50;
    rect1.size.width = kScreenWidth - 20;
    _reciveName.frame = rect1;
    _reciveName.delegate = self;
    _reciveName.placeholder = MyLocalizedString(@"收货人姓名");
    
    CGRect rect2 = _phoneNum.frame;
    rect2.size.height = 50;
    rect2.size.width = kScreenWidth - 20;
    _phoneNum.frame = rect2;
    _phoneNum.delegate = self;
    _phoneNum.placeholder = MyLocalizedString(@"联系电话");
    _phoneNum.keyboardType = UIKeyboardTypeNumberPad;
    
    CGRect rect3 = _postCode.frame;
    rect3.size.height = 50;
    rect3.size.width = kScreenWidth - 20;
    _postCode.frame = rect3;
    _postCode.delegate = self;
    _postCode.keyboardType = UIKeyboardTypeNumberPad;
    _postCode.placeholder = MyLocalizedString(@"邮编");
    
}

- (void)initDataSource{
    [_cityDataArray removeAllObjects];
    [_cityDataArray addObject: [_dataArray[0] objectForKey:@"shi"]];
    [_cityArray removeAllObjects];
    [_cityIDArr removeAllObjects];
    for (int i = 0; i < [[_cityDataArray lastObject] count]; i++) {
        [_cityArray addObject:[[_cityDataArray lastObject][i] objectForKey:@"name"]];
        [_cityIDArr addObject:[[_cityDataArray lastObject][i] objectForKey:@"id"]];
    }
    [self.pickerView selectRow:0 inComponent:1 animated:YES];
    [self.pickerView reloadComponent:1];
    
    cityName = _cityArray[0];
    cityID = _cityIDArr[0];
    provinceName = _provinceArray[0];
    provinceID = _provinceIDArr[0];
    
    
    [_districtDataArray removeAllObjects];
    [_districtDataArray addObject: [[_cityDataArray lastObject][0] objectForKey:@"qu"]];
    if ([_districtDataArray lastObject]) {
        [_districtArray removeAllObjects];
        [_districtIDArr removeAllObjects];
        for (int i = 0; i < [[_districtDataArray lastObject] count]; i++) {
            [_districtArray addObject:[[_districtDataArray lastObject][i] objectForKey:@"name"]];
            [_districtIDArr addObject:[[_districtDataArray lastObject][i] objectForKey:@"id"]];
        }
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
        [self.pickerView reloadComponent:2];
        districtName = _districtArray[0];
        districtID = _districtIDArr[0];
        self.address.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
    }else{
        self.address.text = [NSString stringWithFormat:@"%@ %@",provinceName,cityName];
    }
}
#pragma mark -- UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return [_provinceArray count];
    }
    if (component == 1) {
        return [_cityArray count];
    }
    if (component == 2) {
        return [_districtArray count];
    }
    return 0;
}

#pragma mark -- UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component == 0) {
        return 60;
    }
    if (component == 1) {
        return 100;
    }
    return 160;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        if ([_provinceArray count] > 0) {
            return [_provinceArray objectAtIndex:row];
        }
    }
    if (component == 1) {
        if ([_cityArray count] > 0) {
            return _cityArray[row];
        }
    }
    if (component == 2) {
        if ([_districtArray count] > 0) {
            return _districtArray[row];
        }
    }
    return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        [_cityDataArray removeAllObjects];
        [_cityDataArray addObject: [_dataArray[row] objectForKey:@"shi"]];
        [_cityArray removeAllObjects];
        [_cityIDArr removeAllObjects];
        for (int i = 0; i < [[_cityDataArray lastObject] count]; i++) {
            [_cityArray addObject:[[_cityDataArray lastObject][i] objectForKey:@"name"]];
            [_cityIDArr addObject:[[_cityDataArray lastObject][i] objectForKey:@"id"]];
        }
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView reloadComponent:1];
        
        cityName = _cityArray[0];
        cityID = _cityIDArr[0];
        provinceName = _provinceArray[row];
        provinceID = _provinceIDArr[row];
        
        
        [_districtDataArray removeAllObjects];
        [_districtDataArray addObject: [[_cityDataArray lastObject][0] objectForKey:@"qu"]];
        if ([_districtDataArray lastObject]) {
            [_districtArray removeAllObjects];
            [_districtIDArr removeAllObjects];
            for (int i = 0; i < [[_districtDataArray lastObject] count]; i++) {
                [_districtArray addObject:[[_districtDataArray lastObject][i] objectForKey:@"name"]];
                [_districtIDArr addObject:[[_districtDataArray lastObject][i] objectForKey:@"id"]];
            }
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            [self.pickerView reloadComponent:2];
            districtName = _districtArray[0];
            districtID = _districtIDArr[0];
            self.address.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
        }else{
            self.address.text = [NSString stringWithFormat:@"%@ %@",provinceName,cityName];
        }
        
        
        
    }
    if (component == 1) {
        cityName = _cityArray[row];
        cityID = _cityIDArr[row];
        [_districtDataArray removeAllObjects];
        [_districtDataArray addObject: [[_cityDataArray lastObject][row] objectForKey:@"qu"]];
        //        _districtDataArray = [[_cityDataArray lastObject][row] objectForKey:@"qu"];
        if ([[_districtDataArray lastObject] count] > 0) {
            [_districtArray removeAllObjects];
            [_districtIDArr removeAllObjects];
            for (int i = 0; i < [[_districtDataArray lastObject] count]; i++) {
                [_districtArray addObject:[[_districtDataArray lastObject][i] objectForKey:@"name"]];
                [_districtIDArr addObject:[[_districtDataArray lastObject][i] objectForKey:@"id"]];
            }
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            [self.pickerView reloadComponent:2];
            districtName = _districtArray[0];
            districtID = _districtIDArr[0];
            self.address.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
        }
        else{
            [_districtArray removeAllObjects];
            [_districtIDArr removeAllObjects];
            [self.pickerView reloadComponent:2];
            self.address.text = [NSString stringWithFormat:@"%@ %@",provinceName,cityName];
        }
        
    }
    if (component == 2) {
        if ([_districtDataArray lastObject]) {
            districtName = _districtArray[row];
            districtID = _districtIDArr[row];
            self.address.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAllAddressNotificationName object:nil];
}

- (IBAction)choiceAddress:(id)sender {
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 214, kScreenWidth, 150)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self.view addSubview:_pickerView];
    
    _pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 214 - 30, kScreenWidth, 30)];
    _pickerToolbar.backgroundColor = [UIColor grayColor];
    UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:MyLocalizedString(@"Cancel") style:UIBarButtonItemStylePlain target:self action:@selector(removeFromSuperView)];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:MyLocalizedString(@"确定") style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    _pickerToolbar.items=@[lefttem,centerSpace,right];
    [self.view addSubview:_pickerToolbar];
    [self.view bringSubviewToFront:_pickerToolbar];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _dataArray = [userDefaults objectForKey:kAllAddressKey];
    if (!_dataArray) {
        [CreateNewAdressModel getAllProvinceAndData];
        [SVProgressHUD show];
    }else{
        for (int i = 0 ; i < [_dataArray count]; i++) {
            [_provinceArray addObject:[_dataArray[i] objectForKey:@"name"]];
            [_provinceIDArr addObject:[_dataArray[i] objectForKey:@"id"]];
        }
        [_cityDataArray removeAllObjects];
        [_cityDataArray addObject:[_dataArray[0] objectForKey:@"shi"]];
        for (int i = 0 ; i < [[_cityDataArray lastObject] count]; i++) {
            [_cityArray removeAllObjects];
            [_cityArray addObject:[[_cityDataArray lastObject][i] objectForKey:@"name"]];
        }
        [_districtDataArray removeAllObjects];
        [_districtDataArray addObject:[[_cityDataArray lastObject][0] objectForKey:@"qu"]];
        [_districtArray removeAllObjects];
        for (int i = 0; i < [[_districtDataArray lastObject] count]; i++) {
            [_districtArray addObject:[[_districtDataArray lastObject][i] objectForKey:@"name"]];
        }
        
        //    _cityArray =
        
        provinceName = _provinceArray[0];
        provinceID = _provinceIDArr[0];
        cityName = [[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"name"];
        cityID = [[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"id"];
        if ([[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] count] > 0) {
            districtName = [[[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] objectAtIndex:0] objectForKey:@"name"];
            districtID = [[[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] objectAtIndex:0] objectForKey:@"id"];
        }
        _address.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
        [self initDataSource];
    }
    [_pickerView reloadAllComponents];
}

- (void)removeFromSuperView{
    [UIView animateWithDuration:0.3
                     animations:^{
                         _pickerView.frame = CGRectMake(0, _pickerView.frame.origin.y+_pickerView.frame.size.height, _pickerView.frame.size.width, _pickerView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [_pickerView removeFromSuperview];
                     }];
    [_pickerToolbar removeFromSuperview];
    _address.text = nil;
}

- (void)done{
    [UIView animateWithDuration:0.3
                     animations:^{
                         _pickerView.frame = CGRectMake(0, _pickerView.frame.origin.y+_pickerView.frame.size.height, _pickerView.frame.size.width, _pickerView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [_pickerView removeFromSuperview];
                         
                     }];
    [_pickerToolbar removeFromSuperview];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_pickerView removeFromSuperview];
}
#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [_pickerView removeFromSuperview];
    [self done];
    
    return YES;
}

@end
