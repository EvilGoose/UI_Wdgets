//
//  UIImage+Resize.h
//  Widgets
//
//  Created by EG on 2017/8/26.
//  Copyright © 2017年 EGMade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

/**
 按比例缩放图片到某区域
 
 @param sourceImage 原图
 @param size 指定尺寸
 @return 缩放结果
 */
+ (UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size;

/**
 按固定宽度缩放图片
 
 @param sourceImage 原图
 @param defineWidth 固定宽度
 @return 缩放结果
 */
+ (UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
