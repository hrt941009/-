//
//  ReturnPurchaseViewController.m
//  Love
//
//  Created by use on 14-11-24.
//  Copyright (c) 2014年 HaiTao. All rights reserved.
//

#import "ReturnPurchaseViewController.h"
#import "UploadReturnImageModel.h"
#import "UserManager.h"
#import "ReturnPurchaseModel.h"
#import "ReturnMoneyModel.h"
@interface ReturnPurchaseViewController ()<UIActionSheetDelegate,UITextViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UILabel *showLabel;
    UIView *_pickerView;
    NSInteger _row;
    UIView *bgView;
    UIView *bgColorView;
    UIButton *helpButton;
}
@property (nonatomic ,strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) NSString *returnReason;
@property (nonatomic ,strong) NSMutableArray *returnResonArray;
@property (nonatomic ,strong) UILabel *resonLabel;
@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end
static NSInteger m = 0;
@implementation ReturnPurchaseViewController

-(void)hidden:(UIView*)view and:(BOOL)appear{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.duration = 0.4;
    [view.layer addAnimation:animation forKey:nil];
    
    view.hidden = appear;
}

-(void)addPicker:(UIImagePickerController *)picker{
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageArray = [[NSMutableArray alloc] init];
    bgColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgColorView.backgroundColor = [UIColor colorRGBWithRed:100 green:100 blue:100 alpha:1];
    bgColorView.alpha = 0.8;
    
    
    
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"是否收到货",@"退款金额",@"退款说明", nil];
    _returnResonArray = [[NSMutableArray alloc] initWithObjects:@"未收到货",@"已收到货", nil];
    _returnReason = @"请选择是否收到货";
    
//    [self createTextField];
    
    [self createView];
    
    [self createBottomView];
    
//    self.photoView = [[MessagePhotoView alloc] initWithFrame:CGRectMake(0, 200, 320, 130)];
//    self.photoView.backgroundColor = [UIColor colorRGBWithRed:235 green:235 blue:235 alpha:1.f];
//    [self.view addSubview:self.photoView];
//    self.photoView.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(hiddenKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    [self createPickerView];
    
    [self createImageView];
    
}

- (void)createPickerView{
    _pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-310, kScreenWidth, 310)];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.layer.masksToBounds = YES;
    _pickerView.layer.cornerRadius = 4.f;
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 50, 20)];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(cancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [_pickerView addSubview:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 10, 50, 20)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [_pickerView addSubview:rightButton];
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.frame = CGRectMake(0, 30, kScreenWidth, 280);
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.backgroundColor = [UIColor whiteColor];
    [_pickerView addSubview:pickerView];
    
    [self.view addSubview:_pickerView];
//    _pickerView.hidden = YES;
    [self hidden:_pickerView and:YES];
}

- (void)cancleButtonClick:(id)sender{
    [bgColorView removeFromSuperview];
    if (_pickerView != nil) {
//        _pickerView.hidden = YES;
        [self hidden:_pickerView and:YES];
    }
}

- (void)finishButtonClick:(id)sender{
    if (_row == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请选择退货原因或点击取消" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        [bgColorView removeFromSuperview];
        _resonLabel.text = _returnResonArray[_row - 1];
//        _pickerView.hidden = YES;
        [self hidden:_pickerView and:YES];
    }
}

- (void)hiddenKeyboard:(UITapGestureRecognizer*)tap{
    [_textView resignFirstResponder];
}

- (void)createBottomView{
    UIView *lView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-64-50, kScreenWidth, 50)];
    lView.backgroundColor = [UIColor clearColor];
    lView.layer.borderColor = [[UIColor grayColor] CGColor];
    lView.layer.borderWidth = 1.f;
    [self.view addSubview:lView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 80)/2, 10, 80, 30)];
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:@"提交申请" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.f];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5.f;
    button.layer.borderColor = [[UIColor colorRGBWithRed:230 green:63 blue:105 alpha:1.f] CGColor];
    button.layer.borderWidth = 1.f;
    [button addTarget:self action:@selector(submitApplyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [lView addSubview:button];
    
}
//“提交申请”按钮触发事件
- (void)submitApplyButtonClicked:(UIButton*)button{
    NSLog(@"点击了退货提交申请");
    NSString *inrto = [NSString stringWithFormat:@"%@",_textView.text];
    //    判断订单是否已到货，到货type=1，未到货type=0
    NSString *orderType;
    if (_row == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请选择是否收到货" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        if (_row == 1) {
            orderType = @"0";
        }
        if (_row == 2) {
            orderType = @"1";
        }
        //    拼凑img的url
        NSString *imgUrl;
        if ([_imageArray count]==1) {
            imgUrl = [NSString stringWithFormat:@"%@",_imageArray[0]];
        }
        if ([_imageArray count]==2) {
            imgUrl = [NSString stringWithFormat:@"%@_%@",_imageArray[0],_imageArray[1]];
        }
        if ([_imageArray count]==3) {
            imgUrl = [NSString stringWithFormat:@"%@_%@_%@",_imageArray[0],_imageArray[1],_imageArray[2]];
        }
        [ReturnMoneyModel getReturnMoneyDataCode:_orderNumber
                                           intro:inrto
                                            type:orderType
                                           image:imgUrl
                                           money:_orderMoney
                                           block:^(int code, NSString *msg) {
                                               if (code == 1) {
                                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"退款申请成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:MyLocalizedString(@"OK"), nil];
                                                   [alertView show];
                                                   //                                                   [self.navigationController popToRootViewControllerAnimated:YES];
                                               }
                                               if (code == 2){
                                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"已经提交过退款申请，请耐心等待处理。。。" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                                                   [alertView show];
                                                   
                                               }
                                               if (code == 0){
                                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"提交失败，请重试！" delegate:nil cancelButtonTitle:MyLocalizedString(@"OK") otherButtonTitles:nil, nil];
                                                   [alertView show];
                                               }
                                           }];
    }

}

