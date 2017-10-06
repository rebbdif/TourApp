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
        [self addSubview:_name];
        _info = [UILabel new];
        [self addSubview:_info];
        _thumbnail = [UIImageView new];
         [self addSubview:_thumbnail];
        _attribute = [UIImageView new];
         [self addSubview:_attribute];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    UIView *contentView = self.contentView;
    [self.thumbnail mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).with.offset(SLVStandardOffset);
        make.left.equalTo(contentView.mas_left).with.offset(SLVStandardOffset);
        make.size.equalTo(@(SLVCellThumbnailHeight));
    }];
    [self.name mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).with.offset(SLVStandardOffset);
        make.left.equalTo(self.thumbnail.mas_right).with.offset(SLVBigOffset);
        make.right.equalTo(contentView.mas_right).with.offset(SLVStandardOffset);
    }];
    [self.attribute mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(@(SLVCellAttributeSize));
        make.centerY.equalTo(self.thumbnail.mas_centerY);
        make.left.equalTo(contentView.mas_left).with.offset(SLVStandardOffset);
    }];
    [self.info mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).with.offset(SLVBigOffset);
        make.left.equalTo(self.thumbnail.mas_right).with.offset(SLVBigOffset);
        make.right.equalTo(self.attribute.mas_left).with.offset(-SLVStandardOffset);
    }];
    [super updateConstraints];
}

@end
