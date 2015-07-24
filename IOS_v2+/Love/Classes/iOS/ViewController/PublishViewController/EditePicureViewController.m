//
//  EditePicureViewController.m
//  Love
//
//  Created by use on 15-3-27.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//

#import "EditePicureViewController.h"
#import "LOVNavigationController.h"
#import "PublishProductViewController.h"
#import "UploadReturnImageModel.h"

#import "ColorMatrix.h"
#import "ImageUtil.h"
#import "GenerationImage.h"
#import "SVProgressHUD.h"

@interface EditePicureViewController ()<UIScrollViewDelegate,DismissViewControllerDelegate>
{
    UIView *headerView;
    UIView *bottomBgView;
    UIImage *currentImage;
    UIImageView *imageView;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImage *choiceImage;
@end

@implementation EditePicureViewController

#pragma mark -- DismissViewControllerDelegate
- (void)dismissTheViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
    if ([_dismis respondsToSelector:@selector(dismissTheViewController)]) {
        [_dismis dismissTheViewController];
    }
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title = @"照片编辑";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorRGBWithRed:39 green:39 blue:39 alpha:1];
    
    _choiceImage = _myImage;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backView];
    
    CGSize backgroundSize = CGSizeMake(kScreenWidth, kScreenHeight - 114 - 50);
    CGSize imageSize = CGSizeMake(_myImage.size.width, _myImage.size.height);
    CGFloat imageViewWidth = 0;
    CGFloat imageViewHeight = 0;
    if (imageSize.width/backgroundSize.width >= 1) {
        imageViewWidth = backgroundSize.width;
        imageViewHeight = (backgroundSize.width/imageSize.width) * imageSize.height;
        if (imageViewHeight/backgroundSize.height >=1) {
            imageViewHeight = backgroundSize.height;
            imageViewWidth = (backgroundSize.height/imageSize.height) * imageSize.width;
        }
    }else {
        if (imageViewHeight/backgroundSize.height >=1) {
            imageViewHeight = backgroundSize.height;
            imageViewWidth = (backgroundSize.height/imageSize.height) * imageSize.width;
        }else{
            imageViewWidth = imageSize.width;
            imageViewHeight = imageSize.height;
        }
    }
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake((backgroundSize.width - imageViewWidth)/2, (backgroundSize.height - imageViewHeight)/2, imageViewWidth, imageViewHeight)];
    imageView.backgroundColor = [UIColor lightGrayColor];
    imageView.image = _myImage;
    [backView addSubview:imageView];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 20, 40, 40)];
    [rightButton setImage:[UIImage imageNamed:@"icon_tick"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
//    [self setHeaderView];
    [self setFooterView];
    
}

- (void)setHeaderView{
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    headerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:headerView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 200)/2, 20, 200, 44)];
    titleLabel.text = @"照片编辑";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18.f];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 20, 40)];
    [leftButton setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 20, 40, 40)];
    [rightButton setImage:[UIImage imageNamed:@"icon_tick"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:rightButton];
}

- (void)setFooterView{
    NSArray *arr = [NSArray arrayWithObjects:@"原图",@"LOMO",@"黑白",@"复古",@"哥特",@"锐色",@"淡雅",@"酒红",@"青柠",@"浪漫",@"光晕",@"蓝调",@"梦幻",@"夜色", nil];
    bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 100 - 50 - 64, kScreenWidth, 100)];
    bottomBgView.backgroundColor = [UIColor clearColor];
    bottomBgView.alpha = 1;
    [self.view addSubview:bottomBgView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 110)];
    _scrollView.backgroundColor = [UIColor colorRGBWithRed:0 green:0 blue:0 alpha:0.2];
    _scrollView.pagingEnabled = NO;
    _scrollView.scrollEnabled = YES;
    _scrollView.scrollsToTop = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [bottomBgView addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(30 + [arr count] * 68, 110);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 110 * [arr count], 30)];
    for (int i = 0; i < [arr count]; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15 + i * 68, 10, 60, 60)];
        button.backgroundColor = [UIColor clearColor];
        //        button.tag = 100 + i;
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"filter_%d.jpg",i]] forState:UIControlStateNormal];
        [button setTag:i + 100];
        if (i == 0) {
            button.layer.borderColor = [[UIColor redColor] CGColor];
            button.layer.borderWidth = 3.f;
        }
        [button addTarget:self action:@selector(choicelvjingAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        
        UILabel *namelabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + i * 68, 55, 60, 60)];
        namelabel.text = arr[i];
        namelabel.textColor = [UIColor whiteColor];
        namelabel.textAlignment = NSTextAlignmentCenter;
        [_scrollView addSubview:namelabel];
    }
    [_scrollView addSubview:label];
    _scrollView.bouncesZoom = NO;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 50 - 64, kScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth - 22)/2, 5, 22, 37)];
