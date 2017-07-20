//
//  SLVRoute.h
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <CoreData/CoreData.h>

@class UIImage;
@class SLVInfo;
@class SLVNode;
@class SLVTag;

@interface SLVRoute : NSManagedObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, strong) UIImage *thumbnail;

@property (nonatomic, copy) NSOrderedSet<SLVNode *> *nodes;
@property (nonatomic, strong) SLVInfo *info;
@property (nonatomic, copy) NSSet<SLVTag *> *tags;

@end
