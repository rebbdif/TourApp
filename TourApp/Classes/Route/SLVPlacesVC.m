//
//  SLVPlacesVC.m
//  TourApp
//
//  Created by 1 on 31.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVPlacesVC.h"
#import "SLVMainVC.h"
#import "SLVMapVC.h"
#import "SLVNodesPresenter.h"
#import "SLVPlaceCell.h"

#import "SLVNode.h"
#import "SLVInfo.h"
#import "SLVLoadingAnimation.h"

#import "UIView+SLVGradient.h"
#import "SLVGradient.h"


@interface SLVPlacesVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SLVNodesPresenter *presenter;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SLVLoadingAnimation *spinner;


@end

@implementation SLVPlacesVC

- (instancetype)initWithPresenter:(SLVNodesPresenter *)presenter
{
    self = [super init];
    if (self) {
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
    self.tableView.dataSource = self;
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

#pragma Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger numberOfObjects = [self.presenter numberOfObjects];
    return numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLVPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SLVPlaceCell class])];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(SLVPlaceCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    SLVNode *currentNode = [self.presenter objectForIndex:indexPath.row];
    cell.name.text = currentNode.name;
    cell.info.text = currentNode.info.text;
    cell.thumbnail.image = currentNode.thumbnail ?: [UIImage imageNamed:@"eye"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect frame = self.view.frame;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 20)];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}



@end
