//
//  SLVRoutePresenter.m
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

@import CoreData;

#import "SLVNodesPresenter.h"
#import "SLVNode.h"
#import "SLVRoute.h"

@interface SLVNodesPresenter ()

@property (nonatomic, strong) id<SLVNetworkProtocol> networkService;
@property (nonatomic, strong) id<SLVStorageProtocol> storage;
@property (nonatomic, copy) NSDictionary<NSNumber *, SLVNode *> *nodes;

@property (nonatomic, copy) NSString *currentRouteIdentifier;

@end

@implementation SLVNodesPresenter

- (instancetype)initWithNetworkService:(id<SLVNetworkProtocol>)networkService storage:(id<SLVStorageProtocol>)storage {
    self = [super init];
    if (self) {
        _networkService = networkService;
        _storage = storage;
        _nodes = [NSDictionary new];
    }
    return self;
}

- (void)assignCurrentRouteIdentifier {
    self.currentRouteIdentifier = @"testRoute";
}

- (void)getNodesWithCompletion:(voidBlock)completion {
    [self assignCurrentRouteIdentifier];
    NSArray<SLVNode *> *fetchedNodes = [self fetchNodes];
    if (fetchedNodes.count == 0) {
        [self downloadNodesWithCompletion:completion];
    } else {
        if (completion) completion();
    }
}

- (NSArray<SLVNode *> *)fetchNodes {
    return 0;
}

- (void)downloadNodesWithCompletion:(voidBlock)completion {
    NSString *path = [NSString stringWithFormat:@"https://tourapp-eab67.firebaseio.com/Routes/%@.json", self.currentRouteIdentifier];
    NSURL *url = [NSURL URLWithString:path];
    [self.networkService getDictionaryFromURL:url withCompletionBlock:^(NSDictionary *data) {
        [self parseNodes:data];
        if (completion) completion();
    }];
}

- (void)parseNodes:(NSDictionary *)data {
    NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    NSManagedObjectContext *mainContext = [self.storage mainContext];
    privateContext.parentContext = mainContext;
    __block NSMutableDictionary *nodes = [NSMutableDictionary new];
    __block NSUInteger index = 0;
    [privateContext performBlockAndWait:^{
        [data[@"Nodes"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            SLVNode *node = [SLVNode nodeWithDictionary:obj context:privateContext];
            [nodes setObject:node forKey:@(index)];
            ++index;
        }];
        NSError *error = nil;
        if (![privateContext save:&error]) {
            abort();
        }
        NSManagedObjectContext *parentContext = privateContext.parentContext;
        [parentContext performBlock:^{
            NSError *error = nil;
            if (![parentContext save:&error]) {
                abort();
            }
        }];
        self.nodes = [nodes copy];
        [nodes enumerateKeysAndObjectsUsingBlock:^(id key, SLVNode *node, BOOL *stop) {
            NSLog(@"%@ %f", node.name, node.latitude);
        }];
    }];
}

- (NSUInteger)numberOfObjects {
    return self.nodes.count;
}

- (id)objectForIndex:(NSUInteger)index {
    return self.nodes[@(index)];
}

@end
