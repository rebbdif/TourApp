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


@implementation SLVRoute

@dynamic identifier;
@dynamic name;
@dynamic author;
@dynamic thumbnailURL;
@dynamic thumbnail;

@dynamic nodes;
@dynamic info;
@dynamic tags;

+ (instancetype)routeWithDictionary:(NSDictionary *)dict context:(NSManagedObjectContext *)context
{
    NSString *routeId = dict[@"identifier"];
    NSAssert(routeId, @"id shouldnt be nil");
    __block SLVRoute *route = nil;
    
    [context performBlockAndWait:^{
        route = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
        route.identifier = routeId;
        route.name = dict[@"name"];
        route.thumbnailURL = dict[@"thumbnailURL"];
        route.author = dict[@"author"];
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
            abort();
        }
    }];
return route;
}

@end
