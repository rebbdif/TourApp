//
//  UIColor+SLVColor.h
//  TourApp
//
//  Created by Леонид Серебряный on 08/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (SLVColor)

+ (UIColor *)downloadButtonGreen;

//приводит цвет заданный в обычном формате к эппловскому
+ (UIColor *)createColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end
