//
//  SLVLoadingAnimation.h
//  Bolt
//
//  Created by 1 on 05.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLVLoadingAnimation : UIView

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 Инициализатор анимации загрузки

 @param center точка, являющейся центром анимации загрузки
 @return объект анимации
 */
- (instancetype)initWithCenter:(CGPoint)center;

/**
 Начинает анимировать загрузку
 */
- (void)startAnimation;

/**
 Останавливает загрузку и удаляет её с родительского view
 */
- (void)stopAnimation;

@end
