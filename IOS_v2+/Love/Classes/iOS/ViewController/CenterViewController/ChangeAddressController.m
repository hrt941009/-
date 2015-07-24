//
//  ChangeAddressController.m
//  Love
//
//  Created by use on 14-12-5.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ChangeAddressController.h"
#import "ChangeAddressModel.h"
#import "CreateNewAdressModel.h"
#import "SVProgressHUD.h"

@interface ChangeAddressController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSString *provinceName;
    NSString *cityName;
    NSString *districtName;
}
@property (nonatomic ,strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *pickerToolbar;

@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) NSMutableArray *cityDataArray;
@property (nonatomic ,strong) NSMutableArray *districtDataArray;
@property (nonatomic ,strong) NSMutableArray *provinceArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic ,strong) NSMutableArray *districtArray;
@property (nonatomic, strong) NSMutableArray *provinceIDArr;
@property (nonatomic, strong) NSMutableArray *cityIDArr;
@property (nonatomic, strong) NSMutableArray *districtIDArr;
@property (weak, nonatomic) IBOutlet UIButton *choiceButon;

@end

@implementation ChangeAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    _addressLabel.text = _addressStr;
    _detailAddress.text = _addrStr;
    _getName.text = _getNameStr;
    _phoneNum.text = _phoneNumStr;
    _zipcode.text = _zipcodeStr;
    
