//
//  SLVTag.m
//  TourApp
//
//  Created by 1 on 20.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVTag.h"

@implementation SLVTag

//@dynamic identifier;
//@dynamic name;

+ (instancetype)tagWithName:(NSString *)name
{
	SLVTag *tag = [SLVTag new];
	tag.name = name;
	return tag;
}

- (NSString *)description
{
	return self.name;
}

- (id)valueForKey:(NSString *)key
{
	return self.name;
}

- (BOOL)isEqual:(id)object
{
	SLVTag *tag = (SLVTag *)object;
	BOOL equalNames = [self.name isEqualToString:tag.name];
	return equalNames;
}

@end
