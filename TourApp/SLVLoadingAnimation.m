//
//  SLVLoadingAnimation.m
//  Bolt
//
//  Created by 1 on 05.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVLoadingAnimation.h"

@interface SLVLoadingAnimation()

@property (nonatomic, strong) UIImageView *earthImageView;
@property (nonatomic, strong) UIImageView *planeImageView;
@property (nonatomic, strong) UIImageView *pizzaImageView;

@end

@implementation SLVLoadingAnimation

- (instancetype)initWithCenter:(CGPoint)center {
    CGRect frame = CGRectMake(0, 0, 304, 304);
    self = [super initWithFrame:frame];
    if (self) {
        self.center = center;
        [self configure];
    }
    return self;
}

- (void)configure {
    CGRect frame = self.frame;
    CGPoint center = CGPointMake(CGRectGetWidth(frame) / 2, CGRectGetHeight(frame) / 2);
    
    UIImage *planet = [UIImage imageNamed:@"SLVPlanet"];
    _earthImageView = [[UIImageView alloc] initWithImage:planet];
    _earthImageView.center = center;
    [self addSubview:_earthImageView];
    
    UIImage *plane = [UIImage imageNamed:@"SLVPlane"];
    _planeImageView = [[UIImageView alloc] initWithImage:plane];
    _planeImageView.center = center;
    [self addSubview:_planeImageView];
}

- (void)startAnimation {
    CGRect boundingRect = CGRectMake(-55, -55, 110, 110);
    
    CAKeyframeAnimation *orbit = [CAKeyframeAnimation animation];
    orbit.keyPath = @"position";
    orbit.path = CFAutorelease(CGPathCreateWithEllipseInRect(boundingRect, NULL));
    orbit.duration = 4;
    orbit.additive = YES;
    orbit.repeatCount = HUGE_VALF;
    orbit.calculationMode = kCAAnimationPaced;
    orbit.rotationMode = kCAAnimationRotateAuto;
    
    [_planeImageView.layer addAnimation:orbit forKey:@"orbit"];
}

- (void)stopAnimation {
    [_planeImageView.layer removeAnimationForKey:@"orbit"];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.layer.opacity = 0;
    }];
    [self removeFromSuperview];
}

@end
