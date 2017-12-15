//
//  SLVRoutesPresenter.m
//  TourApp
//
//  Created by Леонид Серебряный on 02/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

@import CoreData;

#import "SLVRoutesPresenter.h"

#import "SLVNetworkProtocol.h"
#import "SLVStorageProtocol.h"

#import "SLVInfo.h"
#import "SLVRoute.h"


@interface SLVRoutesPresenter ()

@property (nonatomic, strong) id<SLVNetworkProtocol> networkService;
@property (nonatomic, strong) id<SLVStorageProtocol> storage;
@property (nonatomic, strong) NSMutableArray<SLVRoute *> *routes;
@property (nonatomic, assign) NSInteger retryCount;

@end


@implementation SLVRoutesPresenter

- (instancetype)initWithNetworkService:(id<SLVNetworkProtocol>)networkService storage:(id<SLVStorageProtocol>)storage
{
    self = [super init];
    if (self) {
        _networkService = networkService;
        _storage = storage;
        _routes = [NSMutableArray new];
    }
    return self;
}

- (void)getRoutesWithCompletion:(voidBlock)completion
{
    NSArray *fetched = [self fetchRoutes];
    if (fetched.count == 0)
    {
        [self downloadRoutesWithCompletion:completion];
    }
    else
    {
        self.routes = [fetched mutableCopy];
    }
    if (completion) completion();
}

- (NSArray<SLVRoute *> *)fetchRoutes
{
    NSArray<SLVRoute *> *routes = [self.storage fetchEntities:SLVRouteEntityName forKey:nil];
    return routes;
}

- (void)downloadRoutesWithCompletion:(voidBlock)completion
{
    NSString *path = [NSString stringWithFormat:@"https://tourapp-eab67.firebaseio.com/Routes.json"];
    NSURL *url = [NSURL URLWithString:path];
    [self.networkService getDictionaryFromURL:url withCompletionBlock:^(NSDictionary *data)
     {
         [self processDownloadedData:data];
         [self getRoutesWithCompletion:completion];
     }];
}

- (void)processDownloadedData:(NSDictionary *)data
{
    NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    NSManagedObjectContext *mainContext = [self.storage mainContext];
    privateContext.parentContext = mainContext;
    
    [privateContext performBlockAndWait:^{
        
        [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSDictionary *downloadedRoute, BOOL * _Nonnull stop) {
            SLVRoute *route = [SLVRoute routeWithDictionary:downloadedRoute[@"Route"] context:privateContext];
            [self.routes addObject:route];
        }];
        
        [self.storage savePrivateContext:privateContext];
     }];
}

- (NSUInteger)numberOfObjects
{
    return self.routes.count;
}

- (id)objectForIndex:(NSUInteger)index
{
    return self.routes[index];
}

@end

