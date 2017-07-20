//
//  AppDelegate.m
//  TourApp
//
//  Created by 1 on 19.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVAppDelegate.h"
#import "SLVMainVC.h"

@interface SLVAppDelegate ()

@end

@implementation SLVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    SLVMainVC *mainVC = [SLVMainVC new];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen.mainScreen bounds]];
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
