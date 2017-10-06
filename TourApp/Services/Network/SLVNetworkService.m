//
//  SLVNetworkService.m
//  TourApp
//
//  Created by 1 on 01.05.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVNetworkService.h"
#import <UIKit/UIKit.h>

@interface SLVNetworkService()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation SLVNetworkService

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (void)getDictionaryFromURL:(NSURL *)url withCompletionBlock:(void (^)(NSDictionary * data))completionBlock {
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!data) {
            NSLog(@"Error while downloading data %@", error.userInfo);
        } else {
            NSDictionary *result = [self parseData:data];
            completionBlock(result);
        }
    }];
    [task resume];
}

- (NSDictionary *)parseData:(NSData *)data {
    NSError *jsonError = nil;
    NSDictionary *downloadedData = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&jsonError];
    if (!downloadedData) {
        NSLog(@"Error parsing JSON: %@", jsonError);
        return nil;
    }
    return downloadedData;
}

@end
