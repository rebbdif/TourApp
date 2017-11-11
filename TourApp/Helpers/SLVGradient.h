//
//  SLVGradient.h
//  TourApp
//
//  Created by Леонид Серебряный on 11/11/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CAGradientLayer;
@class UIColor;


@interface SLVGradient : NSObject

+ (CAGradientLayer *)gradientWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor;

+ (CAGradientLayer *)basicGradient;

@end
