//
//  SLVTagTableCell.h
//  TourApp
//
//  Created by Леонид Серебряный on 07/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SLVTag;


static NSString * const SLVStoreSearchTableCellReuseId = @"SLVStoreSearchViewCellReuseId";


@interface SLVTagTableCell : UITableViewCell

- (void)setTag:(SLVTag *)tag;

//+ (CGSize)sizeForTag:(SLVTag *)tag;

@end
