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
        _state = SLVCellStateNormal;
        self.backgroundColor = UIColor.whiteColor;
        
        _name = [UILabel new];
        [self.contentView addSubview:_name];
        
        _info = [UILabel new];
        _info.backgroundColor = UIColor.redColor;
        _info.numberOfLines = 0;
        _info.adjustsFontSizeToFitWidth = NO;
        _info.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_info];
        
        _thumbnail = [UIImageView new];
        _thumbnail.backgroundColor = UIColor.redColor;
        _thumbnail.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_thumbnail];
        
        _attribute = [UIImageView new];
        _attribute.backgroundColor = UIColor.greenColor;
        _attribute.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAttribute:)];
        [singleTap setNumberOfTapsRequired:1];
        [_attribute addGestureRecognizer:singleTap];
        [self.contentView addSubview:_attribute];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)updateConstraints
{
    UIView *contentView = self.contentView;
    [self.thumbnail mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).with.offset(SLVStandardOffset);
        make.left.equalTo(contentView.mas_left).with.offset(SLVStandardOffset);
        make.size.equalTo(@(SLVCellThumbnailHeight));
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).with.offset(-SLVStandardOffset);
    }];
    [self.name mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).with.offset(SLVStandardOffset);
        make.left.equalTo(self.thumbnail.mas_right).with.offset(SLVBigOffset);
        make.right.equalTo(contentView.mas_right).with.offset(SLVStandardOffset);
    }];
    [self.attribute mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(SLVCellAttributeSize);
        make.centerY.equalTo(self.thumbnail.mas_centerY);
        make.right.equalTo(contentView.mas_right).with.offset(-8);
    }];
    [self.info mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).with.offset(SLVBigOffset);
        make.left.equalTo(self.thumbnail.mas_right).with.offset(SLVBigOffset);
        make.right.equalTo(self.attribute.mas_left).with.offset(-SLVStandardOffset);
        make.bottom.equalTo(contentView.mas_bottom).with.offset(-SLVStandardOffset);
    }];
    [super updateConstraints];
}

- (IBAction)didTapAttribute:(id)sender
{
    self.info.textColor = UIColor.blueColor;
}

@end
