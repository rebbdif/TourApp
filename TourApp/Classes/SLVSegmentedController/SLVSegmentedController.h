//
//  SLVSegmentedController.h
//  TourApp
//
//  Created by 1 on 06.10.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, SLVControllerIndex) {
    SLVControllerIndexNodes,
    SLVControllerIndexMap,
    SLVControllerIndexMain,
};


@interface SLVSegmentedController : UITabBarController

- (void)selectControllerWithIndex:(SLVControllerIndex)controllerIndex;

@end
