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

@property (nonatomic, assign) NSInteger retryCount;

@end


@implementation SLVNodesPresenter

- (instancetype)initWithNetworkService:(id<SLVNetworkProtocol>)networkService storage:(id<SLVStorageProtocol>)storage
{
    self = [super init];
    if (self) {
        _networkService = networkService;
        _storage = storage;
        _nodes = [NSDictionary new];
    }
    return self;
}

- (NSString *)currentRouteIdentifier
{
    NSString *currentRouteIdentifier = @"testRoute";
    return currentRouteIdentifier;
}

- (void)getNodesWithCompletion:(voidBlock)completion
{
    self.retryCount = 0;
    NSArray<SLVNode *> *fetchedNodes = [self fetchNodes];
    NSLog(@"fetched: %@", @(fetchedNodes.count));
    if (fetchedNodes.count == 0)
    {
        [self downloadNodesWithCompletion:completion];
        return;
    }
    NSMutableDictionary *nodes = [NSMutableDictionary new];
    for (NSUInteger i = 0; i < fetchedNodes.count; ++i)
    {
        [nodes setObject:fetchedNodes[i] forKey:@(i)];
    }
    self.nodes = [nodes copy];
    if (completion) completion();
}

- (NSArray<SLVNode *> *)fetchNodes
{
    NSArray<SLVNode *> *nodes = [self.storage fetchEntities:SLVNodeEntityName forKey:self.currentRouteIdentifier];
    NSLog(@"fetched %@ nodes", @(nodes.count));
    return nodes;
}

- (void)downloadNodesWithCompletion:(voidBlock)completion
{
    NSString *path = [NSString stringWithFormat:@"https://tourapp-eab67.firebaseio.com/Routes/%@.json", self.currentRouteIdentifier];
    NSURL *url = [NSURL URLWithString:path];
    [self.networkService getDictionaryFromURL:url withCompletionBlock:^(NSDictionary *data)
    {
        NSLog(@"Downloaded %@ nodes %@", @(data.count), data[@"Nodes"]);
        [self saveNodes:data];
        [self getNodesWithCompletion:completion];
    }];
}

- (void)saveNodes:(NSDictionary *)data
{
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
        
        [self.storage savePrivateContext:privateContext];
        
        self.nodes = [nodes copy];
        [self logNodes:self.nodes];
    }];
}

- (void)logNodes:(NSDictionary *)nodes
{
    [nodes enumerateKeysAndObjectsUsingBlock:^(id key, SLVNode *node, BOOL *stop) {
        NSLog(@"%@ %f", node.name, node.latitude);
    }];
}

- (NSUInteger)numberOfObjects
{
    return self.nodes.count;
}

- (id)objectForIndex:(NSUInteger)index
{
    return self.nodes[@(index)];
}

@end
