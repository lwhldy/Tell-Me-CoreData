//
//  CoreDataManger.h
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/22.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataManger : NSObject

+ (instancetype)shareManager;

@property (nonatomic,strong,readonly) NSManagedObjectContext* managedObjectContext;

@end
