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
#import "SLVTagsSearchManager.h"
#import "UIColor+SLVColor.h"
#import "SLVSearchView.h"


@interface SLVRouteStoreVC () <UITableViewDelegate, SLVTagsViewDelegate, SLVTagsSearchDelegate>

@property (nonatomic, strong) SLVRoutesPresenter *presenter;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SLVLoadingAnimation *spinner;
@property (nonatomic, strong) SLVRoutesDataSource *dataSource;

@property (nonatomic, strong) SLVTagsView *tagsView;
@property (nonatomic, strong) SLVTagsSearchManager *tagsSearchManager;
@property (nonatomic, assign) BOOL searchInProgress;
@property (nonatomic, strong) SLVSearchView *searchView;

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
    [self createSearchView];
    [self configureNavigationBar];
    _spinner = [[SLVLoadingAnimation alloc] initWithCenter:self.view.center];
    
    _tagsView = [[SLVTagsView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    _tagsView.delegate = self;
    [_tagsView addTags:@[
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

- (void)createSearchView
{
    self.tagsSearchManager = [SLVTagsSearchManager new];
    self.tagsSearchManager.delegate = self;
    self.searchView = [[SLVSearchView alloc] initWithManager:self.tagsSearchManager];
    self.tagsSearchManager.searchView = self.searchView;
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


#pragma mark - TableView

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
    return self.tagsView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.tagsView.height;
}


#pragma mark Search

- (void)didPressSearchButton
{
    self.searchInProgress ? [self hideSearchBar] : [self addSearchBar];
}

- (void)addSearchBar
{
    [self.tableView scrollsToTop];
    self.tableView.scrollEnabled = NO;
	
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.view addSubview:self.searchView];
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    self.searchView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.searchView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;
    [self.searchView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.searchView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor].active = YES;
    [self.searchView.topAnchor constraintEqualToAnchor:margins.topAnchor constant:self.tagsView.height].active = YES;
    
    [self.searchView becomeFirstResponder];

    self.searchInProgress = YES;
}

- (void)hideSearchBar
{
    self.tableView.scrollEnabled = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.searchView removeFromSuperview];
    self.searchInProgress = NO;
}

- (void)addedTag:(SLVTag *)tag
{
    [self.tagsView addTag:tag];
}

@end
