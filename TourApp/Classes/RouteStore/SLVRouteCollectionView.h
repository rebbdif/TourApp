//
//  SLVCellCollectionView.h
//  TourApp
//
//  Created by Леонид Серебряный on 16/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SLVImage;
@class SLVRouteImageCell;


/**
 Протокол СollectionView в ячейке
 */
@protocol SLVRouteCollectionViewProtocol

- (void)didSelectCollectionViewCell:(SLVRouteImageCell *)cell;

@end


@interface SLVRouteCollectionView : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSArray<SLVImage *> *images;

@end
