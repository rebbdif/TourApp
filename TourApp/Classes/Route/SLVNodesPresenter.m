//
//  SLVRoutePresenter.m
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVNodesPresenter.h"
#import "SLVNode.h"

@interface SLVNodesPresenter ()

@property (nonatomic, strong) id<SLVNetworkProtocol> networkService;
@property (nonatomic, strong) id<SLVStorageProtocol> storage;
@property (nonatomic, copy) NSDictionary<NSNumber *, SLVNode *> *nodes;

@end

@implementation SLVNodesPresenter

- (instancetype)initWithNetworkService:(id<SLVNetworkProtocol>)networkService storage:(id<SLVStorageProtocol>)storage {
    self = [super init];
    if (self) {
        _networkService = networkService;
        _storage = storage;
    }
    return self;
}

- (void)getNodesWithCompletion:(voidBlock)completion {
    if (completion) completion();
}

- (NSUInteger)numberOfObjects {
    return self.nodes.count;
}

- (id)objectForIndex:(NSUInteger)index {
    return self.nodes[@(index)];
}

@end
