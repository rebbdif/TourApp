//
//  SLVRouteSearchView.h
//  TourApp
//
//  Created by Леонид Серебряный on 17/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SLVTag;


/**
 Делегат вьюхи, отвечающей за отображение выбранных тэгов
 */
@protocol SLVTagsViewDelegate
- (void)didPressSearchButton; // показать/скрыть окно поиска
@end


/**
 Вьюха, которая отвечает за отображение выбранных тэгов и мб поиск
 */
@interface SLVTagsView : UIView

@property (nonatomic, weak) id<SLVTagsViewDelegate> delegate;

@property (nonatomic, assign) CGFloat height;

- (void)addTags:(NSArray<SLVTag *> *)tags;
- (void)addTag:(SLVTag *)tag;

@end
