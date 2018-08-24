//
//  DetailViewController.h
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/23.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "BaseViewController.h"
#import "Diary+CoreDataProperties.h"
@interface DetailViewController : BaseViewController
@property (nonatomic, strong) Diary *diary;
@end
