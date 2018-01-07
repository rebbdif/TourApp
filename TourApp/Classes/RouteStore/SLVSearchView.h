//
//  SLVSearchBar.h
//  TourApp
//
//  Created by Леонид Серебряный on 05/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SLVRouteSearchManager;


@protocol SLVSearchViewDelegate

- (void)hideSearchBar;

@end


@interface SLVSearchView : UIView

@property (nonatomic, weak) id<SLVSearchViewDelegate> delegate;

- (instancetype)initWithManager:(SLVRouteSearchManager *)manager;

@end
