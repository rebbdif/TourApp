//
//  SLVPlacesDataSource.h
//  TourApp
//
//  Created by Леонид Серебряный on 12/11/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol UITableViewDataSource;
@class SLVNodesPresenter;
@protocol SLVPlaceCellDelegate;


@interface SLVPlacesDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithPresenter:(SLVNodesPresenter *)presenter controller:(id<SLVPlaceCellDelegate>)controller;

@end
