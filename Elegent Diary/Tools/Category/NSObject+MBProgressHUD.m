//
//  NSObject+MBProgressHUD.m
//  CollegeGirl
//
//  Created by lwhldy on 2017/2/6.
//  Copyright © 2017年 林文华. All rights reserved.
//

#import "NSObject+MBProgressHUD.h"
#import <MBProgressHUD.h>


@implementation NSObject (MBProgressHUD)
#pragma mark --消息提示框

- (void)showAlertMessage:(NSString *)message toView:(UIView *)view position:(MBProgressHUBPosition)position{
    [MBProgressHUD hideHUDForView:view animated:YES];
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.contentColor = kNaviBarColor;
    hud.label.text = message;
    [hud.label setFont:[UIFont boldSystemFontOfSize:14]];
    hud.animationType = MBProgressHUDAnimationZoomIn;
    hud.margin = 10.f;
    CGFloat margin = 92 ;  //距离底部和顶部的距离
    CGFloat offSetY = view.bounds.size.height / 2 - margin;
    if (position == MBProgressHUBPositionTop) {
        [hud setOffset:CGPointMake(0.f, -offSetY)];
    }
    if (position == MBProgressHUBPositionCenter) {
        [hud setOffset:CGPointMake(0.f, 0.f)];
    }
    if (position == MBProgressHUBPositionBottom) {
        [hud setOffset:CGPointMake(0.f, offSetY)];
    }
    [hud hideAnimated:YES afterDelay:2.0];
}

- (void)showSimpleMessage:(NSString *)message {
    [MBProgressHUD hideHUDForView:kKeyWindow animated:YES];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.contentColor = kNaviBarColor;
    hud.label.text = message;
    [hud.label setFont:[UIFont boldSystemFontOfSize:14]];
    hud.animationType = MBProgressHUDAnimationZoomIn;
    hud.margin = 10.f;

    [hud setOffset:CGPointMake(0.f, 0.f)];
    
    [hud hideAnimated:YES afterDelay:2.0];
}




@end
