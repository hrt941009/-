//
//  CenterViewController.m
//  Love
//
//  Created by 李伟 on 14-6-26.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "CenterViewController.h"
#import "HeaderViewController.h"
#import "MyAccountViewController.h"
#import "BirthdayViewController.h"
#import "AddressViewController.h"
#import "QREncoderViewController.h"
#import "ChangeUserInfoController.h"
#import "SellerIdentifySetup1ViewController.h"
#import "BindingEmailViewController.h"
#import "LOVCircle.h"
#import "UserManager.h"
#import "UserInfoModel.h"
#import "CreateNewAdressModel.h"
#import "LoginModel.h"
#import "UploadImageModel.h"
#import "GenerationImage.h"

#import "APPNetworkClient.h"
#import "AFNetworking.h"
#import "APPNetworkClient.h"

typedef NS_ENUM(NSInteger, CenterActionSheetTag)
{
    CenterActionSheetTagWithHeader = 1,
    CenterActionSheetTagWithSex
};

typedef NS_ENUM(NSInteger, CenterAlertViewTag)
{
    CenterAlertViewTagWithNickName = 1,
    CenterAlertViewTagWithRealName,
    CenterAlertViewTagWithSign,
    CenterAlertViewTagWithCancle
};

@interface CenterViewController ()<UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, CenterViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSString *provinceName;
    NSString *provinceID;
    NSString *cityName;
    NSString *cityID;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIPickerView *birthdayPickerView, *addressPickerView;
@property (nonatomic, strong) UIDatePicker *dataPicker;
@property (nonatomic, strong) UIView *pickerBgView;
@property (nonatomic, strong) UIToolbar *pickerToolBar;

@property (nonatomic, strong) NSArray *sectionArray1, *sectionArray2, *sectionArray3;
@property (nonatomic, strong) NSArray *sectionDataArray1, *sectionDataArray2;

@property (nonatomic, strong) BirthdayViewController *birthdayViewController;

@property (nonatomic, strong) NSString *dataStr;

@property (nonatomic, strong) NSMutableArray *provinceDataArray;
@property (nonatomic, strong) NSMutableArray *cityDataArray;
@property (nonatomic, strong) NSMutableArray *provinceArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *provinceIDArr;
@property (nonatomic, strong) NSMutableArray *cityIDArr;

@end

@implementation CenterViewController


#pragma mark - set view
- (void)setCenterView
{
    //-----
    CGRect tvRect = CGRectMake(0, 0, self.view.frame.size.width, kScreenHeight - 66.f - 50.f);
    _tableView = [[UITableView alloc] initWithFrame:tvRect style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.scrollEnabled = YES;
    [self.view addSubview:_tableView];
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake((kScreenWidth - 260)/2, kScreenHeight - 66.f - 40.f, 260, 30);
    cancleButton.backgroundColor = [UIColor colorRGBWithRed:230 green:60 blue:105 alpha:1];
//    cancleButton.titleLabel.text = @"注销";
    [cancleButton setTitle:@"注销" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancleButton.layer.masksToBounds = YES;
    cancleButton.layer.cornerRadius = 3.f;
    [cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleButton];
    
}

- (void)cancleButtonAction:(UIButton*)sender{
    NSLog(@"注销");
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"注销" message:@"您确定注销账户？" delegate:self cancelButtonTitle:MyLocalizedString(@"Cancel") otherButtonTitles:MyLocalizedString(@"OK"), nil];
    alertView.tag = CenterAlertViewTagWithCancle;
    [alertView show];
    
}




#pragma mark - init
- (id)init
{
    self = [super init];
    if (self) {
        self.title = MyLocalizedString(@"个人信息");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _sectionArray1 = @[@"昵称", @"个性签名", @"我的优惠码",@"性别", @"生日", @"地区"];
    _sectionArray2 = @[@"买手中心"];
    _sectionArray3 = @[];
    
    [self setCenterView];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userCenterInfoNotice:)
                                                 name:kUserInfoNotificationName
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAllAddressProvinceData:)
                                                 name:kAllAddressNotificationName
                                               object:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    _birthdayViewController = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUserInfoNotificationName object:nil];
}

#pragma mark - reload data
- (void)reloadUserInfoData
{
    NSString *uid = [UserManager readUid];
    [UserInfoModel getUserInfoWithUserID:uid];
}

