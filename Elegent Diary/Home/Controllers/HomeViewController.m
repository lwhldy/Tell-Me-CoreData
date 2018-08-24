//
//  HomeViewController.m
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/21.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "HomeViewController.h"
#import "WriteViewController.h"
#import "TransitionAnimation.h"
#import "WriteViewController.h"
#import "WHInteractiveTransition.h"
#import "CoreDataManger.h"
#import "Diary+CoreDataProperties.h"
#import "ListViewController.h"
@interface HomeViewController ()<UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *smellImageView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic, strong) WHInteractiveTransition *interactionController;
@property (nonatomic, assign, getter=isFirstLoad) BOOL firstLoad;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
    
    [self.smellImageView addGestureRecognizer:imageTap];
    self.interactionController = [WHInteractiveTransition new];
    [NSTimer bk_scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
        [self.smellImageView setHighlighted:!self.smellImageView.isHighlighted];
    } repeats:YES];
    self.firstLoad = YES;
}


- (void)viewDidAppear:(BOOL)animated {

    if (self.isFirstLoad) {
        [self goToWriteViewController];
        [UIView animateWithDuration:0.3 animations:^{
            self.addButton.transform = CGAffineTransformMakeTranslation(0, 100);
        }];
    }else {
        [UIView animateWithDuration:0.3 delay:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.addButton.transform = CGAffineTransformIdentity;
        } completion:nil];
    }
    
}



- (void)tapImage:(UITapGestureRecognizer *)gesture {
    NSFetchRequest *request = [Diary fetchRequest];
    request.resultType = NSCountResultType;
    NSError *error;
    NSArray *result = [[CoreDataManger shareManager].managedObjectContext executeFetchRequest:request error:&error];
    if (!error) {
        NSInteger diaryCount = [result.firstObject integerValue];
        if (diaryCount == 0) {
            [self goToWriteViewController];
        }else {
            [self goToListViewController];
        }
    }else {
        kShowError(error);
    }
    
}

- (IBAction)addButtonClick:(UIButton *)sender {
    [self goToWriteViewController];
    
}


- (void)goToWriteViewController {
    WriteViewController *wvc = [[WriteViewController alloc] initWithNibName:@"WriteViewController" bundle:nil];
    wvc.transitioningDelegate = self;
    [self.interactionController wireToViewController:wvc];
    [self presentViewController:wvc animated:YES completion:nil];
    self.firstLoad = NO;
}

- (void)goToListViewController {
    ListViewController *lvc = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
    lvc.transitioningDelegate = self;
    [self.interactionController wireToViewController:lvc];
    [self presentViewController:lvc animated:YES completion:nil];
}


#pragma mark - UIViewControllerTransitioningDelegate 

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[TransitionAnimation alloc] initWithDuration:0.3 OperationType:OperationTypePresent animationType:AnimationTypeCard];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[TransitionAnimation alloc] initWithDuration:0.3 OperationType:OperationTypeDismiss animationType:AnimationTypeCard];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController.isInteracting ? self.interactionController : nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
