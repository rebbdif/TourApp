//
//  SLVPresenterFactory.m
//  TourApp
//
//  Created by 1 on 26.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVPresenterFactory.h"
#import "SLVNodesPresenter.h"
#import "SLVNetworkService.h"
#import "SLVStorageService.h"

@implementation SLVPresenterFactory

+ (id)nodesPresenter {
    SLVNetworkService *networkService = [SLVNetworkService new];
    SLVStorageService *storage = [SLVStorageService new];
    SLVNodesPresenter *nodesPresenter = [[SLVNodesPresenter alloc] initWithNetworkService:networkService storage:storage];
    return nodesPresenter;
}

@end
