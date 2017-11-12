//
//  SLVPlacesDataSource.m
//  TourApp
//
//  Created by Леонид Серебряный on 12/11/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVPlacesDataSource.h"
#import "SLVPlacesVC.h"
@import UIKit;
#import "SLVNodesPresenter.h"
#import "SLVLoadingAnimation.h"
#import "SLVPlaceCell.h"
#import "SLVNode.h"
#import "SLVInfo.h"


@interface SLVPlacesDataSource ()

@property (nonatomic, weak) SLVNodesPresenter *presenter;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) SLVLoadingAnimation *spinner;
@property (nonatomic, weak) id<SLVPlaceCellDelegate> controller;

@end


@implementation SLVPlacesDataSource

- (instancetype)initWithPresenter:(SLVNodesPresenter *)presenter controller:(id<SLVPlaceCellDelegate>)controller
{
    self = [super init];
    if (self)
    {
        _presenter = presenter;
        _controller = controller;
    }
    return self;
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
    cell.delegate = self.controller;
    cell.name.text = currentNode.name;
    cell.info.text = currentNode.info.text;
    cell.thumbnail.image = currentNode.thumbnail ?: [UIImage imageNamed:@"city2"];
}

@end
