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

@interface SLVPlacesVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SLVNodesPresenter *presenter;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SLVPlacesVC

- (instancetype)initWithPresenter:(SLVNodesPresenter *)presenter {
    self = [super init];
    if (self) {
        _presenter = presenter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SLVPlaceCell class] forCellReuseIdentifier:NSStringFromClass([SLVPlaceCell class])];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 116;
    
    [self addSegmentedControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.presenter getNodesWithCompletion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.presenter numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SLVPlaceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SLVPlaceCell class])];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(SLVPlaceCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    SLVNode *currentNode = [self.presenter objectForIndex:indexPath.row];
    cell.name.text = currentNode.name;
    [cell layoutIfNeeded];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    CGRect frame = self.view.frame;
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 20)];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (void)addSegmentedControl {
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"nodes", @"map" ,@"main"]];
    segmentedControl.frame = CGRectMake(self.view.frame.size.width / 2 - 100, 25, 200, 30);
    [self.view addSubview:segmentedControl];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentedControlValueDidChange:(UISegmentedControl *)segment {
    switch (segment.selectedSegmentIndex) {
        case 0: {
            break;
        } case 1: {
            SLVMapVC *vc = [[SLVMapVC alloc] initWithPresenter:self.presenter];
            [self presentViewController:vc animated:YES completion:nil];
            break;
        } case 2: {
            SLVMainVC *mainvc = [SLVMainVC new];
            [self presentViewController:mainvc animated:YES completion:nil];
            break;
        }
    }
}

@end
