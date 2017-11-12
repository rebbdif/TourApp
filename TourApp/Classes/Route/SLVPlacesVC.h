//
//  SLVPlacesVC.h
//  TourApp
//
//  Created by 1 on 31.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLVNodesPresenter.h"

@protocol SLVPlaceCellDelegate;


@interface SLVPlacesVC : UIViewController <SLVPlaceCellDelegate>

- (instancetype)initWithPresenter:(SLVNodesPresenter *)presenter;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
