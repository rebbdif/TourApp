//
//  UIColor+SLVColor.m
//  TourApp
//
//  Created by Леонид Серебряный on 08/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "UIColor+SLVColor.h"


@implementation UIColor (SLVColor)

+ (UIColor *)downloadButtonGreen
{
    return [self createColorWithRed:128 green:214 blue:30 alpha:100];
}


//приводит цвет заданный в обычном формате к эппловскому
+ (UIColor *)createColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/100.0];
}
@end
