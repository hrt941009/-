//
//  BirthdayViewController.m
//  Love
//
//  Created by lee wei on 14-10-2.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "BirthdayViewController.h"
#import "NSDate+Additions.h"
#import "UserInfoModel.h"

@interface BirthdayViewController ()

@property (nonatomic, strong) IBOutlet UILabel *birthdayLabel;
@property (nonatomic, strong) IBOutlet UIDatePicker *birthdayPicker;

@property (nonatomic, strong) UIBarButtonItem *doneBarButton;
@property (nonatomic, strong) NSString *postString;

@end

@implementation BirthdayViewController

- (NSString *)birthdayDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:date];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"设置生日");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 0, 80, 44.f);
    doneButton.backgroundColor = [UIColor clearColor];
    [doneButton setTitle:MyLocalizedString(@"Done") forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(editBirthdayAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    _doneBarButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = doneBarButton;
    
    //
    _birthdayLabel.text = _birthday;
    
    [_birthdayPicker addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectDate:(id)sender
{
    _doneBarButton.enabled = YES;
    
    NSDate *date = [_birthdayPicker date];
    _birthdayLabel.text = [self birthdayDate:date];;
//
//    NSString *postDate = [NSDate formatDateSince1970:date];
    _postString = _birthdayLabel.text;
}

- (void)editBirthdayAction
{
    
    [UserInfoModel eidtBirthday:_postString block:^(int code) {
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

@end
