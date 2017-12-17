//
//  SLVCellCollectionView.m
//  TourApp
//
//  Created by Леонид Серебряный on 16/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVRouteCollectionView.h"
#import "SLVImage.h"
#import "SLVRouteImageCell.h"


NSString * const SLVCollectionViewCellReuseId = @"SLVCollectionViewCellReuseId";


@implementation SLVRouteCollectionView

- (instancetype)init
{
    UICollectionViewLayout *layout = [self setupLayout];
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self)
    {
        _images = [NSArray new];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[SLVRouteImageCell class] forCellWithReuseIdentifier:SLVCollectionViewCellReuseId];
    }
    return self;
}

- (UICollectionViewFlowLayout *)setupLayout
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return layout;
}

#pragma mark - UICollectionView Delegate and DataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SLVImage *currentImage = self.images[indexPath.item];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:currentImage.imageToShow];
    UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"SLVCollectionViewCellReuseId" forIndexPath:indexPath];
    [cell.contentView addSubview:imageView];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//- (void)collectionView:(UICollectionView *)collectionView prefetchItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
//{
//
//}
//- (void)collectionView:(UICollectionView *)collectionView cancelPrefetchingForItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths
//{
//
//}


#pragma mark - UICollectionViewDelegateFlowLayout

static CGFloat const insetBetweenCells = 12.0;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth = 105;
    CGFloat cellHeight = CGRectGetHeight(self.frame);
    return CGSizeMake(cellWidth, cellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, insetBetweenCells / 2, 0, insetBetweenCells / 2);
    return insets;
}

@end
