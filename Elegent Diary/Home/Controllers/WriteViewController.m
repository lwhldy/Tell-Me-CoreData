//
//  WriteViewController.m
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/22.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "WriteViewController.h"
#import "CoreDataManger.h"
#import "Diary+CoreDataProperties.h"
@interface WriteViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewConstraints;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, assign) CGFloat preOffset;
@property (nonatomic, strong) NSMutableParagraphStyle *style;
@property (nonatomic, assign, getter=isConfirmSave) BOOL confirmSave;
@property (nonatomic, strong) CoreDataManger *diaryManager;
@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        CGRect frame = [note.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
        CGFloat height = frame.size.height;
        if (height > 0) {
            self.textViewConstraints.constant = kScreenHeight - height - 8 * 2 - 21 - 20;
        }
    }];
    [self.dateLabel setText:[NSString getToDayPointGapStringFromDate:[NSDate date]]];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 8.0;
    self.style = style;
    self.diaryManager = [CoreDataManger shareManager];
    NSString *dateString = [[NSUserDefaults standardUserDefaults] objectForKey:kDateKey];
    if ([dateString isEqualToString:[NSString getToDayStringFromDate:[NSDate date]]]) {
        NSData *contentData = (NSData*)[NSString loadLocalDataWithKey:kDraftKey];
        NSString *contentString = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
        [self.textView setAttributedText:[[NSAttributedString alloc] initWithString:contentString attributes:@{NSParagraphStyleAttributeName : self.style, NSFontAttributeName:[UIFont systemFontOfSize:16]}]];
        if (self.textView.contentSize.height >= self.textView.height) {
            [self.textView setContentOffset:CGPointMake(0, self.textView.contentSize.height - self.textView.height) animated:YES];
            self.textView.showsVerticalScrollIndicator = YES;
        }
    }else {
        [self cleanMemory];
    }
    
}

- (void)cleanMemory {
    [[NSFileManager defaultManager] removeItemAtPath:[NSString GetThefilePath:kDraftKey] error:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDraftKey];
}

- (void)viewWillAppear:(BOOL)animated {
    self.textView.scrollEnabled = YES;
    [self.textView becomeFirstResponder];
    
    self.textView.typingAttributes = @{NSParagraphStyleAttributeName : self.style, NSFontAttributeName:[UIFont systemFontOfSize:16]};
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    NSString *diaryString = self.textView.attributedText.string;
    if ([NSString isEmpty:diaryString]) {
        return;
    }
    if (self.isConfirmSave == YES) {
        Diary *diary = (Diary*)[Diary insertObjectWithManagedObjectContext:self.diaryManager.managedObjectContext];
        diary.content = diaryString;
        diary.date = [NSDate date];
        diary.sectionMonth = [NSString getToMonthStringWithDate:[NSDate date]];
        if ([self.diaryManager.managedObjectContext hasChanges]) {
            NSError *error;
            [self.diaryManager.managedObjectContext save:&error];
            if (error) {
                kShowError(error);
            }else {
                [self cleanMemory];
            }
        }
        
    } else {
        NSData *stringData = [diaryString dataUsingEncoding:NSUTF8StringEncoding];
        [NSString saveData:stringData withKey:kDraftKey];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString getToDayStringFromDate:[NSDate date]] forKey:kDateKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
}

#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.preOffset == 0 && scrollView.contentOffset.y < self.preOffset) {
        [scrollView setContentOffset:CGPointZero];;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.preOffset = scrollView.contentOffset.y;
}


#pragma mark - UITextViewDelegate 

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.contentSize.height >= self.textView.height) {
        self.textView.showsVerticalScrollIndicator = YES;
    }else {
        self.textView.showsVerticalScrollIndicator = NO;
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (textView.text && textView.contentSize.height >= textView.height && range.length == textView.text.length) {
        [textView setContentOffset:CGPointMake(0, textView.contentSize.height - textView.height) animated:YES];
    }

    return YES;
}

- (IBAction)dismissSelf:(id)sender {
    self.confirmSave = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
