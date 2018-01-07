//
//  SLVSearchBar.m
//  TourApp
//
//  Created by Леонид Серебряный on 05/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import "SLVSearchView.h"
#import "UIColor+SLVColor.h"
#import "SLVRouteSearchManager.h"
#import "SLVTagTableCell.h"



@interface SLVSearchView () <UITableViewDelegate>

@property (nonatomic, weak) SLVRouteSearchManager *searchManager;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *stopSearchButton;
@property (nonatomic, strong) UITableView *resultsTableView;


@end


@implementation SLVSearchView

- (instancetype)initWithManager:(SLVRouteSearchManager *)manager
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        _searchManager = manager;
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
    searchBar.layer.zPosition = CGFLOAT_MAX;
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
    [self.resultsTableView.heightAnchor constraintEqualToConstant:100].active = YES;
    
    [super updateConstraints];
}

- (void)addResultsTableView
{
    self.resultsTableView = [UITableView new];
    self.resultsTableView.delegate = self;
    self.resultsTableView.dataSource = self.searchManager;
    self.resultsTableView.rowHeight = 44;
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
    [self.delegate hideSearchBar];
}

@end
