//
//  SLVRoutePresenter.h
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLVNetworkProtocol.h"
#import "SLVStorageProtocol.h"

@interface SLVNodesPresenter : NSObject

- (instancetype)initWithNetworkService:(id<SLVNetworkProtocol>)networkService storage:(id<SLVStorageProtocol>)storage;

- (NSUInteger)numberOfPoints;

- (NSUInteger)pointForIndex;

@end
