//
//  AddressViewController.m
//  Love
//
//  Created by lee wei on 14-10-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "AddressViewController.h"
#import "UserInfoModel.h"
#import "CreateNewAdressModel.h"

@interface AddressViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSString *provinceID;
    NSString *cityID;
    NSString *provinceName;
    NSString *cityName;
}
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UIPickerView *addressPicker;

@property (nonatomic, strong) UIBarButtonItem *doneBarButton;

@property (nonatomic, strong) NSMutableArray *provinceDataArray;
@property (nonatomic, strong) NSMutableArray *provinceArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *cityDataArray;
@end

@implementation AddressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"设置地址");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _provinceDataArray = [[NSMutableArray alloc] init];
    _provinceArray = [[NSMutableArray alloc] init];
    _cityDataArray = [[NSMutableArray alloc] init];
    _cityArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getProvinceArray:)
                                                 name:kCreateNewAddressNotificationName
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getCityArray:)
                                                 name:kCityNotificationName
                                               object:nil];
    
    
    
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 0, 80, 44.f);
    doneButton.backgroundColor = [UIColor clearColor];
    [doneButton setTitle:MyLocalizedString(@"Done") forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(editAddressAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    _doneBarButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = doneBarButton;
    
//    [CreateNewAdressModel getAllProvinceDataFromFatherID:@"0"];
    
    _addressLabel.text = _address;
    
}

- (void)editAddressAction{
    [UserInfoModel eidtAddressProvince:provinceID andCity:cityID block:^(int code) {
        if (code == 1) {
            [_delegate backUserCenter];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"修改失败"
                                                               delegate:self
                                                      cancelButtonTitle:MyLocalizedString(@"OK")
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }];
}

- (void)getProvinceArray:(NSNotification*)noti{
    [_provinceDataArray addObject:noti.object];
    for (int i= 0; i < [[_provinceDataArray lastObject] count]; i++) {
        CreateNewAdressModel *model = (CreateNewAdressModel*)[_provinceDataArray lastObject][i];
        [_provinceArray addObject:model.name];
    }
    CreateNewAdressModel *firstModel = (CreateNewAdressModel*)[_provinceDataArray lastObject][0];
    provinceID = firstModel.provinceId;
    provinceName = firstModel.name;
//    [CreateNewAdressModel getCityDataFromFatherID:firstModel.provinceId];
}

- (void)getCityArray:(NSNotification*)noti{
    [_cityDataArray addObject:noti.object];
    [_cityArray removeAllObjects];
    for (int i = 0; i < [[_cityDataArray lastObject] count]; i++) {
        CreateNewAdressModel *model = (CreateNewAdressModel*)[_cityDataArray lastObject][i];
        [_cityArray addObject:model.name];
    }
    CreateNewAdressModel *firstModel = (CreateNewAdressModel*)[_cityDataArray lastObject][0];
    cityID = firstModel.provinceId;
    cityName = firstModel.name;
    _addressLabel.text = [NSString stringWithFormat:@"%@  %@",provinceName,cityName];
    _addressPicker.dataSource = self;
    _addressPicker.delegate = self;
    [_addressPicker reloadComponent:1];
    [_addressPicker reloadComponent:2];
    
}
#pragma mark -- UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return [_provinceArray count];
    }
    if (component == 1) {
        return [_cityArray count];
    }
    return 0;
}

#pragma mark -- UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return _provinceArray[row];
    }
    if (component == 1) {
        return _cityArray[row];
    }
    return 0;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        CreateNewAdressModel *model = (CreateNewAdressModel*)[_provinceDataArray lastObject][row];
        provinceID = model.provinceId;
        provinceName = model.name;
//        [CreateNewAdressModel getCityDataFromFatherID:provinceID];
    }
    if (component == 1) {
        CreateNewAdressModel *model = (CreateNewAdressModel*)[_cityDataArray lastObject][row];
        cityID = model.provinceId;
        cityName = model.name;
    }
    _addressLabel.text = [NSString stringWithFormat:@"%@  %@",provinceName,cityName];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCreateNewAddressNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCityNotificationName object:nil];
}

@end
