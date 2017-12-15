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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UINavigationController *navigationController = [UINavigationController new];
    navigationController.navigationBarHidden = YES;
    
    SLVSegmentedController *segmentedVC = [SLVSegmentedController new];
    [navigationController pushViewController:segmentedVC animated:NO];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen.mainScreen bounds]];
    self.window.rootViewController = navigationController;
    [segmentedVC setSelectedIndex:2];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
