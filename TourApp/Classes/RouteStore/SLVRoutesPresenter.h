//
//  SLVRoutesPresenter.h
//  TourApp
//
//  Created by Леонид Серебряный on 02/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SLVNetworkProtocol;
@protocol SLVStorageProtocol;


@interface SLVRoutesPresenter : NSObject

- (instancetype)initWithNetworkService:(id<SLVNetworkProtocol>)networkService storage:(id<SLVStorageProtocol>)storage;

- (NSUInteger)numberOfObjects;

- (id)objectForIndex:(NSUInteger)index;

- (void)getRoutesWithCompletion:(voidBlock)completion;
- (void)downloadRoutesWithCompletion:(voidBlock)completion;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
