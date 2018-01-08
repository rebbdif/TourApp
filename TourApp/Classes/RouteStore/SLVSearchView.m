//
//  SLVSearchBar.m
//  TourApp
//
//  Created by Леонид Серебряный on 05/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import "SLVSearchView.h"
#import "UIColor+SLVColor.h"
#import "SLVTagsSearchManager.h"
#import "SLVTagTableCell.h"


static CGFloat const SLVSearchResultTableViewRowHeight = 44;


@interface SLVSearchView () <UITableViewDelegate>

@property (nonatomic, weak) SLVTagsSearchManager *searchManager;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *stopSearchButton;
@property (nonatomic, strong) UITableView *resultsTableView;

@property (nonatomic, strong) NSMutableArray <NSLayoutConstraint *> *constraintsToChange;

@end


@implementation SLVSearchView

- (instancetype)initWithManager:(SLVTagsSearchManager *)manager
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        _searchManager = manager;
        _constraintsToChange = [NSMutableArray new];
        [self createSearchBar];
        [self addResultsTableView];
    }
    return self;
}

- (void)createSearchBar
{
    self.backgroundColor = [UIColor graySearchBackgroundColor];

    UISearchBar *searchBar = [UISearchBar new];
    searchBar.barTintColor = [UIColor graySearchBackgroundColor];
    searchBar.barStyle = UISearchBarStyleDefault;
    searchBar.layer.borderColor = [UIColor graySearchBackgroundColor].CGColor;
    searchBar.layer.borderWidth = 1;
    searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    searchBar.layer.zPosition = FLT_MAX;
    searchBar.delegate = self.searchManager;
    self.searchBar = searchBar;
    [self addSubview:self.searchBar];
   
    self.stopSearchButton = [UIButton new];
    [self.stopSearchButton setTitle:@"Готово" forState:UIControlStateNormal];
    [self.stopSearchButton setTintColor:UIColor.whiteColor];
    [self.stopSearchButton setBackgroundColor:UIColor.blueSearchColor];
    [self.stopSearchButton addTarget:self action:@selector(hideSearchBar) forControlEvents:UIControlEventTouchUpInside];
    self.stopSearchButton.layer.cornerRadius = 8;
    [self addSubview:self.stopSearchButton];
}

- (BOOL)becomeFirstResponder
{
    return [self.searchBar becomeFirstResponder];
}

- (void)updateConstraints
{
    [NSLayoutConstraint deactivateConstraints:[self.constraintsToChange copy]];
    
    UILayoutGuide *margins = self.layoutMarginsGuide;

    self.stopSearchButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.stopSearchButton.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor constant:-240].active = YES;
    [self.stopSearchButton.heightAnchor constraintEqualToConstant:50].active = YES;
    [self.stopSearchButton.widthAnchor constraintEqualToConstant:100].active = YES;
    [self.stopSearchButton.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor constant:-SLVStandardOffset].active = YES;
    
    [self.searchBar.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor constant:SLVStandardOffset].active = YES;
    [self.searchBar.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor constant:-SLVStandardOffset].active = YES;
    [self.searchBar.topAnchor constraintEqualToAnchor:margins.topAnchor constant:100].active = YES;
    [self.searchBar.heightAnchor constraintEqualToConstant:44].active = YES;
    
    [self.resultsTableView.topAnchor constraintEqualToAnchor:self.searchBar.bottomAnchor].active = YES;
    [self.resultsTableView.leadingAnchor constraintEqualToAnchor:self.searchBar.leadingAnchor constant:SLVBigOffset].active = YES;
    [self.resultsTableView.trailingAnchor constraintEqualToAnchor:self.searchBar.trailingAnchor constant:- SLVBigOffset].active = YES;
    NSLayoutConstraint *heightConstraint = [self.resultsTableView.heightAnchor constraintEqualToConstant:[self heightForTableView]];
    heightConstraint.active = YES;
    [self.constraintsToChange addObject:heightConstraint];
    
    [super updateConstraints];
}

- (void)addResultsTableView
{
    self.resultsTableView = [UITableView new];
    self.resultsTableView.delegate = self;
    self.resultsTableView.dataSource = self.searchManager;
    self.resultsTableView.rowHeight = SLVSearchResultTableViewRowHeight;
    self.resultsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 1)];
    self.resultsTableView.layer.borderColor = [UIColor createColorWithRed:151 green:151 blue:151 alpha:50].CGColor;
    self.resultsTableView.layer.borderWidth = 1;
    self.resultsTableView.layer.cornerRadius = 4;
    [self addSubview:self.resultsTableView];
    self.resultsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.resultsTableView registerClass:[SLVTagTableCell class] forCellReuseIdentifier:SLVStoreSearchTableCellReuseId];
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)hideSearchBar
{
    [self.searchManager searchOver];
    self.searchBar.text = nil;
}

- (void)reloadData
{
    [self.resultsTableView reloadData];
    [self setNeedsUpdateConstraints];
}

- (CGFloat)heightForTableView
{
    NSUInteger numberOfRows = [self.searchManager tableView:self.resultsTableView numberOfRowsInSection:0];
    return numberOfRows * SLVSearchResultTableViewRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchManager addedTagAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.searchBar.text = nil;
    [self reloadData];
}

@end
