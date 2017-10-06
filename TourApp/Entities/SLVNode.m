//
//  SLVNode.m
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVNode.h"

@implementation SLVNode

@dynamic identifier;
@dynamic name;
@dynamic thumbnailURL;
@dynamic thumbnail;
@dynamic latitude;
@dynamic longitude;

@dynamic info;

+ (instancetype)nodeWithDictionary:(NSDictionary *)dict context:(NSManagedObjectContext *)context {
    NSString *nodeId = dict[@"identifier"];
    NSAssert(nodeId, @"cityId shouldnt be nil");
    __block SLVNode *node = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self class])];
    request.predicate = [NSPredicate predicateWithFormat:@"identifier == %@", nodeId];
    [context performBlockAndWait:^{
        NSError *error = nil;
        NSArray<SLVNode *> *results = [context executeFetchRequest:request error:&error];
        if (results) {
            node = results.lastObject;
        }
    }];
    if (!node) {
        [context performBlockAndWait:^{
            node = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
            node.identifier = nodeId;
            node.name = dict[@"name"];
            node.thumbnailURL = dict[@"thumbnailURL"];
            node.latitude = [dict[@"latitude"] floatValue];
            node.longitude = [dict[@"longitude"] floatValue];
            NSError *error = nil;
            if (![context save:&error]) {
                NSLog(@"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                abort();
            }
        }];
    }
    return node;
}

@end
