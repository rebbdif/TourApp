//
//  SLVPlaceCell.h
//  TourApp
//
//  Created by 1 on 31.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLVPlaceCell;


@protocol SLVPlaceCellDelegate

- (void)cellDidChangeState:(SLVPlaceCell *)cell;

@end


@interface SLVPlaceCell : UITableViewCell

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *info;
@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UIImageView *attribute;
@property (nonatomic, assign) BOOL extended;

@property (nonatomic, weak) id<SLVPlaceCellDelegate> delegate;

@end
