//
//  CoreDataStack.m
//  bolt
//
//  Created by 1 on 07.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SLVCoreDataStack.h"

@interface SLVCoreDataStack ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *mainContext;
@property (nonatomic, strong) NSPersistentStoreCoordinator *coreDataPSC;

@end

@implementation SLVCoreDataStack

- (instancetype)initStack {
    self = [super init];
    if (self) {
        [self setupCoreData];
    }
    return self;
}

+ (instancetype)stack {
    return [[SLVCoreDataStack alloc] initStack];
}

- (void)setupCoreData {
    [self setupPersistentStoreCoordinator];
    [self setupMainContext];
}

- (void)setupPersistentStoreCoordinator {
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"TourApp" withExtension:@"momd"];
    NSManagedObjectModel *coreDataModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:path];
    
    self.coreDataPSC = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:coreDataModel];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationSupportFolder = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].lastObject;
    
    if (![fileManager fileExistsAtPath:applicationSupportFolder.path]) {
        [fileManager createDirectoryAtPath:applicationSupportFolder.path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSURL *url = [applicationSupportFolder URLByAppendingPathComponent:@"db.sqlite"];
    NSError *err = nil;
    [self.coreDataPSC addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&err];
    if (err) NSLog(@"error %@ %@", err.userInfo, err.localizedDescription);
}

- (void)setupMainContext {
    self.mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.mainContext.persistentStoreCoordinator = self.coreDataPSC;
}

@end
