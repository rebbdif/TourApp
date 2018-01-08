//
//  SLVTagsViewModel.h
//  TourApp
//
//  Created by Леонид Серебряный on 08/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SLVTag;


@interface SLVTagsService : NSObject

- (void)addTags:(NSArray<SLVTag *> *)tags;
- (void)addTag:(SLVTag *)tag;

@end
