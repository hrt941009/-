//
//  HeaderViewController.m
//  Love
//
//  Created by lee wei on 14-10-3.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "HeaderViewController.h"
#import "GenerationImage.h"

@interface HeaderViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *headerImageView;
@property (nonatomic, strong) IBOutlet UIButton *photoButton, *cameraButton;
@property (nonatomic, strong) IBOutlet UIButton *loadingButton;

- (IBAction)photoButtonAction:(id)sender;
- (IBAction)cameraButtonAction:(id)sender;
- (IBAction)loadingButtonAction:(id)sender;

@end

@implementation HeaderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MyLocalizedString(@"设置头像");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button action
- (IBAction)photoButtonAction:(id)sender
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

- (IBAction)cameraButtonAction:(id)sender
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

- (IBAction)loadingButtonAction:(id)sender
{
    
}

#pragma mark - imagepickercontroller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [_headerImageView setImage:[GenerationImage scaleImage:image size:CGSizeMake(180.f, 240.f)]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