#pragma mark - notice
- (void)userCenterInfoNotice:(NSNotification *)notice
{
    _dataList = nil;
    NSArray *array = [notice object];
    _dataList = array;
    [_tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return [_sectionArray1 count];
    }
    if (section == 2) {
        return 0;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSInteger section = indexPath.section;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];

    }
    
    if ([_dataList count] > 0) {
        UserInfoModel *model = (UserInfoModel *)_dataList[0];
        if (section == 0) {
            cell.detailTextLabel.text = @"更改头像";
            LOVCircle *header = [[LOVCircle alloc] initWithFrame:CGRectMake(5.f, 5.f, 40.f, 40.f)
                                                   imageWithPath:model.headerPath
                                                placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
            [cell.contentView addSubview:header];
            
        }
        if (section == 1) {
            cell.textLabel.text = _sectionArray1[indexPath.row];
            if (indexPath.row == 0) {
                cell.detailTextLabel.text = model.userName;
            }
//            if (indexPath.row == 1) {
//                cell.detailTextLabel.text = model.userRealName;
//            }
//            if (indexPath.row == 1) {
//                cell.detailTextLabel.text = @"未设置";
//            }
            if (indexPath.row == 1) {
                cell.detailTextLabel.text = model.userIntro;
                cell.detailTextLabel.numberOfLines = 3;
                cell.detailTextLabel.font = [UIFont systemFontOfSize:11.f];
            }
            if (indexPath.row == 2) {
                
            }
            if (indexPath.row == 3) {
                cell.detailTextLabel.text = model.userSex;
            }
            if (indexPath.row == 4) {
                cell.detailTextLabel.text = model.userBirthday;
            }
            if (indexPath.row == 5) {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", model.userProvince, model.userCity];
            }
        }
//        if (section == 2) {
//            cell.textLabel.text = _sectionArray2[indexPath.row];
//        }
    }
  
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 8.f;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView  = [[UIView alloc] init];
    sectionView.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    return sectionView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 54.f;
    }
    return 40.f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIAlertView  *alertView = nil;
    UIActionSheet *actionSheet = nil;
    NSInteger section = [indexPath section];
    UserInfoModel *model = (UserInfoModel *)_dataList[0];
    
    if (section == 0) {

        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
        actionSheet.tag = CenterActionSheetTagWithHeader;
        [actionSheet showInView:_tableView];
        
        
        
    }
    if (section == 1) {
        if (indexPath.row == 0) {
            ChangeUserInfoController *change = [[ChangeUserInfoController alloc] init];
            change.title = _sectionArray1[indexPath.row];
            change.statusStr = _sectionArray1[indexPath.row];
            change.status = indexPath.row;
            change.delegate = self;
            [self.navigationController pushViewController:change animated:YES];
            

        }

        if (indexPath.row == 1) {
            ChangeUserInfoController *change = [[ChangeUserInfoController alloc] init];
            change.title = _sectionArray1[indexPath.row];
            change.statusStr = _sectionArray1[indexPath.row];
            [self.navigationController pushViewController:change animated:YES];
            change.status = indexPath.row;
            change.delegate = self;
        }
        if (indexPath.row == 2) {
            QREncoderViewController *encoderViewController = [[QREncoderViewController alloc] init];
            encoderViewController.title = _sectionArray1[indexPath.row];
            encoderViewController.couponCode = model.couponCode;
            [self.navigationController pushViewController:encoderViewController animated:YES];
        }
        if (indexPath.row == 3) {
            actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择性别"
                                                      delegate:self
                                             cancelButtonTitle:MyLocalizedString(@"Cancel")
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:@"男", @"女", nil];
            actionSheet.tag = CenterActionSheetTagWithSex;
            [actionSheet showInView:_tableView];
        }
        if (indexPath.row == 4) {
            _dataPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kScreenHeight - 246, kScreenWidth, 246)];
            _dataPicker.datePickerMode = UIDatePickerModeDate;
            _dataPicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            NSDate *now = [[NSDate alloc] initWithTimeIntervalSinceNow:1];
            _dataPicker.maximumDate = now;
            _dataPicker.backgroundColor = [UIColor whiteColor];
            [_dataPicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
            [self.view addSubview:_dataPicker];
            [self.view bringSubviewToFront:_dataPicker];
            
//            datePicker上方的toolBar
            _pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 246 - 30, kScreenWidth, 30)];
            _pickerToolBar.backgroundColor = [UIColor grayColor];
            UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
            
            UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
            
            UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
            _pickerToolBar.items=@[lefttem,centerSpace,right];
            [self.view addSubview:_pickerToolBar];
            [self.view bringSubviewToFront:_pickerToolBar];
            
        }
        if (indexPath.row == 5) {
//            AddressViewController *addressViewController = [[AddressViewController alloc] initWithNibName:@"AddressViewController" bundle:nil];
//            addressViewController.delegate = self;
//            [self.navigationController pushViewController:addressViewController animated:YES];

            _provinceDataArray = [[NSMutableArray alloc] init];
            _provinceArray = [[NSMutableArray alloc] init];
            _provinceIDArr = [[NSMutableArray alloc] init];
            _cityDataArray = [[NSMutableArray alloc] init];
            _cityArray = [[NSMutableArray alloc] init];
            _cityIDArr = [[NSMutableArray alloc] init];
            
//                判断userDefaults里面是否存有数据，没有则下载数据
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            _provinceDataArray = [userDefaults objectForKey:kAllAddressKey];
            
            if ([_provinceDataArray lastObject] == nil) {
                [CreateNewAdressModel getAllProvinceAndData];
                [SVProgressHUD show];
            }else{
                
                _addressPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 246, kScreenWidth, 246)];
                _addressPickerView.backgroundColor = [UIColor whiteColor];
                _addressPickerView.dataSource = self;
                _addressPickerView.delegate = self;
                [self.view addSubview:_addressPickerView];
                
                //            datePicker上方的toolBar
                _pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 246 - 30, kScreenWidth, 30)];
                _pickerToolBar.backgroundColor = [UIColor grayColor];
                UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
                
                UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
                
                UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClickaForAddress)];
                _pickerToolBar.items=@[lefttem,centerSpace,right];
                [self.view addSubview:_pickerToolBar];
                [self.view bringSubviewToFront:_pickerToolBar];
                
                
                for (int i = 0 ; i < [_provinceDataArray count]; i++) {
                    [_provinceArray addObject:[_provinceDataArray[i] objectForKey:@"name"]];
                    [_provinceIDArr addObject:[_provinceDataArray[i] objectForKey:@"id"]];
                }
                
                [_cityDataArray removeAllObjects];
                [_cityDataArray addObject:[_provinceDataArray[0] objectForKey:@"shi"]];
                
                [_cityArray removeAllObjects];
                for (int i = 0 ; i < [[_cityDataArray lastObject] count]; i++) {
                    [_cityArray addObject:[[_cityDataArray lastObject][i] objectForKey:@"name"]];
                }
                    
                    //    _cityArray =
                    
                provinceName = _provinceArray[0];
                provinceID = _provinceIDArr[0];
                cityName = [[[_provinceDataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"name"];
                cityID = [[[_provinceDataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"id"];
            }
            [_addressPickerView reloadAllComponents];
                
        }
    }
    if (section == 2) {
        if (indexPath.row == 0) {
            SellerIdentifySetup1ViewController *identifyViewController = [[SellerIdentifySetup1ViewController alloc] initWithNibName:@"SellerIdentifySetup1ViewController" bundle:nil];
            UserInfoModel *model = (UserInfoModel *)_dataList[0];
            identifyViewController.imgUrl = model.headerPath;
            [self.navigationController pushViewController:identifyViewController animated:YES];
            
        }
    }
}

