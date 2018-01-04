//
//  SLVTagView.m
//  TourApp
//
//  Created by Леонид Серебряный on 03/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import "SLVTagCell.h"
#import "SLVTag.h"
@import Masonry;
#import "UIColor+SLVColor.h"


static CGFloat const SLVMaxAllowedTagWidth = 120;
static CGFloat const SLVTagHeight = 30;


@interface SLVTagCell ()

@property (nonatomic, strong) UILabel *label;

@end


@implementation SLVTagCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _label = [UILabel new];
        _label.font = [SLVTagCell labelFont];
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
    self.backgroundColor = [SLVTagCell backgroundColorForText:text];
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

+ (UIColor *)backgroundColorForText:(NSString *)text
{
    NSUInteger firstLetterASCII = [text characterAtIndex:0];
    NSUInteger hash = firstLetterASCII % 7;
    
    NSUInteger alpha = 90;
    UIColor *tagMainColor;
    switch (hash) {
        case 0:
            tagMainColor = [UIColor createColorWithRed:255 green:149 blue:0 alpha:alpha];
            break;
        case 1:
            tagMainColor = [UIColor createColorWithRed:255 green:204 blue:0 alpha:alpha];
            break;
        case 2:
            tagMainColor = [UIColor createColorWithRed:76 green:217 blue:100 alpha:alpha];
            break;
        case 3:
            tagMainColor = [UIColor createColorWithRed:90 green:200 blue:250 alpha:alpha];
            break;
        case 4:
            tagMainColor = [UIColor createColorWithRed:0 green:122 blue:255 alpha:alpha];
            break;
        case 5:
            tagMainColor = [UIColor createColorWithRed:88 green:86 blue:214 alpha:alpha];
            break;
        case 6:
            tagMainColor = [UIColor createColorWithRed:255 green:45 blue:85 alpha:alpha];
            break;
    }
    return tagMainColor;
}

@end
