//
//  UIActionSheet+Common.h
//  CollegeGirl
//
//  Created by lwhldy on 2017/3/2.
//  Copyright © 2017年 林文华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (Common)
+ (instancetype)bk_actionSheetCustomWithTitle:(NSString *)title buttonTitles:(NSArray *)buttonTitles destructiveTitle:(NSString *)destructiveTitle cancelTitle:(NSString *)cancelTitle andDidDismissBlock:(void (^)(UIActionSheet *sheet, NSInteger index))block;
@end
