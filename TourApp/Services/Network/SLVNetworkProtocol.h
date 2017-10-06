//
//  SLVNetworkDelegate.h
//  Bolt
//
//  Created by 1 on 13.06.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^networkCompletion)(NSDictionary * data);

@protocol SLVNetworkProtocol <NSObject>

- (void)getDictionaryFromURL:(NSURL *)url withCompletionBlock:(networkCompletion)completionBlock;

@end
