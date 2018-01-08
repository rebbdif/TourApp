//
//  SLVRouteSearchManager.m
//  TourApp
//
//  Created by Леонид Серебряный on 05/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import "SLVTagsSearchManager.h"
#import "SLVSearchView.h"
#import "SLVTag.h"
#import "SLVTagTableCell.h"


@interface SLVTagsSearchManager ()

@property (nonatomic, strong) NSArray<SLVTag *> *allTags;
@property (nonatomic, strong) NSArray<SLVTag *> *tags;

@end


@implementation SLVTagsSearchManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _allTags = @[
                  [SLVTag tagWithName:@"One"],
                  [SLVTag tagWithName:@"Two"],
                  [SLVTag tagWithName:@"Three"],
                  [SLVTag tagWithName:@"Four"],
                  [SLVTag tagWithName:@"Five"],
                  ];
        _tags = [NSArray new];
    }
    return self;
}


#pragma mark - SearchBar

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

// called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self search:searchBar.text];
    [self.searchView reloadData];
}

- (NSArray *)search:(NSString *)text
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"content BEGINSWITH[c] %@", text];
    NSArray *results = [self.allTags filteredArrayUsingPredicate:predicate];
    self.tags = results;
    return results;
}

- (void)addedTagAtIndex:(NSUInteger)tag
{
    SLVTag *addedTag = self.tags[tag];
    [self.delegate addedTag:addedTag];
    self.tags = [NSArray new];
}

- (void)searchOver
{
    [self.delegate hideSearchBar];
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
