//
//  SLVPlacesVC.m
//  TourApp
//
//  Created by 1 on 31.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVPlacesVC.h"
#import "SLVSegmentedController.h"

#import "SLVMainVC.h"
#import "SLVMapVC.h"
#import "SLVNodesPresenter.h"
#import "SLVPlaceCell.h"

#import "SLVNode.h"
#import "SLVInfo.h"
#import "SLVLoadingAnimation.h"

#import "UIView+SLVGradient.h"
#import "SLVGradient.h"
#import "SLVPlacesDataSource.h"


@interface SLVPlacesVC () <UITableViewDelegate>

@property (nonatomic, strong) SLVNodesPresenter *presenter;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SLVLoadingAnimation *spinner;
@property (nonatomic, strong) SLVPlacesDataSource *dataSource;

@end


@implementation SLVPlacesVC

- (instancetype)initWithPresenter:(SLVNodesPresenter *)presenter
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
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.delegate = self;
    self.dataSource = [[SLVPlacesDataSource alloc] initWithPresenter:self.presenter controller:self];
    self.tableView.dataSource = self.dataSource;
    [self.tableView registerClass:[SLVPlaceCell class] forCellReuseIdentifier:NSStringFromClass([SLVPlaceCell class])];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(65, 0, 0, 0);
    [self.view addSubview:self.tableView];
    _spinner = [[SLVLoadingAnimation alloc] initWithCenter:self.view.center];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.spinner];
    [self.spinner startAnimation];
    [self.presenter getNodesWithCompletion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self.spinner stopAnimation];
        });
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [(SLVSegmentedController *)(self.parentViewController) selectControllerWithIndex:SLVControllerIndexMap];
    
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


#pragma mark - SLVPlaceCellDelegate

- (IBAction)cellDidChangeState:(SLVPlaceCell *)cell
{
    [UIView animateWithDuration:0.5 animations:^{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    }];
}

@end
