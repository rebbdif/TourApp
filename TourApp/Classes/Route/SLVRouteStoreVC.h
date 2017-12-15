//
//  SLVRouteStoreViewController.h
//  TourApp
//
//  Created by Леонид Серебряный on 01/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol SLVPlaceCellDelegate;
@class SLVRoutesPresenter;
@class UIViewController;


@interface SLVRouteStoreVC : UIViewController <SLVPlaceCellDelegate>

- (instancetype)initWithPresenter:(SLVRoutesPresenter *)presenter;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
