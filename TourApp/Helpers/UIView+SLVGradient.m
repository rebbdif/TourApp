//
//  UIView+SLVGradient.m
//  TourApp
//
//  Created by Леонид Серебряный on 11/11/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "UIView+SLVGradient.h"
#import "SLVGradient.h"


@implementation UIView (SLVGradient)

- (void)addGradient:(CAGradientLayer *)gradient
{
    gradient.frame = self.frame;
    [self.layer addSublayer:gradient];
}

@end
