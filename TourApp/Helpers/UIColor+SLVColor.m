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

+ (UIColor *)blueSearchColor
{
    return [self createColorWithRed:0 green:118 blue:255 alpha:100];
}

+ (UIColor *)graySearchBackgroundColor
{
    return [UIColor createColorWithRed:236 green:236 blue:236 alpha:100];
}

//приводит цвет заданный в обычном формате к эппловскому
+ (UIColor *)createColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/100.0];
}

+ (UIColor *)backgroundColorForTagWithText:(NSString *)text
{
    NSUInteger firstLetterASCII = [text characterAtIndex:0];
    NSUInteger hash = firstLetterASCII % 7;
    
    NSUInteger alpha = 90;
    UIColor *tagMainColor;
    switch (hash) {
        case 0:
            tagMainColor = [UIColor createColorWithRed:255 green:149 blue:0 alpha:alpha];
            break;
        case 1:
            tagMainColor = [UIColor createColorWithRed:255 green:204 blue:0 alpha:alpha];
            break;
        case 2:
            tagMainColor = [UIColor createColorWithRed:76 green:217 blue:100 alpha:alpha];
            break;
        case 3:
            tagMainColor = [UIColor createColorWithRed:90 green:200 blue:250 alpha:alpha];
            break;
        case 4:
            tagMainColor = [UIColor createColorWithRed:0 green:122 blue:255 alpha:alpha];
            break;
        case 5:
            tagMainColor = [UIColor createColorWithRed:88 green:86 blue:214 alpha:alpha];
            break;
        case 6:
            tagMainColor = [UIColor createColorWithRed:255 green:45 blue:85 alpha:alpha];
            break;
    }
    return tagMainColor;
}

@end
