//
//  SLVNode.h
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <CoreData/CoreData.h>

@class UIImage;
@class SLVInfo;

static NSString * const SLVNodeEntityName = @"SLVNode";

@interface SLVNode : NSManagedObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;

@property (nonatomic, strong) SLVInfo *info;

+ (instancetype)nodeWithDictionary:(NSDictionary *)dict context:(NSManagedObjectContext *)context;

@end
