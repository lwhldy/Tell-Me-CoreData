//
//  Diary+CoreDataProperties.m
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/23.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "Diary+CoreDataProperties.h"

@implementation Diary (CoreDataProperties)

+ (NSFetchRequest<Diary *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Diary"];
}


+ (NSManagedObject *)insertObjectWithManagedObjectContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:@"Diary" inManagedObjectContext:context];
}


@dynamic content;
@dynamic date;
@dynamic sectionMonth;

@end
