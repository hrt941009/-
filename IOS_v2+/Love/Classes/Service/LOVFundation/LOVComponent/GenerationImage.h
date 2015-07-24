//
//  GenerationImage.h
//  Editor Universal HD
//
//  Created by Li Wei on 12-7-22.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface GenerationImage : NSObject

+ (UIImage *)scaleImage:(UIImage *)image  size:(CGSize)size;

+ (UIImage *)addImage1:(UIImage *)img1 image2:(UIImage *)img2;

+ (void)textViewContent:(NSString *)text
        backgroundImage:(UIImage *)bgImage
              textColor:(UIColor *)tColor
               fontName:(NSString *)fontName
          isPhotosAlbum:(BOOL)isPhotosAlbum;

+ (UIImage *)cutImage:(UIImage *)image;


@end
