//
//  SLVRoutesDataSource.h
//  TourApp
//
//  Created by Леонид Серебряный on 02/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol UITableViewDataSource;
@class SLVRoutesPresenter;
@protocol SLVPlaceCellDelegate;


@interface SLVRoutesDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithPresenter:(SLVRoutesPresenter *)presenter controller:(id<SLVPlaceCellDelegate>)controller;

@end
