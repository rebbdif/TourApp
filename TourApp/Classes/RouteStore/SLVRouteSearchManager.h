//
//  SLVRouteSearchManager.h
//  TourApp
//
//  Created by Леонид Серебряный on 05/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;


@interface SLVRouteSearchManager : NSObject <UISearchBarDelegate>
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;   // called when cancel button pressed
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;                       // called when text ends editing
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)

@end
