//
//  TransitionAnimation.h
//  CocoapodsTest
//
//  Created by lwhldy on 2017/7/24.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OperationType) {
    OperationTypePresent,
    OperationTypeDismiss,
    OperationTypePush,
    OperationTypePop,
};
typedef NS_ENUM(NSUInteger, AnimationType) {
    AnimationTypeNone,
    AnimationTypeFade,
    AnimationTypeSpring,
    AnimationTypeRotation,
    AnimationTypeBook,
    AnimationTypeCard,
};


@interface TransitionAnimation : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithDuration:(NSTimeInterval)duration OperationType:(OperationType)operationType animationType:(AnimationType)animationType;

@end
