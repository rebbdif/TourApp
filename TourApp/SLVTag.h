//
//  SLVTag.h
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface SLVTag : NSObject 

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;

+ (instancetype)tagWithName:(NSString *)name;

@end
