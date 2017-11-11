//
//  SLVInfo.h
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <CoreData/CoreData.h>

@class UIImage;

@interface SLVInfo : NSManagedObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSArray<UIImage *> *image;

+ (instancetype)infoWithDictionary:(NSDictionary *)dict context:(NSManagedObjectContext *)context;

@end
