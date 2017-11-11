//
//  SLVPlaceCell.h
//  TourApp
//
//  Created by 1 on 31.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 @brief состояние ячейки

 - SLVCellStateNormal: нормальное
 - SLVCellStateExtended: расширенное, чтобы весь текст из описания помещался
 */
typedef NS_ENUM(NSUInteger, SLVCellState) {
    SLVCellStateNormal,
    SLVCellStateExtended,
};


@interface SLVPlaceCell : UITableViewCell

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *info;
@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UIImageView *attribute;
@property (nonatomic, assign) SLVCellState state;

/**
 Тапнули на стрелочку справа

 @param sender ага
 */
- (IBAction)didTapAttribute:(id)sender;

@end
