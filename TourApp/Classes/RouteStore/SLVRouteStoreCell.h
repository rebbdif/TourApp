//
//  SLVRouteStoreCell.h
//  TourApp
//
//  Created by Леонид Серебряный on 08/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SLVRouteCollectionView;
@class SLVImage;


@interface SLVRouteStoreCell : UITableViewCell

@property (nonatomic, strong) UILabel *routeName;
@property (nonatomic, strong) UILabel *routeAuthor;
@property (nonatomic, strong) UILabel *shortInfo;
@property (nonatomic, strong) SLVRouteCollectionView *collectionView;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIButton *downloadButton;

- (void)setImagesForCollectionView:(NSArray<SLVImage *> *)images;

@end