//    _dataArray = [[NSMutableArray alloc] init];
//    _cityDataArray = [[NSMutableArray alloc] init];
//    _districtDataArray = [[NSMutableArray alloc] init];
//    _provinceArray = [[NSMutableArray alloc] init];
//    _cityArray = [[NSMutableArray alloc] init];
//    _districtArray = [[NSMutableArray alloc] init];
//    _provinceIDArr = [[NSMutableArray alloc] init];
//    _cityIDArr = [[NSMutableArray alloc] init];
//    _districtIDArr = [[NSMutableArray alloc] init];
    
    _dataArray = [[NSMutableArray alloc] init];//存放所有的地址数据
    _cityDataArray = [[NSMutableArray alloc] init];//存放对应城市的数据
    _districtDataArray = [[NSMutableArray alloc] init];//存放对应区县的数据
    _provinceArray = [[NSMutableArray alloc] init];//存放所有省名称数据
    _cityArray = [[NSMutableArray alloc] init];//存放对应省下的城市名称
    _districtArray = [[NSMutableArray alloc] init];//存放对应区县下的区县名称
    
    _provinceIDArr = [[NSMutableArray alloc] init];//省id
    _cityIDArr = [[NSMutableArray alloc] init];//市ID
    _districtIDArr = [[NSMutableArray alloc] init];//区县id
    
    _addressLabel.frame = CGRectMake(10, 30, kScreenWidth - 60, 52);
    _choiceButon.frame = CGRectMake(kScreenWidth - 55, 41, 45, 30);
    
    CGRect detailRect = _detailAddress.frame;
    detailRect.size.height = 50;
    detailRect.size.width = kScreenWidth - 20;
    _detailAddress.frame = detailRect;
    
    CGRect getNameRect = _getName.frame;
    getNameRect.size.height = 50;
    getNameRect.size.width = kScreenWidth - 20;
    _getName.frame = getNameRect;
    
    CGRect phoneNumRect = _phoneNum.frame;
    phoneNumRect.size.height = 50;
    phoneNumRect.size.width = kScreenWidth - 20;
    _phoneNum.frame = phoneNumRect;
    
    CGRect zipCodeRect = _zipcode.frame;
    zipCodeRect.size.height = 50;
    zipCodeRect.size.width = kScreenWidth - 20;
    _zipcode.frame = zipCodeRect;
    
    _addressLabel.numberOfLines = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAllAddressData:)
                                                 name:kAllAddressNotificationName
                                               object:nil];
    
    
    UIButton *withdrawButton = [UIButton buttonWithType:UIButtonTypeCustom];
    withdrawButton.frame = CGRectMake(0, 0, 80, 36.f);
    withdrawButton.backgroundColor = [UIColor clearColor];
    [withdrawButton setTitle:MyLocalizedString(@"保存") forState:UIControlStateNormal];
    [withdrawButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    withdrawButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [withdrawButton addTarget:self action:@selector(saveChangeAddress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithCustomView:withdrawButton];
    self.navigationItem.rightBarButtonItem = saveBarButton;
}



- (void)saveChangeAddress:(id)sender{
    if (_provinceId.length == 0 || _cityId.length == 0 || _districtId.length == 0 || _detailAddress.text.length == 0 || _phoneNum.text.length == 0 || _zipcode.text.length == 0 || _getName.text.length == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"所有项均为必填项") delegate:self cancelButtonTitle:MyLocalizedString(@"确定") otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [ChangeAddressModel getDetailAddressType:@"2" andAddressId:_addressId andProvinceId:_provinceId andCityId:_cityId andDistrictId:_districtId andDetailAddr:_detailAddress.text andMobile:_phoneNum.text andZipcode:_zipcode.text andConsignee:_getName.text block:^(int code, NSString *msg) {
            if (code == 1) {
                if ([self.delegate respondsToSelector:@selector(reloadChangeAddressData)]) {
                    
                    [self.delegate reloadChangeAddressData];
                    
                }
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:MyLocalizedString(@"地址修改失败") delegate:nil cancelButtonTitle:MyLocalizedString(@"确定") otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAllAddressNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kChangeAddressNotificationName object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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
        
        UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:MyLocalizedString(@"OK") style:UIBarButtonItemStylePlain target:self action:@selector(done)];
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
        
        [_cityDataArray addObject:[_dataArray[0] objectForKey:@"shi"]];
        for (int i = 0 ; i < [[_cityDataArray lastObject] count]; i++) {
            [_cityArray addObject:[[_cityDataArray lastObject][i] objectForKey:@"name"]];
        }
        
        [_districtDataArray addObject:[[_cityDataArray lastObject][0] objectForKey:@"qu"]];
        for (int i = 0; i < [[_districtDataArray lastObject] count]; i++) {
            [_districtArray addObject:[[_districtDataArray lastObject][i] objectForKey:@"name"]];
        }
        
        //    _cityArray =
        
        provinceName = _provinceArray[0];
        _provinceId = _provinceIDArr[0];
        cityName = [[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"name"];
        _cityId = [[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"id"];
        if ([[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] count] > 0) {
            districtName = [[[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] objectAtIndex:0] objectForKey:@"name"];
            _districtId = [[[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] objectAtIndex:0] objectForKey:@"id"];
        }
        _addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
    }
    
    
    
    [_pickerView reloadAllComponents];
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
    
    
    
    //    _cityArray =
    
    provinceName = _provinceArray[0];
    _provinceId = _provinceIDArr[0];
    cityName = [[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"name"];
    _cityId = [[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"id"];
    if ([[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] count] > 0) {
        districtName = [[[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] objectAtIndex:0] objectForKey:@"name"];
        _districtId = [[[[[_dataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"qu"] objectAtIndex:0] objectForKey:@"id"];
    }
    _addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
    
    
    [self.pickerView reloadAllComponents];
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
    _addressLabel.text = _addressStr;
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
    
    _addressLabel.text = [NSString stringWithFormat:@"%@%@%@",provinceName,cityName,districtName];
    
}

#pragma mark -- UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
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
        _cityId = _cityIDArr[0];
        provinceName = _provinceArray[row];
        _provinceId = _provinceIDArr[row];
        
        
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
            _districtId = _districtIDArr[0];
            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
        }else{
            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@",provinceName,cityName];
        }
        
        
        
    }
    if (component == 1) {
        cityName = _cityArray[row];
        _cityId = _cityIDArr[row];
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
            _districtId = _districtIDArr[0];
            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
        }
        else{
            [_districtArray removeAllObjects];
            [_districtIDArr removeAllObjects];
            [self.pickerView reloadComponent:2];
            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@",provinceName,cityName];
        }
        
    }
    if (component == 2) {
        if ([_districtDataArray lastObject]) {
            districtName = _districtArray[row];
            _districtId = _districtIDArr[row];
            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,districtName];
        }
        
    }
}

@end
