//
//  CGHUD.m
//  CollegeGirl
//
//  Created by lwhldy on 2017/5/5.
//  Copyright © 2017年 林文华. All rights reserved.
//

#import "CGHUD.h"

@implementation CGHUD

-(instancetype)initWithView:(UIView *)view{
    self.userInteractionEnabled = NO;
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = kNaviBarColor;
    self.removeFromSuperViewOnHide = YES;
    self.label.textColor = kNaviBarColor;
    self.detailsLabel.textColor = kNaviBarColor;
    [self.button setTitleColor:kNaviBarColor forState:UIControlStateNormal];
    return [super initWithView:view];
}

@end
