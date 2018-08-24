//
//  TransitionAnimation.m
//  CocoapodsTest
//
//  Created by lwhldy on 2017/7/24.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "TransitionAnimation.h"

@interface TransitionAnimation ()

@property (nonatomic, assign) AnimationType animationType;
@property (nonatomic, assign) OperationType operationType;
@property (nonatomic, assign) NSTimeInterval aDuration;
@end

@implementation TransitionAnimation

- (instancetype)initWithDuration:(CGFloat)duration OperationType:(OperationType)operationType animationType:(AnimationType)animationType {
    if (self = [super init]) {
        self.animationType = animationType;
        self.operationType = operationType;
        self.aDuration = duration;
    }
    return self;
}



- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //get fromVC fromView toVC and toView
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    //get containerView and duration
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval durtion = [self transitionDuration:transitionContext];
    
    //bouns
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    [containerView addSubview:toVC.view];
    switch (self.operationType) {
#pragma mark - Present
        case OperationTypePresent:
            switch (self.animationType) {
                case AnimationTypeNone:
                    
                    [transitionContext completeTransition:YES];
                    break;
                case AnimationTypeFade:{
                    
                    toVC.view.alpha = 0.0;
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        toVC.view.alpha = 1.0;
                    } completion:^(BOOL finished) {
                        
                        [transitionContext completeTransition:YES];
                    }];
                }
                    break;
                case AnimationTypeSpring:{
                    
                    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
                    [UIView animateWithDuration:durtion delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        toVC.view.frame = finalFrame;
                    } completion:^(BOOL finished) {
                        [transitionContext completeTransition:YES];
                    }];
                }
                    
                    break;
                case AnimationTypeRotation:{
                    
                    [containerView sendSubviewToBack:toVC.view];
                    [containerView setBackgroundColor:[UIColor blackColor]];
                    //reset layer transform
                    fromVC.view.layer.transform = CATransform3DIdentity;
                    toVC.view.layer.transform = CATransform3DIdentity;
                    
                    CATransform3D toViewTransform = CATransform3DIdentity;
                    
                    toVC.view.layer.transform = CATransform3DRotate(toViewTransform, -M_PI, 0, 1, 0);
                    
                    CATransform3D fromViewTransform = CATransform3DIdentity;
                    toViewTransform.m34 = 0.004;
                    fromViewTransform.m34 = 0.004;
                    
                    toVC.view.layer.doubleSided = NO;
                    fromVC.view.layer.doubleSided = NO;
                    
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        
                        fromVC.view.layer.transform = CATransform3DRotate(fromViewTransform,-M_PI, 0, 1, 0);
                        
                        toVC.view.layer.transform = CATransform3DRotate(toViewTransform, -M_PI *2, 0, 1, 0);
                    } completion:^(BOOL finished) {
                        toVC.view.layer.transform = CATransform3DIdentity;
                        fromVC.view.layer.transform = CATransform3DIdentity;
                        [transitionContext completeTransition:YES];
                    }];
                }
                    break;
                case AnimationTypeBook:{
                    [containerView sendSubviewToBack:toView];
                    CATransform3D transform = CATransform3DIdentity;
                    transform.m34 = 0.004;
                    containerView.layer.sublayerTransform = transform;
                    [self setAnchorPoint:CGPointMake(0, 0.5) toView:fromView];
                    fromView.layer.doubleSided = NO;
                    fromView.layer.transform = CATransform3DIdentity;
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        fromView.layer.transform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
                    } completion:^(BOOL finished) {
                        fromView.layer.transform = CATransform3DIdentity;
                        [self setAnchorPoint:CGPointMake(0.5, 0.5) toView:fromView];
                        [transitionContext completeTransition:YES];
                    }];
                }
                    break;
                    
                case AnimationTypeCard:{
                    toView.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
                    UIView *frontView = [[UIView alloc] initWithFrame:screenBounds];
                    [fromView addSubview:frontView];
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        fromView.transform = CGAffineTransformMakeScale(0.7, 0.7);
                        frontView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
                        toView.frame = finalFrame;
                    } completion:^(BOOL finished) {
                        fromView.transform = CGAffineTransformIdentity;
                        [frontView removeFromSuperview];
                        [transitionContext completeTransition:YES];
                    }];
                }
                    
                    break;
                    
                default:
                    break;
            }

            break;
