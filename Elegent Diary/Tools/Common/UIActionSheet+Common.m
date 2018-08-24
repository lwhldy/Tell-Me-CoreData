//
//  UIActionSheet+Common.m
//  CollegeGirl
//
//  Created by lwhldy on 2017/3/2.
//  Copyright © 2017年 林文华. All rights reserved.
//

#import "UIActionSheet+Common.h"

@implementation UIActionSheet (Common)

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (self.actionSheetStyle == UIAlertActionStyleCancel) {
            [self setValue:kNaviBarColor forKey:@"_titleTextColor"];
        }
    }
    return self;
}

+ (instancetype)bk_actionSheetCustomWithTitle:(NSString *)title buttonTitles:(NSArray *)buttonTitles destructiveTitle:(NSString *)destructiveTitle cancelTitle:(NSString *)cancelTitle andDidDismissBlock:(void (^)(UIActionSheet *sheet, NSInteger index))block{
    UIActionSheet *actionSheet = [UIActionSheet bk_actionSheetWithTitle:title];
    if (buttonTitles && buttonTitles.count > 0) {
        for (NSString *buttonTitle in buttonTitles) {
            [actionSheet bk_addButtonWithTitle:buttonTitle handler:nil];
        }
    }
    if (destructiveTitle) {
        [actionSheet bk_setDestructiveButtonWithTitle:destructiveTitle handler:nil];
    }
    if (cancelTitle) {
        [actionSheet bk_setCancelButtonWithTitle:cancelTitle handler:nil];
    }
    [actionSheet bk_setDidDismissBlock:block];
    return actionSheet;
}
@end