//如果userDefaults里面没有存在数据，下载数据返回
- (void)getAllAddressProvinceData:(NSNotification*)noti{
    _addressPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 246, kScreenWidth, 246)];
    _addressPickerView.backgroundColor = [UIColor whiteColor];
    _addressPickerView.dataSource = self;
    _addressPickerView.delegate = self;
    [self.view addSubview:_addressPickerView];
    [SVProgressHUD dismiss];
    //            datePicker上方的toolBar
    _pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 246 - 30, kScreenWidth, 30)];
    _pickerToolBar.backgroundColor = [UIColor grayColor];
    UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClickaForAddress)];
    _pickerToolBar.items=@[lefttem,centerSpace,right];
    [self.view addSubview:_pickerToolBar];
    [self.view bringSubviewToFront:_pickerToolBar];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _provinceDataArray = [userDefaults objectForKey:kAllAddressKey];
    for (int i = 0 ; i < [_provinceDataArray count]; i++) {
        [_provinceArray addObject:[_provinceDataArray[i] objectForKey:@"name"]];
        [_provinceIDArr addObject:[_provinceDataArray[i] objectForKey:@"id"]];
    }
    
    [_cityDataArray addObject:[_provinceDataArray[0] objectForKey:@"shi"]];
    for (int i = 0 ; i < [[_cityDataArray lastObject] count]; i++) {
        [_cityArray addObject:[[_cityDataArray lastObject][i] objectForKey:@"name"]];
    }
    
    //    _cityArray =
    
    provinceName = _provinceArray[0];
    provinceID = _provinceIDArr[0];
    cityName = [[[_provinceDataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"name"];
    cityID = [[[_provinceDataArray[0] objectForKey:@"shi"] objectAtIndex:0] objectForKey:@"id"];
    
    [_addressPickerView reloadAllComponents];

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
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        [_cityDataArray removeAllObjects];
        [_cityDataArray addObject: [_provinceDataArray[row] objectForKey:@"shi"]];
        [_cityArray removeAllObjects];
        [_cityIDArr removeAllObjects];
        for (int i = 0; i < [[_cityDataArray lastObject] count]; i++) {
            [_cityArray addObject:[[_cityDataArray lastObject][i] objectForKey:@"name"]];
            [_cityIDArr addObject:[[_cityDataArray lastObject][i] objectForKey:@"id"]];
        }
        [self.addressPickerView selectRow:0 inComponent:1 animated:YES];
        [self.addressPickerView reloadComponent:1];
        
        cityName = _cityArray[0];
        cityID = _cityIDArr[0];
        provinceName = _provinceArray[row];
        provinceID = _provinceIDArr[row];
    }
    if (component == 1) {
        if ([_cityIDArr count] == 0) {
            [_cityIDArr removeAllObjects];
            for (int i = 0; i < [[_cityDataArray lastObject] count]; i++) {
                [_cityIDArr addObject:[[_cityDataArray lastObject][i] objectForKey:@"id"]];
            }
        }
        cityName = _cityArray[row];
        cityID = _cityIDArr[row];
    }
}

