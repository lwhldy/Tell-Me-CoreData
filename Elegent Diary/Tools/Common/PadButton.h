//
//  PadButton.h
//  DailyCost
//
//  Created by lwhldy on 2017/8/1.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DCButtonType) {
    DCButtonTypeNumber,
    DCButtonTypeAdd,
    DCButtonTypeMinus,
    DCButtonTypeDot,
    DCButtonTypePayment,
    DCButtonTypeEqual,
    DCButtonTypeComplete,
    DCButtonTypeCancel,
    DCButtonTypeDelete,
    DCButtonTypeReport,
    DCButtonTypeSetting,
};

@interface PadButton : UIButton

@property (nonatomic, assign) DCButtonType type;

- (void)hideBgcView;

@end
