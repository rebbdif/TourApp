//
//  SLVRouteStoreViewController.m
//  TourApp
//
//  Created by Леонид Серебряный on 01/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVRouteStoreVC.h"
#import "SLVRoutesPresenter.h"
#import "SLVLoadingAnimation.h"
#import "UIView+SLVGradient.h"
#import "SLVGradient.h"
#import "SLVRoutesDataSource.h"
#import "SLVRouteStoreCell.h"
#import "SLVTagsView.h"
#import "SLVTag.h"
#import "SLVRouteSearchManager.h"


@interface SLVRouteStoreVC () <UITableViewDelegate, SLVTagsViewDelegate>

@property (nonatomic, strong) SLVRoutesPresenter *presenter;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SLVLoadingAnimation *spinner;
@property (nonatomic, strong) SLVRoutesDataSource *dataSource;

@property (nonatomic, assign, getter=isSearchModeEnabled) BOOL searchModeEnabled;
@property (nonatomic, strong) SLVTagsView *searchView;
@property (nonatomic, strong) SLVRouteSearchManager *searchManager;

@end


@implementation SLVRouteStoreVC

- (instancetype)initWithPresenter:(SLVRoutesPresenter *)presenter
{
    self = [super init];
    if (self)
    {
        _presenter = presenter;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGradient:[SLVGradient basicGradient]];
    [self createTableView];
    [self configureNavigationBar];
    _spinner = [[SLVLoadingAnimation alloc] initWithCenter:self.view.center];
    
    _searchView = [[SLVTagsView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    _searchView.delegate = self;
    [_searchView addTags:@[
                           [SLVTag tagWithName:@"Moscow"],
                           [SLVTag tagWithName:@"Interesting"],
                           [SLVTag tagWithName:@"Удивительное"],
                           [SLVTag tagWithName:@"Космос"],
                           ]];
}

- (void)configureNavigationBar
{
    self.title = @"Магазин Маршрутов";
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = YES;
    }
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.delegate = self;
    self.dataSource = [[SLVRoutesDataSource alloc] initWithPresenter:self.presenter controller:self];
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerClass:[SLVRouteStoreCell class] forCellReuseIdentifier:NSStringFromClass([SLVRouteStoreCell class])];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 10;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view addSubview:self.spinner];
    [self.spinner startAnimation];
    [self.presenter downloadRoutesWithCompletion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.spinner stopAnimation];
        });
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.searchView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.searchView.height;
}


#pragma mark - Actions

- (IBAction)filterButtonPressed:(id)sender
{
    self.searchModeEnabled = !self.searchModeEnabled;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}


#pragma mark SLVTagsViewDelegate

- (void)didPressSearchButton
{
    [self addSearchBar];
}

- (void)addSearchBar
{
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.barTintColor = UIColor.whiteColor;
    searchBar.barStyle = UISearchBarStyleProminent;
    searchBar.translucent = NO;
    searchBar.layer.borderColor = UIColor.blackColor.CGColor;
    searchBar.layer.borderWidth = 1;
    [self.view addSubview:searchBar];
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    [searchBar.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor constant:SLVStandardOffset].active = YES;
    [searchBar.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor constant:-SLVStandardOffset].active = YES;
    [searchBar.topAnchor constraintEqualToAnchor:margins.topAnchor constant:150].active = YES;
    [searchBar.heightAnchor constraintEqualToConstant:40].active = YES;
    
    self.searchManager = [SLVRouteSearchManager new];
    searchBar.delegate = self.searchManager;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}

@end
