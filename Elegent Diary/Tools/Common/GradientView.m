//
//  GradientView.m
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/23.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView


- (void)layoutSubviews {
    [super layoutSubviews];
    UIView *bgcView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:bgcView];
    CAGradientLayer *gradiantLayer = [CAGradientLayer layer];
    gradiantLayer.frame = bgcView.bounds;
    [bgcView.layer addSublayer:gradiantLayer];
    gradiantLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor, (__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor, (__bridge id)[[UIColor whiteColor] colorWithAlphaComponent:0.0].CGColor];
    gradiantLayer.locations = @[@0.55, @0.75, @0.9];
    gradiantLayer.startPoint = CGPointMake(0, 1);
    gradiantLayer.endPoint = CGPointMake(0,0);
    [self sendSubviewToBack:bgcView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
