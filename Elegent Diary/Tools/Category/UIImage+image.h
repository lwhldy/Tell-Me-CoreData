//
//  UIImage+image.h
//  CollegeGirl
//
//  Created by 林文华 on 2016/12/17.
//  Copyright © 2016年 林文华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)
// 加载原始图片
+ (instancetype)imageWithOriginalName:(NSString *)imageName;
// 图片拉伸
+ (instancetype)imageWithStretchableName:(NSString *)imageName;
// 颜色转图片
+ (UIImage *)createImageWithColor:(UIColor*) color withBounds:(CGRect)bounds;
// 绘制图片
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;
//装换正确的方向方法一
- (UIImage *)normalizedImage;
//装换正确的方向方法二
- (UIImage *)fixOrientation;
//限制图片大小
+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;
//颜色转图片
+(UIImage *)imageWithColor:(UIColor *)aColor;
/** from coding */
- (NSData *)dataSmallerThan:(NSUInteger)dataLength;
- (NSData *)dataForCGUpload;
@end
