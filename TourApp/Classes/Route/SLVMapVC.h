//
//  MapVC.h
//  tourapp3
//
//  Created by 1 on 05.04.17.
//  Copyright © 2017 group1. All rights reserved.
//

@import UIKit;

@class SLVNodesPresenter;

@interface SLVMapVC : UIViewController

- (instancetype)initWithPresenter:(SLVNodesPresenter *)presenter;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
