//
//  WHInteractiveTransition.m
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/22.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "WHInteractiveTransition.h"

@interface WHInteractiveTransition ()<UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, strong) UIViewController *precentVC;

@end


@implementation WHInteractiveTransition

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint transition = [pan translationInView:self.precentVC.view];
        if (transition.x < 0) {
            return NO;
        }
        
    }
    return YES;
}

- (void)wireToViewController:(UIViewController *)viewController {
    self.precentVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView*)view {
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    gesture.delegate = self;
    [view addGestureRecognizer:gesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)gesture {
    CGPoint transition = [gesture translationInView:gesture.view.superview];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.interacting = YES;
            [self.precentVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:{
            CGFloat fratction = transition.y / 400;
            fratction = fmin(fmax(fratction, 0.0), 1.0);
            self.shouldComplete = (fratction > 0.3);
            [self updateInteractiveTransition:fratction];
        }
            
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:{
            self.interacting = NO;
            if (!self.shouldComplete || gesture.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            }else {
                [self finishInteractiveTransition];
            }
        }
            break;
        default:
            break;
    }
}


- (CGFloat)completionSpeed {
    return  1 - self.percentComplete;
}


@end
