//
//  PanTableView.m
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/24.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "PanTableView.h"

@implementation PanTableView

// 判断scrollView是不是在最顶部往下滑或者在最底部往上滑，如果是这两种情况才需要把事件往下传递
- (BOOL)isScrollViewOnTop {
    CGPoint translation = [self.panGestureRecognizer translationInView:self];
    if (translation.y > 0 && self.contentOffset.y <= 0) {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isEqual:self.panGestureRecognizer]) {
        if (gestureRecognizer.state == UIGestureRecognizerStatePossible) {
            if ([self isScrollViewOnTop]) {
                return NO;
            }
        }
    }
    
    return YES;
}


- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