- (void)createView{
    for (int i = 0 ; i < 3; i++) {
        bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 15 + 55*i, kScreenWidth - 20, 40)];
        bgView.backgroundColor = [UIColor colorRGBWithRed:208 green:208 blue:208 alpha:1.f];
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = 4.f;
        bgView.tag = 200 + i;
        [self.view addSubview:bgView];
        
        UILabel *fLabel = [self createLabel:CGRectMake(15, 10, 100, 20) andText:_dataArray[i]];
        [bgView addSubview:fLabel];
        
        if (i == 0) {
            _resonLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, kScreenWidth - 150, 20)];
            _resonLabel.text = _returnReason;
            _resonLabel.textColor = [UIColor blackColor];
            _resonLabel.font = [UIFont systemFontOfSize:15.f];
            [bgView addSubview:_resonLabel];
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 5, 30, 30)];
            button.backgroundColor = [UIColor clearColor];
            [button setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(choiceReturnPurchaseReason:) forControlEvents:UIControlEventTouchUpInside];
            [bgView addSubview:button];
        }
        if (i == 1) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 160, 20)];
            label.text = [NSString stringWithFormat:@"￥%@",_orderMoney];
            label.textColor = [UIColor colorRGBWithRed:227 green:62 blue:104 alpha:1.f];
            label.font = [UIFont systemFontOfSize:15.f];
            [bgView addSubview:label];
        }
        if (i == 2) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 160, 20)];
            label.text = @"最多输入200字";
            label.textColor = [UIColor lightGrayColor];
            label.font = [UIFont systemFontOfSize:15.f];
            [bgView addSubview:label];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
            [tap addTarget:self action:@selector(returnPurchaseExplain:)];
            [bgView addGestureRecognizer:tap];
        }
    }
    
}

- (void)createTextView{
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 155, kScreenWidth - 20, 60)];
    _textView.backgroundColor = [UIColor colorRGBWithRed:208 green:208 blue:208 alpha:1.f];
    _textView.delegate = self;
    [self.view addSubview:_textView];
    [self.view sendSubviewToBack:_textView];
    
//    键盘上方按钮，用来处理键盘回落
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    
    [topView setItems:buttonsArray];
    [_textView setInputAccessoryView:topView];
}

- (void)choiceReturnPurchaseReason:(UIButton*)button{
    [self.view addSubview:bgColorView];
    [self.view bringSubviewToFront:_pickerView];
//    _pickerView.hidden = NO;
    [self hidden:_pickerView and:NO];
    
}

//创建选择图片按钮
- (void)createImageView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, (kScreenWidth - 80)/3 + 20)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [self.view bringSubviewToFront:view];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20 + i * ((kScreenWidth - 80)/3 + 20), 10, (kScreenWidth - 80)/3, (kScreenWidth - 80)/3);
        button.backgroundColor = [UIColor clearColor];
        [button setImage:[UIImage imageNamed:@"bg_upload.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(imageViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];

    }
    
    
}

- (void)imageViewClicked:(UIButton*)bnt{
    helpButton = bnt;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:MyLocalizedString(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    actionSheet.tag = 500;
    [actionSheet showInView:self.view];
}

#pragma  mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_returnResonArray count] + 1;
}



#pragma mark -- UIPickerViewDelegate
//选中某项触发的方法

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _row = row;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    showLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,20.0f)];
    if (row == 0) {
        showLabel.text = @"请选择退货原因";
        showLabel.textColor = [UIColor redColor];
    }else{
        showLabel.text = [NSString stringWithFormat:@"%@",_returnResonArray[row-1]];
        showLabel.textColor = [UIColor blackColor];
    }
    showLabel.backgroundColor = [UIColor clearColor];
    showLabel.textAlignment = NSTextAlignmentCenter;
    
    return showLabel;
}

- (void)returnPurchaseExplain:(UITapGestureRecognizer*)tap{
    m = m ^ 1;
    if (m == 1) {
        [self createTextView];
        [_textView becomeFirstResponder];
        
    }else{
        [_textView removeFromSuperview];
    }
    
}

#pragma mark -- UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (range.location >= 200) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark -- UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 500) {
        if (buttonIndex == 0) {
            NSLog(@"相机");
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing = YES;
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
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
        }
    }else{
        if (buttonIndex < [_returnResonArray count]) {
            _resonLabel.text = _returnResonArray[buttonIndex];
        }
    }
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *) editingInfo{
//    NSString *uid = [UserManager readUid];
//    NSDictionary *dic = @{@"uid":uid};
    UIImage *changeImage = [self imageWithImage:image scaledToSize:CGSizeMake(60, 60)];
    [UploadReturnImageModel uploadReturnImage:changeImage imageName:nil parmas:nil block:^(int code, NSString *msg) {
//        msg为返回的图片url
        [_imageArray addObject:msg];
    }];
    
    [helpButton setImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    [picker dismissViewControllerAnimated:YES completion:^{}];
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    [helpButton setImage:image forState:UIControlStateNormal];
//}

#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

//创建label方法
- (UILabel*)createLabel:(CGRect)rect andText:(NSString*)text{
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
    label.font = [UIFont systemFontOfSize:13.f];
    label.textColor = [UIColor grayColor];
    return label;
}

//压缩图片方法
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


/////////////////////////////////////////////////////////////////////

-(void)dismissKeyBoard
{
    [_textView resignFirstResponder];
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