#pragma mark - Dismiss
        case OperationTypeDismiss:
            switch (self.animationType) {
                case AnimationTypeNone:
                    [containerView sendSubviewToBack:toVC.view];
                    [fromVC.view removeFromSuperview];
                    [transitionContext completeTransition:YES];
                    break;
                case AnimationTypeFade:{
                    [containerView sendSubviewToBack:toVC.view];
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        fromVC.view.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        
                        [transitionContext completeTransition:YES];
                    }];
                }
                    break;
                case AnimationTypeSpring:{
                    
                    toVC.view.frame = CGRectOffset(finalFrame, 0, -screenBounds.size.height);
                    [UIView animateWithDuration:durtion delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        toVC.view.frame = finalFrame;
                    } completion:^(BOOL finished) {
                        [transitionContext completeTransition:YES];
                    }];
                }
                    
                    break;
                case AnimationTypeRotation:
                {
                    [containerView sendSubviewToBack:toVC.view];
                    [containerView setBackgroundColor:[UIColor blackColor]];
                    //reset layer transform
                    //fromVC.view.layer.transform = CATransform3DIdentity;
                    toVC.view.layer.transform = CATransform3DIdentity;
                    
                    
                    CATransform3D transformA = fromVC.view.layer.transform;
                    transformA.m34 = 0.004;
                    CATransform3D transformB = fromVC.view.layer.transform;
                    transformB.m34 = 0.004;
                    
                    fromVC.view.layer.doubleSided = NO;
                    toVC.view.layer.doubleSided = NO;
                    
                    toVC.view.layer.transform = CATransform3DRotate(transformB, -M_PI, 0, 1, 0);
                    transformB = toVC.view.layer.transform;
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        fromVC.view.layer.transform = CATransform3DRotate(transformA,-M_PI, 0, 1, 0);
                        toVC.view.layer.transform = CATransform3DRotate(transformB, -M_PI, 0, 1, 0);
                        
                    } completion:^(BOOL finished) {
                        fromVC.view.layer.transform = CATransform3DIdentity;
                        toVC.view.layer.transform = CATransform3DIdentity;
                        [transitionContext completeTransition:YES];
                    }];
                }
                    break;
                case AnimationTypeBook:{
                    [containerView insertSubview:toView aboveSubview:fromView];
                    toView.layer.doubleSided = NO;
                    CATransform3D transform = toView.layer.transform;
                    transform.m34 = 0.004;
                    [self setAnchorPoint:CGPointMake(0, 0.5) toView:toView];
                    toView.layer.transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        toView.layer.transform = CATransform3DIdentity;
                    } completion:^(BOOL finished) {
                        [self setAnchorPoint:CGPointMake(0.5, 0.5) toView:toView];
                        [transitionContext completeTransition:YES];
                    }];
                }
                    break;
                case AnimationTypeCard:{
                    UIView *frontView = [[UIView alloc] initWithFrame:screenBounds];
                    [toView addSubview:frontView];
                    toView.transform = CGAffineTransformMakeScale(0.7, 0.7);
                    frontView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
                    [containerView sendSubviewToBack:toView];
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        toView.transform = CGAffineTransformIdentity;
                        frontView.backgroundColor = [UIColor clearColor];
                        fromView.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
                    } completion:^(BOOL finished) {
                        
                        [frontView removeFromSuperview];
                        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                    }];
                }
                    
                    break;
                    
                    
                default:
                    break;
            }
            break;
#pragma mark - Push
        case OperationTypePush:
            switch (self.animationType) {
                case AnimationTypeNone:
                    
                    [transitionContext completeTransition:YES];
                    break;
                case AnimationTypeFade:{
                    
                    toVC.view.alpha = 0.0;
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        toVC.view.alpha = 1.0;
                    } completion:^(BOOL finished) {
                        
                        [transitionContext completeTransition:YES];
                    }];
                }
                    break;
                case AnimationTypeSpring:{
                    
                    toVC.view.frame = CGRectOffset(finalFrame, screenBounds.size.width, 0);
                    [UIView animateWithDuration:durtion delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        toVC.view.frame = finalFrame;
                    } completion:^(BOOL finished) {
                        [transitionContext completeTransition:YES];
                    }];
                }
                    
                    break;
                case AnimationTypeRotation:{
                    [containerView sendSubviewToBack:toVC.view];
                    [containerView setBackgroundColor:[UIColor blackColor]];
                    //reset layer transform
                    fromVC.view.layer.transform = CATransform3DIdentity;
                    toVC.view.layer.transform = CATransform3DIdentity;
                    
                    CATransform3D toViewTransform = CATransform3DIdentity;
                    
                    toVC.view.layer.transform = CATransform3DRotate(toViewTransform, -M_PI, 0, 1, 0);
                    
                    CATransform3D fromViewTransform = CATransform3DIdentity;
                    toViewTransform.m34 = 0.004;
                    fromViewTransform.m34 = 0.004;
                    
                    toVC.view.layer.doubleSided = NO;
                    fromVC.view.layer.doubleSided = NO;
                    
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        
                        fromVC.view.layer.transform = CATransform3DRotate(fromViewTransform,-M_PI, 0, 1, 0);
                        
                        toVC.view.layer.transform = CATransform3DRotate(toViewTransform, -M_PI *2, 0, 1, 0);
                    } completion:^(BOOL finished) {
                        toVC.view.layer.transform = CATransform3DIdentity;
                        fromVC.view.layer.transform = CATransform3DIdentity;
                        [transitionContext completeTransition:YES];
                    }];
                }
                    
                    break;
                case AnimationTypeBook:{
                    [containerView sendSubviewToBack:toView];
                    fromView.layer.doubleSided = NO;
                    CATransform3D transform = CATransform3DIdentity;
                    transform.m34 = 0.004;
                    [self setAnchorPoint:CGPointMake(0, 0.5) toView:fromView];
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        fromView.layer.transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
                    } completion:^(BOOL finished) {
                        [self setAnchorPoint:CGPointMake(0.5, 0.5) toView:fromView];
                        fromView.layer.transform = CATransform3DIdentity;
                        [transitionContext completeTransition:YES];
                    }];
                }
                    break;
                    
                default:
                    break;
            }
            break;