//toolbar上取消按钮触发事件
- (void)remove{
    NSLog(@"取消");
    [UIView animateWithDuration:0.3
                     animations:^{
                         _dataPicker.frame = CGRectMake(0, _dataPicker.frame.origin.y+_dataPicker.frame.size.height, _dataPicker.frame.size.width, _dataPicker.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [_dataPicker removeFromSuperview];
                         
                     }];
    [UIView animateWithDuration:0.3
                     animations:^{
                         _addressPickerView.frame = CGRectMake(0, _addressPickerView.frame.origin.y+_dataPicker.frame.size.height, _addressPickerView.frame.size.width, _addressPickerView.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [_addressPickerView removeFromSuperview];
                         
                     }];
    [_pickerToolBar removeFromSuperview];
//    [_dataPicker removeFromSuperview];
//    [_addressPickerView removeFromSuperview];
}
//toolbar上确认按钮触发事件
- (void)doneClick{
    NSLog(@"确认");
    [UserInfoModel eidtBirthday:_dataStr block:^(int code) {
        if (code == 1) {
            [self reloadUserInfoData];
            [_pickerToolBar removeFromSuperview];
            [UIView animateWithDuration:0.3
                             animations:^{
                                 _dataPicker.frame = CGRectMake(0, _dataPicker.frame.origin.y+_dataPicker.frame.size.height, _dataPicker.frame.size.width, _dataPicker.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 [_dataPicker removeFromSuperview];
                                 
                             }];
//            [_dataPicker removeFromSuperview];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"修改失败"
                                                               delegate:self
                                                      cancelButtonTitle:MyLocalizedString(@"OK")
                                                      otherButtonTitles:nil];
            [alertView show];
            [_pickerToolBar removeFromSuperview];
            [_dataPicker removeFromSuperview];
        }
    }];
    
    
    
}
//点击修改地址选择器的确认触发事件
- (void)doneClickaForAddress{
    [UserInfoModel eidtAddressProvince:provinceID andCity:cityID block:^(int code) {
        if (code == 1) {
            [self reloadUserInfoData];
            [UIView animateWithDuration:0.3
                             animations:^{
                                 _addressPickerView.frame = CGRectMake(0, _addressPickerView.frame.origin.y+_dataPicker.frame.size.height, _addressPickerView.frame.size.width, _addressPickerView.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 [_addressPickerView removeFromSuperview];
                                 
                             }];
//            [_addressPickerView removeFromSuperview];
            [_pickerToolBar removeFromSuperview];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"修改失败"
                                                               delegate:self
                                                      cancelButtonTitle:MyLocalizedString(@"OK")
                                                      otherButtonTitles:nil];
            [alertView show];
            [UIView animateWithDuration:0.3
                             animations:^{
                                 _addressPickerView.frame = CGRectMake(0, _addressPickerView.frame.origin.y+_dataPicker.frame.size.height, _addressPickerView.frame.size.width, _addressPickerView.frame.size.height);
                             }
                             completion:^(BOOL finished){
                                 [_addressPickerView removeFromSuperview];
                                 
                             }];
            [_pickerToolBar removeFromSuperview];
        }
    }];

}

- (void)selectDate:(UIDatePicker*)sender{
    NSDate *date = _dataPicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *outputString = [formatter stringFromDate:date];
    _dataStr = outputString;
}

#pragma mark -  segmentedControl
- (void)segmentedControlAction:(UISegmentedControl *)control
{
    NSLog(@"%ld", (unsigned long)control.numberOfSegments);
}

#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == CenterActionSheetTagWithSex) {
        if (buttonIndex == 0) {
            NSLog(@"男");
            [UserInfoModel eidtUserSex:@"1" block:^(int code) {
                if (code == 1) {
                    [self reloadUserInfoData];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"修改失败，请重试！" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                    [alertView show];
                }
            }];
            
//            [self reloadUserInfoData];
        }
        if (buttonIndex == 1) {
            NSLog(@"女");
            
            [UserInfoModel eidtUserSex:@"0" block:^(int code) {
                if (code == 1) {
                    [self reloadUserInfoData];
                }else{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"修改失败，请重试！" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                    [alertView show];
                }
                
            }];
            
//            [self reloadUserInfoData];
        }
        if (buttonIndex == 2) {
            NSLog(@"取消");
        }
    }
    if (actionSheet.tag == CenterActionSheetTagWithHeader) {
        if (buttonIndex == 0) {
            NSLog(@"拍照");
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = NO;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:nil];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"")
                                                                message:@""
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }
        if (buttonIndex == 1) {
            NSLog(@"相册");
            NSLog(@"%@",NSStringFromSelector(_cmd));
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = NO;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
        }
        if (buttonIndex == 2) {
            NSLog(@"取消");
        }
    }
}

