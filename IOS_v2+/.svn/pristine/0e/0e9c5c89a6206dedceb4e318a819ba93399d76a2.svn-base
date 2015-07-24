//
//  OrderAddressViewController.m
//  Love
//
//  Created by lee wei on 14-8-11.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "OrderAddressViewController.h"

static float const componentProvince = 60.f;
static float const componentCity = 140.f;
static float const componentCounty = 120.f;

@interface OrderAddressViewController ()<UIScrollViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) IBOutlet UIView *bgView;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField, *codeTextField, *addressTextField, *phoneTextField;
@property (nonatomic, strong) IBOutlet UILabel *provinceLabel, *cityLabel, *countyLabel;
@property (nonatomic, strong) IBOutlet UIButton *pickerViewButton;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *provinceArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *countyArray;

@end

@implementation OrderAddressViewController

#pragma mark - view
/**
 页面参数
 */
- (void)setOrderAddressView
{
    _bgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _bgView.layer.borderWidth = 0.5;
    _bgView.layer.cornerRadius = 5.f;
    
    _nameTextField.delegate = self;
    
    _provinceLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _provinceLabel.layer.borderWidth = 0.5;
    
    _cityLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _cityLabel.layer.borderWidth = 0.5;
    
    _countyLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _countyLabel.layer.borderWidth = 0.5;
    
    _codeTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _codeTextField.layer.borderWidth = 0.5;
    _codeTextField.delegate = self;
    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _addressTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _addressTextField.layer.borderWidth = 0.5;
    _addressTextField.delegate = self;
    
    _phoneTextField.delegate = self;
    _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _pickerViewButton.tag = OrderAddressButtonWithTagPicker;
    [_pickerViewButton addTarget:self action:@selector(orderAddressButtonAction: withEvent:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"收货地址");
        
        _provinceArray = [[NSMutableArray alloc] init];
        _cityArray = [[NSMutableArray alloc] init];
        _countyArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //--test data
    NSArray *array1 = @[@"北京", @"上海"];
    [_provinceArray addObjectsFromArray:array1];
    [_cityArray addObjectsFromArray:array1];
    [_countyArray addObjectsFromArray:array1];
    
    //---
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(0, 0, 80, 36.f);
    submitButton.backgroundColor = [UIColor clearColor];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:18.f];
    submitButton.tag = OrderAddressButtonWithTagSubmit;
    [submitButton addTarget:self action:@selector(orderAddressButtonAction: withEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *submitBarButton = [[UIBarButtonItem alloc] initWithCustomView:submitButton];
    self.navigationItem.rightBarButtonItem = submitBarButton;
    
    //----
    [self setOrderAddressView];
    
    //---
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 280.f, self.view.frame.size.width, 216.f)];
    [_pickerView setBackgroundColor:[UIColor colorWithRed:245 green:255 blue:90 alpha:1]];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
    _pickerView.alpha = 0;
    [_pickerView selectRow:0 inComponent:0 animated:YES];
    [self.view addSubview:_pickerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _pickerView.alpha = 0;
    
    //_scrollView.scrollEnabled = YES;
//    if (textField == _codeTextField) {
//        [_scrollView setContentOffset:CGPointMake(0, 80.f) animated:YES];
//    }
//    if (textField == _addressTextField) {
//        [_scrollView setContentOffset:CGPointMake(0, 120.f) animated:YES];
//    }
//    if (textField == _phoneTextField) {
//        [_scrollView setContentOffset:CGPointMake(0, 140.f) animated:YES];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - button action
- (void)orderAddressButtonAction:(id)sender  withEvent:(UIEvent *)event
{
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag;
    
    if (tag == OrderAddressButtonWithTagPicker) {
        [_nameTextField resignFirstResponder];
        [_codeTextField resignFirstResponder];
        [_addressTextField resignFirstResponder];
        [_phoneTextField resignFirstResponder];
        
        _pickerView.alpha = 1.f;
    }
    if (tag == OrderAddressButtonWithTagSubmit) {
        [_nameTextField resignFirstResponder];
        [_codeTextField resignFirstResponder];
        [_addressTextField resignFirstResponder];
        [_phoneTextField resignFirstResponder];
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [_provinceArray count];
    }
    if (component == 1) {
        return [_cityArray count];
    }
    if (component == 2) {
        return [_countyArray count];
    }
    return 1;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return componentProvince;
            break;
        case 1:
            return componentCity;
            break;
        case 2:
            return componentCounty;
            break;
        default:
            return 0;
            break;
    }
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return _provinceArray[row];
            break;
        case 1:
            return _cityArray[row];
            break;
        case 2:
            return _countyArray[row];
            break;
        default:
            return @"";
            break;
    }
    
    [_pickerView reloadAllComponents];
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            //-----privince----
            _provinceLabel.text = _provinceArray[row];
            
            //-----city----
            _cityLabel.text = _cityArray[row];
            
            //-----county----
            _countyLabel.text = _countyArray[row];
            
            [_pickerView selectRow:0 inComponent:2 animated:YES];
            [_pickerView reloadComponent:2];
            break;
        case 1:
            //-----city----
            _cityLabel.text = _cityArray[row];
            
            //-----county----
            _countyLabel.text = _countyArray[row];
            
            [_pickerView selectRow:0 inComponent:2 animated:YES];
            [_pickerView reloadComponent:2];
            break;
        case 2:
            //-----county----
            _countyLabel.text = _countyArray[row];
            break;
            
        default:
            break;
    }

    
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label  = nil;
    CGFloat labelHeight = 44.f;
    
    switch (component) {
        case 0:
            label = view?(UILabel *)view : [[UILabel alloc] initWithFrame:CGRectMake(0, 0, componentProvince, labelHeight)];
            label.text = _provinceArray[row];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.adjustsFontSizeToFitWidth = YES;
            label.font = [UIFont systemFontOfSize:16.f];
            return label;
            break;
        case 1:
            label = view?(UILabel *)view : [[UILabel alloc] initWithFrame:CGRectMake(0, 0, componentCounty, labelHeight)];
            label.text = _cityArray[row];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.adjustsFontSizeToFitWidth = YES;
            label.font = [UIFont systemFontOfSize:16.f];
            return label;
            break;
        case 2:
            label = view?(UILabel *)view : [[UILabel alloc] initWithFrame:CGRectMake(0, 0, componentCounty, labelHeight)];
            label.text = _countyArray[row];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.adjustsFontSizeToFitWidth = YES;
            label.font = [UIFont systemFontOfSize:16.f];
            return label;
            break;
        default:
            label.text = @"";
            return label;
            break;
    }
    
    //CFShow发送description给它显示的对象，CFShow打印的信息不会显示时间戳，NSLog会显示，同时CFShow不需要格式字符串，它只能用于对象
    //CFShow(label);
    
    return label;
}


@end
