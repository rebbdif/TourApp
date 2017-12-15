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


@interface SLVRouteStoreVC () <UITableViewDelegate>

@property (nonatomic, strong) SLVRoutesPresenter *presenter;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SLVLoadingAnimation *spinner;
@property (nonatomic, strong) SLVRoutesDataSource *dataSource;

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
}

- (void)configureNavigationBar
{
    self.title = @"Магазин Маршрутов";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Фильтры" style:UIBarButtonItemStylePlain target:self action:@selector(filterButtonPressed:)];
    //TODO: backButton с русским текстом
//    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Назад" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationController.navigationItem.leftBarButtonItem = newBackButton;
}

- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.delegate = self;
    self.dataSource = [[SLVRoutesDataSource alloc] initWithPresenter:self.presenter controller:self];
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerClass:[SLVRouteStoreCell class] forCellReuseIdentifier:NSStringFromClass([SLVRouteStoreCell class])];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 10;
  //  self.tableView.contentInset = UIEdgeInsetsMake(65, 0, 0, 0);
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

#pragma mark - Actions

- (IBAction)filterButtonPressed:(id)sender
{
    NSLog(@"filter");
}



@end
