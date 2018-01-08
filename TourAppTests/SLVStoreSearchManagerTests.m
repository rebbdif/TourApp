//
//  SLVStoreSearchManagerTests.m
//  TourAppTests
//
//  Created by Леонид Серебряный on 08/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SLVRouteSearchTagsManager.h"
#import "SLVTag.h"


@interface SLVRouteSearchTagsManager (Test)
@property (nonatomic, strong) NSArray<SLVTag *> *allTags;
@property (nonatomic, strong) NSArray<SLVTag *> *tags;
- (NSArray *)search:(NSString *)text;
@end

@interface SLVStoreSearchManagerTests : XCTestCase
@property (nonatomic, strong) SLVRouteSearchTagsManager *manager;
@end

@implementation SLVStoreSearchManagerTests

- (void)setUp
{
	[super setUp];
	self.manager = OCMPartialMock([SLVRouteSearchTagsManager new]);
}

- (void)tearDown
{
	self.manager = nil;
	[super tearDown];
}

- (void)testSearch_normal
{
	self.manager.allTags = @[
							 [SLVTag tagWithName:@"One"],
							 [SLVTag tagWithName:@"Two"],
							 [SLVTag tagWithName:@"Three"],
							 [SLVTag tagWithName:@"Four"],
							 [SLVTag tagWithName:@"Five"],
							 [SLVTag tagWithName:@"Thriller"],
							 ];
	
	NSArray *expectedResults = @[
								 [SLVTag tagWithName:@"Three"],
								 [SLVTag tagWithName:@"Thriller"],
								 ];
	
	NSArray *results = [self.manager search:@"Thr"];
	
	XCTAssertTrue([results isEqualToArray: expectedResults]);
}

- (void)testSearch_twoWords
{
	self.manager.allTags = @[
							 [SLVTag tagWithName:@"One"],
							 [SLVTag tagWithName:@"Two"],
							 [SLVTag tagWithName:@"Los Angeles"],
							 [SLVTag tagWithName:@"Los Alamos"],
							 [SLVTag tagWithName:@"Los Altos"],
							 [SLVTag tagWithName:@"Thriller"],
							 ];
	
	NSArray *expectedResults = @[
								 [SLVTag tagWithName:@"Los Alamos"],
								 [SLVTag tagWithName:@"Los Altos"],
								 ];
	
	NSArray *results = [self.manager search:@"Los Al"];
	
	XCTAssertTrue([results isEqualToArray: expectedResults]);
}

- (void)testSearch_nil
{
	self.manager.allTags = @[
							 [SLVTag tagWithName:@"One"],
							 [SLVTag tagWithName:@"Two"],
							 [SLVTag tagWithName:@"Los Angeles"],
							 [SLVTag tagWithName:@"Los Alamos"],
							 [SLVTag tagWithName:@"Los Altos"],
							 [SLVTag tagWithName:@"Thriller"],
							 ];
	
	NSArray *results = [self.manager search:@"nil"];
	
	XCTAssertTrue([results isEqualToArray:@[]]);
}

@end
