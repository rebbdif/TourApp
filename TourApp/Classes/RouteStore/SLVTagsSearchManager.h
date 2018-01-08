//
//  SLVRouteSearchManager.h
//  TourApp
//
//  Created by Леонид Серебряный on 05/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


@class SLVSearchView;
@class SLVTag;


@protocol SLVTagsSearchDelegate

- (void)hideSearchBar;
- (void)addedTag:(SLVTag *)tag;

@end


@interface SLVTagsSearchManager : NSObject <UISearchBarDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<SLVTagsSearchDelegate> delegate;
@property (nonatomic, weak) SLVSearchView *searchView;

- (void)searchOver;
- (void)addedTagAtIndex:(NSUInteger)index;

@end