#pragma mark - alert view delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (alertView.tag == CenterAlertViewTagWithNickName) {
//        if (buttonIndex == 1) {
//            UITextField *textField = [alertView textFieldAtIndex:0];
//            [UserInfoModel eidtUserName:textField.text];
//            
//            [self reloadUserInfoData];
//        }
//    }
    if (alertView.tag == CenterAlertViewTagWithRealName) {
        if (buttonIndex == 1) {
            UITextField *textField = [alertView textFieldAtIndex:0];
            [UserInfoModel eidtRealName:textField.text];

            [self reloadUserInfoData];
        }
    }
    if (alertView.tag == CenterAlertViewTagWithCancle) {
        if (buttonIndex == 1) {
            if ([_delegate respondsToSelector:@selector(removeMeViewSubviews)]) {
                [_delegate removeMeViewSubviews];
            }
            NSString *key = [UserManager readSig];
            if ([key length] > 0) {
                [LoginModel logoutMyApp];
                [UserManager restKeychain];
                self.tabBarController.selectedIndex = 0;
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kCenterLogoutNotification" object:nil userInfo:nil];
        }
    }
//    if (alertView.tag == CenterAlertViewTagWithSign) {
//        if (buttonIndex == 1) {
//            UITextField *textField = [alertView textFieldAtIndex:0];
//            [UserInfoModel eidtUserIntro:textField.text];
//
//            [self reloadUserInfoData];
//        }
//    }
}

#pragma mark - birthday delegate
- (void)backUserCenter
{
    [self reloadUserInfoData];
}

#pragma mark - imagepickercontroller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [SVProgressHUD showWithStatus:@"等待图片上传..."];
    //对图片大小进行压缩--
    UIImage *samllImage = [GenerationImage cutImage:image];
    NSString *uid = [UserManager readUid];
    NSDictionary *dic = @{@"uid":uid};
    [UploadImageModel uploadHeaderImage:samllImage
                              imageName:nil
                                 parmas:dic
                                  block:^(int code, NSString *msg) {
                                      if (code == 1) {
                                          [self reloadUserInfoData];
                                          [SVProgressHUD dismiss];
                                      }else{
                                          [SVProgressHUD dismiss];
                                          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"上传图片失败，请重试" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                                          [alertView show];
                                      }
                                  }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
