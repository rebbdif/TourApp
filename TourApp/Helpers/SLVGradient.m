//
//  SLVGradient.m
//  TourApp
//
//  Created by Леонид Серебряный on 11/11/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVGradient.h"
#import <QuartzCore/CAGradientLayer.h>
#import <UIKit/UIColor.h>


@implementation SLVGradient

+ (CAGradientLayer *)gradientWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor
{
    CAGradientLayer *gradientMask = [CAGradientLayer layer];
    gradientMask.colors = @[(id)[UIColor whiteColor].CGColor,
                            (id)[UIColor blueColor].CGColor];
    return gradientMask;
}

+ (CAGradientLayer *)basicGradient
{
    return [SLVGradient gradientWithTopColor:UIColor.blueColor bottomColor:UIColor.lightGrayColor];
}
@end
