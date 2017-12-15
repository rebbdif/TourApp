//
//  SLVRoutePresenter.m
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

@import CoreData;

#import "SLVNodesPresenter.h"

#import "SLVNetworkProtocol.h"
#import "SLVStorageProtocol.h"

#import "SLVNode.h"
#import "SLVRoute.h"


@interface SLVNodesPresenter ()

@property (nonatomic, strong) id<SLVNetworkProtocol> networkService;
@property (nonatomic, strong) id<SLVStorageProtocol> storage;
@property (nonatomic, copy) NSArray<SLVNode *> *nodes;
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
        _nodes = [NSArray new];
    }
    return self;
}

- (NSString *)currentRouteIdentifier
{
    NSString *currentRouteIdentifier = @"testRoute0";
    return currentRouteIdentifier;
}

- (void)getNodesWithCompletion:(voidBlock)completion
{
    self.retryCount = 0;
    SLVRoute *fetchedRoute = [self fetchRoute];
    if (!fetchedRoute)
    {
        [self downloadNodesWithCompletion:completion];
        return;
    }
    NSArray<SLVNode *> *fetchedNodes = fetchedRoute.nodes.array;
    NSLog(@"fetched: %@", @(fetchedNodes.count));
    if (fetchedNodes.count == 0)
    {
        [self downloadNodesWithCompletion:completion];
        return;
    }
    self.nodes = [fetchedNodes copy];
    if (completion) completion();
}

- (SLVRoute *)fetchRoute
{
    SLVRoute *currentRoute = [self.storage fetchEntity:SLVRouteEntityName forKey:self.currentRouteIdentifier];
    return currentRoute;
}

- (void)downloadNodesWithCompletion:(voidBlock)completion
{
    NSString *path = [NSString stringWithFormat:@"https://tourapp-eab67.firebaseio.com/Routes/%@.json", self.currentRouteIdentifier];
    NSURL *url = [NSURL URLWithString:path];
    [self.networkService getDictionaryFromURL:url withCompletionBlock:^(NSDictionary *data)
    {
        [self processDownloadedData:data];
        [self getNodesWithCompletion:completion];
    }];
}

- (void)processDownloadedData:(NSDictionary *)data
{
    NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    NSManagedObjectContext *mainContext = [self.storage mainContext];
    privateContext.parentContext = mainContext;
    
    [privateContext performBlockAndWait:^{
        NSDictionary *downloadedRoute = data[@"Route"];
        SLVRoute * route = [SLVRoute routeWithDictionary:downloadedRoute context:privateContext];
        
        NSDictionary *downloadedNodes = data[@"Nodes"];
        [self saveNodes:downloadedNodes inContext:privateContext];
        
        route.nodes = [NSOrderedSet orderedSetWithArray:self.nodes];
        
        [self.storage savePrivateContext:privateContext];
    }];
}

- (void)saveNodes:(NSDictionary *)input inContext:(NSManagedObjectContext *)context
{
    NSMutableArray *nodes = [NSMutableArray arrayWithCapacity:input.count];
    for (NSDictionary *obj in input)
    {
        SLVNode *node = [SLVNode nodeWithDictionary:input[obj] context:context];
        [nodes addObject:node];
    }
    self.nodes = [nodes copy];
    [self logNodes:self.nodes];
}

- (void)logNodes:(NSArray *)nodes
{
    for (SLVNode *node in nodes)
    {
        NSLog(@"%@ %f", node.name, node.latitude);
    }
}

- (NSUInteger)numberOfObjects
{
    return self.nodes.count;
}

- (id)objectForIndex:(NSUInteger)index
{
    return self.nodes[index];
}

@end