//    [button setTitle:@"滤镜" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"icon_filter"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"icon_filter_select"] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(lvjingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
}

- (void)lvjingButtonAction:(UIButton *)sender{
    if (bottomBgView.alpha == 0) {
        bottomBgView.alpha = 1;
    }else{
        bottomBgView.alpha = 0;
    }
}

- (void)choicelvjingAction:(UIButton *)mySender{
    for (int i = 0; i < 14; i++) {
        UIButton *myButton = (UIButton *)[self.view viewWithTag:i + 100];
        myButton.layer.borderWidth = 0;
    }
//    UIButton *button = (UIButton *)[sender viewWithTag:0];
    mySender.layer.borderColor = [[UIColor redColor] CGColor];
    mySender.layer.borderWidth = 3.f;
    
    UIImage *rootImage = [self changeImage:(int)[mySender tag] - 100 imageView:nil];
    [imageView setImage:rootImage];
    
}

-(UIImage *)changeImage:(int)index imageView:(UIImageView *)imageView
{
    switch (index) {
        case 0:
        {
            _choiceImage = _myImage;
        }
            break;
        case 1:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_lomo];
        }
            break;
        case 2:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_heibai];
        }
            break;
        case 3:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_huajiu];
        }
            break;
        case 4:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_gete];
        }
            break;
        case 5:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_ruise];
        }
            break;
        case 6:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_danya];
        }
            break;
        case 7:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_jiuhong];
        }
            break;
        case 8:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_qingning];
        }
            break;
        case 9:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_langman];
        }
            break;
        case 10:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_guangyun];
        }
            break;
        case 11:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_landiao];
            
        }
            break;
        case 12:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_menghuan];
            
        }
            break;
        case 13:
        {
            _choiceImage = [ImageUtil imageWithImage:_myImage withColorMatrix:colormatrix_yese];
            
        }
    }
    return _choiceImage;
}

- (void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sureAction:(UIButton *)sender{
//    [SVProgressHUD show];
//    NSData *imageData = UIImageJPEGRepresentation(_choiceImage, 0.1);
//    UIImage *newImage = [UIImage imageWithData:imageData];
//    [GenerationImage scaleImage:_choiceImage size:CGSizeMake(360.f, 360.f)]
//    [UploadReturnImageModel uploadReturnImage:[GenerationImage cutImage:_choiceImage] imageName:nil parmas:nil block:^(int code, NSString *msg) {
//        [SVProgressHUD dismiss];
//        PublishMainViewController *publishMainVC = [[PublishMainViewController alloc] init];
//        publishMainVC.choiceImage = [GenerationImage cutImage:_choiceImage];
//        publishMainVC.imgUrl = msg;
//        publishMainVC.delegate = self;
//        publishMainVC.isShare = _isShare;
//        if (_isAddImage) {
//            if ([_delegate respondsToSelector:@selector(getImageDataWith:andUrl:)]) {
//                [_delegate getImageDataWith:_choiceImage andUrl:msg];
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            }
//        }else{
//            LOVNavigationController *publishNav = [[LOVNavigationController alloc] initWithRootViewController:publishMainVC];
//            [self presentViewController:publishNav animated:YES completion:nil];
//        }
//    }];
    PublishMainViewController *publishMainVC = [[PublishMainViewController alloc] init];
    publishMainVC.choiceImage = _choiceImage;
    publishMainVC.delegate = self;
    publishMainVC.isShare = _isShare;
    if (_isAddImage) {
        if ([_delegate respondsToSelector:@selector(getImageDataWith:andUrl:)]) {
            [_delegate getImageDataWith:_choiceImage andUrl:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }else{
        LOVNavigationController *publishNav = [[LOVNavigationController alloc] initWithRootViewController:publishMainVC];
        [self presentViewController:publishNav animated:YES completion:nil];
    }

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
