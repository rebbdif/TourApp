//
//  SLVRouteCollectionViewCell.m
//  TourApp
//
//  Created by Леонид Серебряный on 16/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVRouteImageCell.h"


@implementation SLVRouteImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor.blueColor colorWithAlphaComponent:0.4];
        self.contentView.layer.cornerRadius = 8;
    }
    return self;
}

@end
