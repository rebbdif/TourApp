//
//  SLVRoute.m
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVRoute.h"
#import "SLVInfo.h"
#import "SLVNode.h"
#import "SLVImage.h"
#import "SLVStorageService.h"


@implementation SLVRoute

@dynamic identifier;
@dynamic name;
@dynamic author;
@dynamic images;
@dynamic shortInfo;

@dynamic nodes;
@dynamic info;
@dynamic tags;

+ (instancetype)routeWithDictionary:(NSDictionary *)dict context:(NSManagedObjectContext *)context
{
    NSDictionary *routeDict = dict;
                                
    NSString *routeId = routeDict[@"identifier"];
    NSAssert(routeId, @"id shouldnt be nil");
    
    __block SLVRoute *route = [self route:routeId existsInContext:context];
    if (route) return route;
    
    [context performBlockAndWait:^{
        route = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
        route.identifier = routeId;
        route.name = routeDict[@"name"];
        route.author = routeDict[@"author"];
        route.shortInfo = routeDict[@"shortInfo"];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
            abort();
        }
    }];
return route;
}

+ (SLVRoute *)route:(NSString *)identifier existsInContext:(NSManagedObjectContext *)context
{
   NSArray<SLVRoute *> *routes = [SLVStorageService fetchEntities:NSStringFromClass([self class]) forKey:identifier inContext:context];
    return routes.lastObject;
}

@end
