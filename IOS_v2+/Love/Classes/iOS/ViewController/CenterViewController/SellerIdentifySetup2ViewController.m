//
//  SellerIdentifySetup2ViewController.m
//  Love
//
//  Created by lee wei on 14-10-3.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "SellerIdentifySetup2ViewController.h"
#import "SellerIdentifySetup3ViewController.h"

typedef NS_ENUM(NSInteger, SellerIdentifySetup2ActionSheetTag)
{
    SellerIdentifySetup2ActionSheetTagWithFront = 0,
    SellerIdentifySetup2ActionSheetTagWithBack
};

@interface SellerIdentifySetup2ViewController ()<UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) IBOutlet UIView *bgView;
@property (nonatomic, strong) IBOutlet UITextField *idCardTextField;
@property (nonatomic, strong) IBOutlet UIImageView *frontImageView, *backImageView;



@end

@implementation SellerIdentifySetup2ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"上传身份证");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    nextButton.frame = CGRectMake(0, 0, 80, 36.f);
//    nextButton.backgroundColor = [UIColor clearColor];
//    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
//    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    nextButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
//    [nextButton addTarget:self action:@selector(identify2NextAction: withEvent:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *nextBarButton = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
//    self.navigationItem.rightBarButtonItem = nextBarButton;
    
    //-
    _bgView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _bgView.layer.borderWidth = 1.f;
    
    _idCardTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _idCardTextField.layer.borderWidth = 1.f;
    _idCardTextField.delegate = self;

    [self.view bringSubviewToFront:_nextButton];
    _nextButton.layer.masksToBounds = YES;
    _nextButton.layer.cornerRadius = 3.f;
    
    //---
    UITapGestureRecognizer *frontTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(frontTapAction)];
    [_frontImageView addGestureRecognizer:frontTap];
    
    UITapGestureRecognizer *backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backTapAction)];
    [_backImageView addGestureRecognizer:backTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - text field delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}



#pragma mark - button
- (void)identify2NextAction:(id)sender withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.tapCount == 1) {
        SellerIdentifySetup3ViewController *identifyViewController = [[SellerIdentifySetup3ViewController alloc] initWithNibName:@"SellerIdentifySetup3ViewController" bundle:nil];
        [self.navigationController pushViewController:identifyViewController animated:YES];
    }
    
}
- (void)photoButtonAction
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}

- (void)cameraButtonAction
{
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

#pragma mark - tap
- (void)frontTapAction
{
   UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择"
                                              delegate:self
                                     cancelButtonTitle:MyLocalizedString(@"Cancel")
                                destructiveButtonTitle:nil
                                     otherButtonTitles:@"相册", @"相机", nil];
    actionSheet.tag = SellerIdentifySetup2ActionSheetTagWithFront;
    [actionSheet showInView:self.view];
}

- (void)backTapAction
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择"
                                                             delegate:self
                                                    cancelButtonTitle:MyLocalizedString(@"Cancel")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"相册", @"相机", nil];
    actionSheet.tag = SellerIdentifySetup2ActionSheetTagWithBack;
    [actionSheet showInView:self.view];
}

#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == SellerIdentifySetup2ActionSheetTagWithFront) {
        if (buttonIndex == 0) {
            NSLog(@"相册");
            [self photoButtonAction];
        }
        if (buttonIndex == 1) {
            NSLog(@"拍照");
            [self cameraButtonAction];
        }
        if (buttonIndex == 2) {
            NSLog(@"取消");
        }
    }
    if (actionSheet.tag == SellerIdentifySetup2ActionSheetTagWithBack) {
        if (buttonIndex == 0) {
            NSLog(@"相册");
            [self photoButtonAction];
        }
        if (buttonIndex == 1) {
            NSLog(@"拍照");
            [self cameraButtonAction];
        }
        if (buttonIndex == 2) {
            NSLog(@"取消");
        }
    }
}

#pragma mark - imagepickercontroller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
//    [_headerImageView setImage:[GenerationImage scaleImage:image size:CGSizeMake(180.f, 240.f)]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextAction:(id)sender {
    SellerIdentifySetup3ViewController *identifyViewController = [[SellerIdentifySetup3ViewController alloc] initWithNibName:@"SellerIdentifySetup3ViewController" bundle:nil];
    [self.navigationController pushViewController:identifyViewController animated:YES];
    
    
}
@end
