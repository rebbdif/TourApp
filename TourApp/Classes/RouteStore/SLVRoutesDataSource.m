//
//  SLVRoutesDataSource.m
//  TourApp
//
//  Created by Леонид Серебряный on 02/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVRoutesDataSource.h"
#import "SLVPlacesVC.h"
@import UIKit;
#import "SLVRoutesPresenter.h"
#import "SLVLoadingAnimation.h"
#import "SLVRouteStoreCell.h"
#import "SLVRoute.h"
#import "SLVInfo.h"


@interface SLVRoutesDataSource ()

@property (nonatomic, weak) SLVRoutesPresenter *presenter;
@property (nonatomic, weak) SLVLoadingAnimation *spinner;
@property (nonatomic, weak) id<SLVPlaceCellDelegate> controller;

@end


@implementation SLVRoutesDataSource

- (instancetype)initWithPresenter:(SLVRoutesPresenter *)presenter controller:(id<SLVPlaceCellDelegate>)controller
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
    return 0;
    NSUInteger numberOfObjects = [self.presenter numberOfObjects];
    return numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SLVRouteStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SLVRouteStoreCell class])];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(SLVRouteStoreCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    SLVRoute *route = [self.presenter objectForIndex:indexPath.row];
    
    cell.routeName.text = route.name ?: @"Без названия";
    cell.routeAuthor.text = route.author ?: @"Без автора";
    cell.shortInfo.text = route.shortInfo;
    [cell setImagesForCollectionView:route.images.allObjects];
}

@end
