//
//  UIView+Frame.h
//  CollegeGirl
//
//  Created by 林文华 on 2016/12/17.
//  Copyright © 2016年 林文华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat bottom;

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat centerX;
/*切圆角*/
- (void)cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;
/*切单个或多个圆角*/
- (void)setCustomCornersWithCorners:(UIRectCorner)corners Radii:(CGSize)size;

- (void)removeAllSubviews;
@end
