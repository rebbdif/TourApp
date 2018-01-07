//
//  SLVTagView.m
//  TourApp
//
//  Created by Леонид Серебряный on 03/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import "SLVTagCollectionCell.h"
#import "SLVTag.h"
@import Masonry;
#import "UIColor+SLVColor.h"


static CGFloat const SLVMaxAllowedTagWidth = 120;
static CGFloat const SLVTagHeight = 30;


@interface SLVTagCollectionCell ()

@property (nonatomic, strong) UILabel *label;

@end


@implementation SLVTagCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _label = [UILabel new];
        _label.font = [SLVTagCollectionCell labelFont];
        _label.textColor = UIColor.whiteColor;
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];

        self.alpha = 1;
        self.layer.cornerRadius = 8;
    }
    return self;
}

- (void)setLabelText:(NSString *)text
{
    _label.text = text;
    self.backgroundColor = [UIColor backgroundColorForTagWithText:text];
}

- (void)setTag:(SLVTag *)tag
{
    [self setLabelText:tag.name];
}

- (void)updateConstraints
{
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(SLVStandardOffset);
        make.right.mas_equalTo(self).offset(-SLVStandardOffset);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

+ (UIFont *)labelFont
{
    return [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
}

+ (CGSize)sizeForTag:(SLVTag *)tag
{
    CGFloat textWidth = [tag.name sizeWithAttributes:@{NSFontAttributeName:[self labelFont]}].width;
    
    CGFloat labelWidth =
    textWidth > SLVMaxAllowedTagWidth ? SLVMaxAllowedTagWidth : (int)textWidth;
    
    labelWidth = labelWidth + 2 * SLVBigOffset;
    return CGSizeMake(labelWidth, SLVTagHeight);
}


@end
