//
//  DiaryListCell.h
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/23.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Diary+CoreDataProperties.h"
@interface DiaryListCell : UITableViewCell

@property (nonatomic, strong) UITableView *tableView;

- (void)configureCellWithDiary:(Diary *)diary;

@end
