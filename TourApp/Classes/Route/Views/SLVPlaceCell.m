//
//  SLVPlaceCell.m
//  TourApp
//
//  Created by 1 on 31.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVPlaceCell.h"
@import Masonry;

@implementation SLVPlaceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _name = [UILabel new];
        _info = [UILabel new];
        _thumbnail = [UIImageView new];
        _attribute = [UIImageView new];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    UIView *contentView = self.contentView;
    [self.thumbnail mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).with.offset(8);
        make.left.equalTo(contentView.mas_left).with.offset(8);
        make.size.equalTo(@100);
    }];
    [self.name mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).with.offset(8);
        make.left.equalTo(self.thumbnail.mas_right).with.offset(18);
        make.right.equalTo(contentView.mas_right).with.offset(41);
    }];
    [self.name mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name).with.offset(17);
        make.left.equalTo(self.thumbnail.mas_right).with.offset(19);
        make.right.equalTo(contentView.mas_right).with.offset(40);
    }];
    [super updateConstraints];
}

@end
