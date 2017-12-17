//
//  SLVImage.m
//  TourApp
//
//  Created by Леонид Серебряный on 16/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVImage.h"


@implementation SLVImage

@dynamic url;
@dynamic thumbnailURL;
@dynamic image;
@dynamic thumbnail;

- (UIImage *)imageToShow
{
    if (!self.image)
    {
        return [UIImage imageNamed:@"eye"];
    }
    return self.image;
}

@end
