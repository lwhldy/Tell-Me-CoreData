//
//  WHInteractiveTransition.h
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/22.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign, getter=isInteracting) BOOL interacting;

- (void)wireToViewController:(UIViewController *)viewController;

@end
