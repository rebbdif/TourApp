//
//  SLVRouteStoreCell.h
//  TourApp
//
//  Created by Леонид Серебряный on 08/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SLVRouteStoreCell : UITableViewCell

@property (nonatomic, strong) UILabel *routeName;
@property (nonatomic, strong) UILabel *routeAuthor;
@property (nonatomic, strong) UILabel *shortInfo;
@property (nonatomic, strong) UICollectionView *images;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIButton *downloadButton;

@end
