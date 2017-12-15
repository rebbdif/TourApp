//
//  SLVPresenterFactory.m
//  TourApp
//
//  Created by 1 on 26.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVPresenterFactory.h"
#import "SLVNetworkService.h"
#import "SLVStorageService.h"

#import "SLVNodesPresenter.h"
#import "SLVRoutesPresenter.h"


//TODO: сделать правильную инъекцию зависимостей

@implementation SLVPresenterFactory

+ (id)nodesPresenter {
    SLVNetworkService *networkService = [SLVNetworkService new];
    SLVStorageService *storage = [SLVStorageService new];
    SLVNodesPresenter *nodesPresenter = [[SLVNodesPresenter alloc] initWithNetworkService:networkService storage:storage];
    return nodesPresenter;
}

+ (id)routesPresenter {
    SLVNetworkService *networkService = [SLVNetworkService new];
    SLVStorageService *storage = [SLVStorageService new];
    SLVRoutesPresenter *routesPresenter = [[SLVRoutesPresenter alloc] initWithNetworkService:networkService storage:storage];
    return routesPresenter;
}

@end
