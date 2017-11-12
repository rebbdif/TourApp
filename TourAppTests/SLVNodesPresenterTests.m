//
//  SLVNodesPresenterTests.m
//  TourApp
//
//  Created by 1 on 07.10.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SLVNodesPresenter.h"
#import "SLVNetworkService.h"
#import "SLVStorageService.h"
#import "SLVNetworkProtocol.h"
#import "SLVStorageProtocol.h"
#import "SLVNode.h"


@interface SLVNodesPresenterTests : XCTestCase

@property (nonatomic, strong) id nodesPresenter;
@property (nonatomic, strong) id networkService;
@property (nonatomic, strong) id<SLVStorageProtocol> storage;
@property (nonatomic, copy) NSString *currentRouteIdentifier;

@end

@interface SLVNodesPresenter (Test)

@property (nonatomic, copy) NSDictionary *nodes;
@property (nonatomic, copy) NSString *currentRouteIdentifier;

- (void)getNodesWithCompletion:(voidBlock)completion;
- (NSArray *)fetchNodes;
- (void)downloadNodesWithCompletion:(voidBlock)completion;
- (void)parseNodes:(NSDictionary *)data;

@end

@implementation SLVNodesPresenterTests

- (void)setUp {
    [super setUp];
    self.storage = OCMProtocolMock(@protocol(SLVStorageProtocol));
    self.networkService = OCMProtocolMock(@protocol(SLVNetworkProtocol));
    self.currentRouteIdentifier = @"testRoute";
    self.nodesPresenter = OCMPartialMock([[SLVNodesPresenter alloc] initWithNetworkService:self.networkService storage:self.storage]);
}

- (void)tearDown {
    self.storage = nil;
    self.networkService = nil;
    self.nodesPresenter = nil;
    self.currentRouteIdentifier = nil;
    [super tearDown];
}

- (void)testGetNodesWhenHasFetchedNodes {
    id mock = OCMPartialMock(self.nodesPresenter);
    OCMStub([mock fetchNodes]).andReturn([self mockedNodes]);
    
    [self.nodesPresenter getNodesWithCompletion:nil];

    OCMVerify([self.nodesPresenter setNodes:[OCMArg any]]);
    //XCTAssert(self.nodesPresenter.nodes.count == 3, @"должно быть 3 узла");
}

- (void)testGetNodesWhenHasNoFetchedNodes {
    id mock = OCMPartialMock(self.nodesPresenter);
    NSArray *fetchedNodes = [NSArray new];
    OCMStub([mock fetchNodes]).andReturn(fetchedNodes);
    OCMStub([mock downloadNodesWithCompletion:[OCMArg any]]).andDo(nil);

    [self.nodesPresenter getNodesWithCompletion:nil];
    
    OCMVerify([self.nodesPresenter downloadNodesWithCompletion:nil]);
}

- (NSArray *)mockedNodes
{
    id mockedNode = OCMClassMock([SLVNode class]);
    OCMStub([mockedNode name]).andReturn(@"name");
    return @[mockedNode, mockedNode, mockedNode];
}

@end
