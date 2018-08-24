//
//  ListViewController.m
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/23.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "ListViewController.h"
#import "ListSectionHeaderView.h"
#import "DiaryListCell.h"
#import "CoreDataManger.h"
#import "DetailViewController.h"
#import "TransitionAnimation.h"
#import "WHInteractiveTransition.h"
static NSString *const CellId = @"DiaryListCell";
static CGFloat const SectionHeaderHeight = 78;
@interface ListViewController ()<UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UIViewControllerTransitioningDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) CoreDataManger *diaryManager;
@property (nonatomic, strong) NSFetchedResultsController *fetchC;
@property (nonatomic, strong) WHInteractiveTransition *interactionController;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"DiaryListCell" bundle:nil] forCellReuseIdentifier:CellId];
    self.tableView.estimatedRowHeight = 100;

    self.tableView.rowHeight = UITableViewAutomaticDimension;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    self.tableView.tableFooterView = footerView;
    self.diaryManager = [CoreDataManger shareManager];
    [self fetchDiaryListRquest];
    self.interactionController = [[WHInteractiveTransition alloc] init];
}


- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)fetchDiaryListRquest {
    NSFetchRequest *request = [Diary fetchRequest];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    request.sortDescriptors = @[descriptor];
    //创建NSFetchedResultsController并绑定MOC
    NSFetchedResultsController *fetchC = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.diaryManager.managedObjectContext sectionNameKeyPath:@"sectionMonth" cacheName:nil];
    NSError *error;
    [fetchC performFetch:&error];
    self.fetchC = fetchC;
    self.fetchC.delegate = self;
    if (error) {
        kShowError(error);
    }else {
        [self.tableView reloadData];
    }
    
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[TransitionAnimation alloc] initWithDuration:0.4 OperationType:OperationTypePresent animationType:AnimationTypeCard];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[TransitionAnimation alloc] initWithDuration:0.4 OperationType:OperationTypeDismiss animationType:AnimationTypeCard];
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    return self.interactionController.isInteracting ? self.interactionController : nil;
}


#pragma mark - NSFetchedResultsControllerDelegate 

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    if (NSFetchedResultsChangeDelete == type) {
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    if (NSFetchedResultsChangeDelete == type) {
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {

    [self.tableView endUpdates];

}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Diary *diary = [self.fetchC objectAtIndexPath:indexPath];
    DetailViewController *dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    dvc.diary = diary;
    dvc.transitioningDelegate = self;
    [self.interactionController wireToViewController:dvc];
    [self presentViewController:dvc animated:YES completion:nil];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ListSectionHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"ListSectionHeaderView" owner:self options:nil].firstObject;
    headerView.frame = CGRectMake(0, 0, kScreenWidth, SectionHeaderHeight);
    NSString *sectionMonth = self.fetchC.sections[section].name;
    [headerView setMonthLabelText:sectionMonth];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SectionHeaderHeight;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


#pragma mark - UITableViewDataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchC.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchC.sections[section].numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiaryListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    Diary *diary = [self.fetchC objectAtIndexPath:indexPath];
    [cell configureCellWithDiary:diary];
    cell.tableView = tableView;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Diary *diary = [self.fetchC objectAtIndexPath:indexPath];
        [self.diaryManager.managedObjectContext deleteObject:diary];
        NSError *error;
        if (![self.diaryManager.managedObjectContext save:&error]) {
            kShowError(error);
        }
    }
}



@end
