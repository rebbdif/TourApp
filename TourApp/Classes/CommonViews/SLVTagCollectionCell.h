//
//  SLVTagView.h
//  TourApp
//
//  Created by Леонид Серебряный on 03/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString * const SLVStoreSearchViewCellReuseId = @"SLVStoreSearchViewCellReuseId";


@class SLVTag;


@interface SLVTagCollectionCell : UICollectionViewCell

- (void)setTag:(SLVTag *)tag;

+ (CGSize)sizeForTag:(SLVTag *)tag;

@end
