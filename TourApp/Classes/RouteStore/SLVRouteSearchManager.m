//
//  SLVRouteSearchManager.m
//  TourApp
//
//  Created by Леонид Серебряный on 05/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import "SLVRouteSearchManager.h"
#import "SLVSearchView.h"
#import "SLVTag.h"
#import "SLVTagTableCell.h"


@interface SLVRouteSearchManager ()

@property (nonatomic, strong) NSArray<SLVTag *> *tags;

@end


@implementation SLVRouteSearchManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _tags = @[
                  [SLVTag tagWithName:@"One"],
                  [SLVTag tagWithName:@"Two"],
                  [SLVTag tagWithName:@"Three"],
                  [SLVTag tagWithName:@"Four"],
                  [SLVTag tagWithName:@"Five"],
                  ];
    }
    return self;
}


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if (searchBar.text.length > 0)
    {
      //  [self.searchView shouldShowTableView:YES];
    }
}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

// called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
}


#pragma mark - SearchTableViewDatasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLVTagTableCell *cell = [tableView dequeueReusableCellWithIdentifier:SLVStoreSearchTableCellReuseId];
    [cell setTag:self.tags[indexPath.row]];
    return cell;
}

@end
