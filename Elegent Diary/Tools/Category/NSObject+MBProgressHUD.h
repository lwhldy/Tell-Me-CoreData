//
//  NSObject+MBProgressHUD.h
//  CollegeGirl
//
//  Created by lwhldy on 2017/2/6.
//  Copyright © 2017年 林文华. All rights reserved.
//

#import <Foundation/Foundation.h>
#pragma mark --枚举，消息提示框的位置
typedef NS_ENUM(NSInteger,MBProgressHUBPosition) {
    MBProgressHUBPositionTop,            //头部
    MBProgressHUBPositionCenter,         //中心
    MBProgressHUBPositionBottom          //底部
};
@interface NSObject (MBProgressHUD)
- (void)showAlertMessage:(NSString *)message toView:(UIView *)view position:(MBProgressHUBPosition)position;
- (void)showSimpleMessage:(NSString *)message;
@end
