//
//  PublishProductViewController.m
//  Love
//
//  Created by use on 15-3-27.
//  Copyright (c) 2015年 HaiTao. All rights reserved.
//
#import "PublishProductViewController.h"
#import "PublicProductCollectionViewCell.h"
#import "EditePicureViewController.h"


static NSString * const kCellProductIdentifier = @"kCellProductIdentifier";

@interface PublishProductViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,GetImageDataDelegate,DismissViewControllerDelegate>
{
    ALAssetsLibrary *library;
    NSArray *imageArray;
    NSMutableArray *mutableArray;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)PublicProductCollectionViewCell *productCollectionCell;
@property (nonatomic, strong)EditePicureViewController *editPicureVC;

@end

static long count = 0;
static BOOL isDismiss;

@implementation PublishProductViewController

- (void)getImageDataWith:(UIImage *)image andUrl:(NSString *)imageUrl{
    if ([_delegate respondsToSelector:@selector(imageDataWith:andUrl:)]) {
        [_delegate imageDataWith:image andUrl:imageUrl];
    }
}

- (void)dismissTheViewController{
    isDismiss = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (isDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    _editPicureVC = nil;
//    [mutableArray removeAllObjects];
//    [_dataArray removeAllObjects];
//    [self allPhotosCollected:mutableArray];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isDismiss = NO;
    self.title = @"相机胶卷";
    
//    self.view.backgroundColor = [UIColor colorRGBWithRed:235.f green:235.f blue:235.f alpha:1];
    self.view.backgroundColor = [UIColor whiteColor];

    if (VersionNumber_iOS_7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;//view在导航栏下方
    }
    imageArray = [[NSArray alloc] init];
    mutableArray = [[NSMutableArray alloc] init];
    library = [[ALAssetsLibrary alloc] init];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitle:@"取消" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    leftButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [leftButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = doneBarButton;
    
    [self getAllPicture];
    
    
    
    
}

- (void)cancleButtonAction:(UIButton *)sender{
    if (_isAddImage) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)getAllPicture{
    [mutableArray removeAllObjects];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result,NSUInteger index, BOOL *stop){
            if (result!=NULL) {
                
                if ([[result valueForProperty:ALAssetPropertyType]isEqualToString:ALAssetTypePhoto]) {
                    
                    NSString *urlstr=[NSString stringWithFormat:@"%@",result.defaultRepresentation.url];//图片的url
                    /*result.defaultRepresentation.fullScreenImage//图片的大图
                     result.thumbnail                            //图片的缩略图小图
                     //                    NSRange range1=[urlstr rangeOfString:@"id="];
                     //                    NSString *resultName=[urlstr substringFromIndex:range1.location+3];
                     //                    resultName=[resultName stringByReplacingOccurrencesOfString:@"&ext=" withString:@"."];//格式demo:123456.png
                     */
                    
                    [mutableArray addObject:urlstr];
                    if ([mutableArray count] == count) {
                        [self allPhotosCollected:mutableArray];
                    }
                }
            }
            
        };
        ALAssetsLibraryGroupsEnumerationResultsBlock
        libraryGroupsEnumeration = ^(ALAssetsGroup* group,BOOL* stop){
            
            if (group == nil)
            {
                
            }
            
            if (group!=nil) {
                NSString *g=[NSString stringWithFormat:@"%@",group];//获取相簿的组
                NSLog(@"gg:%@",g);
//                gg:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
//
                NSString *g1=[g substringFromIndex:16 ] ;
                NSArray *arr=[NSArray arrayWithArray:[g1 componentsSeparatedByString:@","]];
                NSString *g2=[[arr objectAtIndex:2]substringFromIndex:14];
                count = [g2 intValue];
                
                [group enumerateAssetsUsingBlock:groupEnumerAtion];
            }
            
        };
        
        ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
        [library enumerateGroupsWithTypes:ALAssetsGroupAll
                              usingBlock:libraryGroupsEnumeration 
                            failureBlock:nil];
    });
    
    
}

- (void)allPhotosCollected:(NSMutableArray *)imgArray{
    _dataArray = imgArray;
    _collectionView.hidden = YES;
    _collectionView = nil;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((kScreenWidth - 30)/3, (kScreenWidth - 30)/3)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth - 10, kScreenHeight - 69) collectionViewLayout:flowLayout];
    [_collectionView setAllowsSelection:YES];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    _collectionView.alpha = 1;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[PublicProductCollectionViewCell class] forCellWithReuseIdentifier:kCellProductIdentifier];
}

#pragma mark --UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [_dataArray count] + 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PublicProductCollectionViewCell *cell = (PublicProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellProductIdentifier forIndexPath:indexPath];
    cell.tagLabel.hidden = YES;
    if (indexPath.row == 0) {
        cell.bgImageView.image = [UIImage imageNamed:@"camare"];
    }else{
        ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
        NSURL *url = [NSURL URLWithString:_dataArray[indexPath.row - 1]];
        [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
            UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
            cell.bgImageView.image = image;
        } failureBlock:^(NSError *error) {
            
        }];
    }
    return cell;
}
#pragma mark --UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:^{}];
    }else{
        if (_editPicureVC == nil) {
            _editPicureVC = [[EditePicureViewController alloc] init];
            ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
            NSURL *url = [NSURL URLWithString:_dataArray[indexPath.row - 1]];
            [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
                UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                _editPicureVC.myImage = image;
                [self.navigationController pushViewController:_editPicureVC animated:YES];
            } failureBlock:^(NSError *error) {
                
            }];
            _editPicureVC.delegate = self;
            _editPicureVC.dismis = self;
            _editPicureVC.isShare = _isShare;
//            [self presentViewController:_editPicureVC animated:YES completion:nil];
            if (_isAddImage) {
                _editPicureVC.isAddImage = _isAddImage;
            }
        }
    }
}


#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_editPicureVC == nil) {
        _editPicureVC = [[EditePicureViewController alloc] init];
        _editPicureVC.delegate = self;
        _editPicureVC.dismis = self;
        _editPicureVC.isShare = _isShare;
        if (_isAddImage) {
            _editPicureVC.isAddImage = _isAddImage;
        }
        _editPicureVC.myImage = image;
        [self.navigationController pushViewController:_editPicureVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
