//
//  SLVInfo.m
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVInfo.h"

@implementation SLVInfo

@dynamic identifier;
@dynamic text;
@dynamic image;

+ (instancetype)infoWithDictionary:(NSDictionary *)dict context:(NSManagedObjectContext *)context
{
    __block SLVInfo *info = nil;
    info = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    info.text = dict[@"text"];
            
    return info;
}

@end
