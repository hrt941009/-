//
//  DresserIconDownloader.m
//  Love
//
//  Created by 李伟 on 14/11/15.
//  Copyright (c) 2014年 李伟. All rights reserved.
//

#import "DresserIconDownloader.h"
#import "DresserHomePageModel.h"
#import "UIImage+Additions.h"
#import "UIImageView+WebCache.h"

@implementation DresserIconDownloader


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)startDownload
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_dresserModel.thumbPath]
                 placeholderImage:[UIImage imageNamed:kDefalutCommodityImageDownload]];
    CGFloat imgWidth = imageView.image.size.width;
    CGFloat imgHeight = imageView.image.size.height;
    NSLog(@"--- w %f  h %f", imgWidth,imgHeight);
    UIImage *thumbImage = nil;
    //150.f cell宽度
    if (imgWidth > 150.f) {
        CGFloat thumbImgHeight = (imgWidth/imgHeight) * 150.f;
        CGSize size = CGSizeMake(150.f, thumbImgHeight);
        thumbImage = [UIImage lovThumbImage:imageView.image size:size];
    }else{
        thumbImage = imageView.image;
    }
    _dresserModel.thumbImage = thumbImage;
    
    if (self.completionHandler) {
        self.completionHandler();
    }
}

@end