#pragma mark Pop
        case OperationTypePop:{
            switch (self.animationType) {
                case AnimationTypeNone:
                    [containerView sendSubviewToBack:toVC.view];
                    [fromVC.view removeFromSuperview];
                    [transitionContext completeTransition:YES];
                    break;
                case AnimationTypeFade:{
                    [containerView sendSubviewToBack:toVC.view];
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        fromVC.view.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        
                        [transitionContext completeTransition:YES];
                    }];
                }
                    break;
                case AnimationTypeSpring:{
                    
                    toVC.view.frame = CGRectOffset(finalFrame, -screenBounds.size.width, 0);
                    [UIView animateWithDuration:durtion delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        toVC.view.frame = finalFrame;
                    } completion:^(BOOL finished) {
                        [transitionContext completeTransition:YES];
                    }];
                }
                    
                    break;
                case AnimationTypeRotation:{
                    [containerView sendSubviewToBack:toVC.view];
                    [containerView setBackgroundColor:[UIColor blackColor]];
                    //reset layer transform
                    fromVC.view.layer.transform = CATransform3DIdentity;
                    toVC.view.layer.transform = CATransform3DIdentity;
                    
                    
                    CATransform3D transformA = CATransform3DIdentity;
                    transformA.m34 = 0.004;
                    CATransform3D transformB = CATransform3DIdentity;
                    transformB.m34 = 0.004;
                    
                    fromVC.view.layer.doubleSided = NO;
                    toVC.view.layer.doubleSided = NO;
                    
                    toVC.view.layer.transform = CATransform3DRotate(transformB, M_PI, 0, 1, 0);
                    
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                        fromVC.view.layer.transform = CATransform3DRotate(transformA,M_PI, 0, 1, 0);
                        toVC.view.layer.transform = CATransform3DRotate(transformB, M_PI*2, 0, 1, 0);
                        
                    } completion:^(BOOL finished) {
                        toVC.view.layer.transform = CATransform3DIdentity;
                        fromVC.view.layer.transform = CATransform3DIdentity;
                        [transitionContext completeTransition:YES];
                    }];
                }
                    
                    break;
                case AnimationTypeBook:{
                    [containerView insertSubview:toView aboveSubview:fromView];
                    toView.layer.doubleSided = NO;
                    CATransform3D transform = CATransform3DIdentity;
                    transform.m34 = 0.004;
                    [self setAnchorPoint:CGPointMake(0, 0.5) toView:toView];
                    toView.layer.transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
                    [UIView animateWithDuration:durtion delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                        toView.layer.transform = CATransform3DIdentity;
                    } completion:^(BOOL finished) {
                        [self setAnchorPoint:CGPointMake(0.5, 0.5) toView:toView];
                        [transitionContext completeTransition:YES];
                    }];
                }
                    break;
                    
                default:
                    break;
            }
        }
            
            break;
        default:
            
            break;
    }
    
    
}


- (void)setAnchorPoint:(CGPoint)anchorPoint toView:(UIView*)view {
    CGRect preFrame = view.frame;
    view.layer.anchorPoint = anchorPoint;
    view.frame = preFrame;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    if (self.aDuration > 0) {
        return self.aDuration;
    } else {
        switch (self.operationType) {
            case OperationTypePresent:
                return 0.8f;
                break;
            case OperationTypeDismiss:
                return 0.4f;
                break;
            case OperationTypePush:
                return 0.4f;
                break;
            case OperationTypePop:
                return 0.4f;
                break;
            default:
                return 0.8f;
                break;
        }
    }
    
}





@end
