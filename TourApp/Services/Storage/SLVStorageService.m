//
//  StorageService.m
//  lection14
//
//  Created by 1 on 07.06.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SLVStorageService.h"
@import CoreData;
@import UIKit;
#import "SLVCoreDataStack.h"

@interface SLVStorageService()

@property (nonatomic, strong) SLVCoreDataStack *stack;
@property (nonatomic, strong) dispatch_queue_t saveSyncQueue;

@end

@implementation SLVStorageService

- (instancetype)init {
    self = [super init];
    if (self) {
        _stack = [SLVCoreDataStack stack];
        _saveSyncQueue = dispatch_queue_create("serebryanyy.Bolt.syncQueue", NULL);
    }
    return self;
}

- (id)fetchEntity:(NSString *)entity forKey:(NSString *)key {
    NSArray *results;
    NSError *error = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entity];
    request.predicate = [NSPredicate predicateWithFormat:@"identifier == %@", key];
    
    results = [self.mainContext executeFetchRequest:request error:&error];
    if (results.count == 0) {
        return nil;
    } else if (results.count > 1) {
        NSLog(@"storageService - there is more than one result for request");
    }
    return results[0];
}

- (NSArray *)fetchEntities:(NSString *)entity withPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entity];
    request.fetchBatchSize = 30;
    request.predicate = predicate;
    __block NSArray *fetchedArray;
    NSError *error = nil;
    fetchedArray = [self.mainContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"storageService - error while fetching %@", error);
    }
    return fetchedArray;
}

- (void)save {
    [self.stack.mainContext performBlockAndWait:^{
        if (self.stack.mainContext.hasChanges) {
            NSError *error = nil;
            if(![self.stack.mainContext save:&error]) {
                NSLog(@"storageService - %@", error.localizedDescription);
                NSLog(@"storageService - %@", error.userInfo);
            }
        }
    }];
}

- (NSManagedObjectContext *)mainContext {
    return self.stack.mainContext;
}

@end
