//
//  ComplainViewController.m
//  Love
//
//  Created by use on 14-11-19.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "ComplainViewController.h"
#import "ComplainModel.h"
#import "UIImageView+WebCache.h"
#define RowHeightFirst  (40.f);
#define RowHeightLast  (130.f);
#define RowHeightElse  (30.f);

static NSInteger imageViewTag;

@interface ComplainViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL isFullScreen;
}

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSString *dataTime;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSString *number;
@property(nonatomic,strong)NSString *request;
@property(nonatomic,strong)NSString *money;
@property (nonatomic, strong) NSArray *imgArray;

@end

@implementation ComplainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imgArray = [[NSArray alloc] init];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, (40+130+30*4)-1) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
    
    [ComplainModel getComplainDataCode:_orderNumber block:^(NSString *date, NSString *service_result, NSString *service_code, NSString *service_type, NSString *money, NSArray *img) {
        _dataTime = date;
        _result = service_result;
        _number = service_code;
        _request = service_type;
        _money = money;
        _imgArray = img;
        [self.tableView reloadData];
    }];
    
}

#pragma mark -- tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIdentifier = @"complainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    if (indexPath.row == 0) {
        if (_dataTime.length > 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@【%@】", MyLocalizedString(@"投诉维权状态"), _dataTime];
        }else{
            cell.textLabel.text = MyLocalizedString(@"投诉维权状态");
        }
        
    }else if(indexPath.row == 1){
        if (_result.length > 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@：%@", MyLocalizedString(@"维权结果"), _result];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
        }else{
            cell.textLabel.text = MyLocalizedString(@"维权结果");
            cell.textLabel.font = [UIFont systemFontOfSize:12];
        }
        
    }else if (indexPath.row == 2){
        if (_number.length  > 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@：%@", MyLocalizedString(@"维权编号"), _number];
            cell.textLabel.font = [UIFont systemFontOfSize:12];

        }else{
            cell.textLabel.text = MyLocalizedString(@"维权编号");
            cell.textLabel.font = [UIFont systemFontOfSize:12];
        }
    }else if (indexPath.row == 3){
        if (_request.length > 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@：%@", MyLocalizedString(@"维权要求"), _request];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
        }else{
            cell.textLabel.text = MyLocalizedString(@"维权要求");
            cell.textLabel.font = [UIFont systemFontOfSize:12];
        }
        
    }else if (indexPath.row == 4){
        if (_money.length > 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@：%@", MyLocalizedString(@"退款金额"), _money];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
        }else{
            cell.textLabel.text = MyLocalizedString(@"退款金额");
            cell.textLabel.font = [UIFont systemFontOfSize:12];
        }
        
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth-10, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = MyLocalizedString(@"维权凭证");
        label.font = [UIFont systemFontOfSize:12];
        [cell addSubview:label];
        
        for (int i = 0; i < [_imgArray count]; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5+((kScreenWidth-10)/3)*i, 30, (kScreenWidth-65)/3, (kScreenWidth-65)/3)];
//            imageView.image = [UIImage imageNamed:@"bg_upload.png"];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i + 200;
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imgArray[i]] placeholderImage:[UIImage imageNamed:@""]];
            [cell addSubview:imageView];

//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
//            [imageView addGestureRecognizer:tap];
            
//            UIButton *imageBnt = [[UIButton alloc] initWithFrame:CGRectMake(5+((kScreenWidth-10)/3)*i, 30, (kScreenWidth-65)/3, (kScreenWidth-65)/3)];
//            imageBnt.backgroundColor = [UIColor clearColor];
//            imageBnt.tag = i + 300;
//            [imageBnt addTarget:self action:@selector(imageViewClicked:) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:imageBnt];
        }
        
    }
    return cell;
}


#pragma mark -- tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return RowHeightFirst;
    }else if (indexPath.row == 5){
        return RowHeightLast;
    }else{
        return RowHeightElse;
    }
}

//图片点击事件
- (void) imageViewClicked:(UIButton*)sender{
    
    imageViewTag = sender.tag - 100;

    UIActionSheet *actionSheet;

    actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:MyLocalizedString(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:MyLocalizedString(@"拍照"), MyLocalizedString(@"相册"), nil];

    actionSheet.tag = 300;
    
    [actionSheet showInView:self.view];
}

#pragma mark -- actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 300) {
        NSUInteger sourceType = 0;
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            return;
        }else{
            switch (buttonIndex) {
                case 0:
//                   相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
//                   相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    
                default:
                    break;
            }
        }
    [self jumpIntoThePhotoGallery:sourceType];
    }

}
 //    跳转到相机或者是相册页面
- (void)jumpIntoThePhotoGallery:(NSInteger)sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark -- imagePickerDelegate;

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    保存图片至本地
    [self saveImage:image withName:@"currentImage.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *saveImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    isFullScreen = NO;
    UIImageView *imageView = (UIImageView*)[self.view viewWithTag:imageViewTag];
    [imageView setImage:saveImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 将图片保存在沙盒
- (void) saveImage:(UIImage*)currentImage withName:(NSString*)imageName{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
//    获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
//    将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
