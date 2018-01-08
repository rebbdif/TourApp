//
//  SLVSearchBar.h
//  TourApp
//
//  Created by Леонид Серебряный on 05/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SLVTagsSearchManager;

@interface SLVSearchView : UIView

- (instancetype)initWithManager:(SLVTagsSearchManager *)manager;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (void)reloadData;

@end
