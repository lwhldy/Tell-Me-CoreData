//
//  CoreDataManger.m
//  Elegent Diary
//
//  Created by lwhldy on 2017/8/22.
//  Copyright © 2017年 lwhldy. All rights reserved.
//

#import "CoreDataManger.h"

@interface CoreDataManger ()

@property (nonatomic,strong,readwrite) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,strong) NSURL* modelURL;
@property (nonatomic,strong) NSURL* storeURL;

@end



@implementation CoreDataManger

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static CoreDataManger *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[CoreDataManger alloc] initWithStoreURL:[CoreDataManger storeURL] modelURL:[CoreDataManger modelURL]];
    });
    return manager;
}

+ (NSURL *)storeURL {
    NSURL *docmentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    return [docmentsDirectory URLByAppendingPathComponent:@"Diary.sqlite"];
}

+ (NSURL *)modelURL {
    return [[NSBundle mainBundle] URLForResource:@"ElegentDiary" withExtension:@"momd"];
}

- (instancetype)initWithStoreURL:(NSURL *)storeURL modelURL:(NSURL *)modelURL {
    self = [super init];
    if (self) {
        self.storeURL = storeURL;
        self.modelURL = modelURL;
        [self setupManagedObjectContext];
    }
    return self;
}

- (void)setupManagedObjectContext
{
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError* error;
    [self.managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.storeURL options:nil error:&error];
    if (error) {
        kShowError(error);
    }
    self.managedObjectContext.undoManager = [[NSUndoManager alloc] init];
}

- (NSManagedObjectModel *)managedObjectModel {
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
}


@end
