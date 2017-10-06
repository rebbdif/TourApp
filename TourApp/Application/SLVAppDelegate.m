//
//  AppDelegate.m
//  TourApp
//
//  Created by 1 on 19.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVAppDelegate.h"
#import "SLVSegmentedController.h"

@interface SLVAppDelegate ()

@end

@implementation SLVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SLVSegmentedController *segmentedVC = [SLVSegmentedController new];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen.mainScreen bounds]];
    self.window.rootViewController = segmentedVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
