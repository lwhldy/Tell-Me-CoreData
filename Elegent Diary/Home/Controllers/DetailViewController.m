//
//  DetailViewController.m
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/23.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *smellImageView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 8.0;
    [self.dateLabel setText:[NSString getToDayPointGapStringFromDate:self.diary.date]];
    [self.textView setAttributedText:[[NSAttributedString alloc] initWithString:self.diary.content attributes:@{NSParagraphStyleAttributeName : style, NSFontAttributeName:[UIFont systemFontOfSize:16]}]];
    [NSTimer bk_scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
        [self.smellImageView setHighlighted:!self.smellImageView.isHighlighted];
    } repeats:YES];
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.smellImageView addGestureRecognizer:imageTap];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
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
