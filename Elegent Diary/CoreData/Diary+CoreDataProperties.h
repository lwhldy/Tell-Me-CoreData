//
//  Diary+CoreDataProperties.h
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/23.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "Diary+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Diary (CoreDataProperties)

+ (NSFetchRequest<Diary *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSString *sectionMonth;

+ (NSManagedObject *)insertObjectWithManagedObjectContext:(NSManagedObjectContext *)context;


@end

NS_ASSUME_NONNULL_END
