//
//  SLVTagTableCell.m
//  TourApp
//
//  Created by Леонид Серебряный on 07/01/2018.
//  Copyright © 2018 serebryanyy. All rights reserved.
//

#import "SLVTagTableCell.h"



#import "SLVTag.h"
@import Masonry;
#import "UIColor+SLVColor.h"


@interface SLVTagTableCell ()

@property (nonatomic, strong) UILabel *label;

@end


@implementation SLVTagTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _label = [UILabel new];
        _label.font = [SLVTagTableCell labelFont];
        _label.textColor = UIColor.graySearchBackgroundColor;
        _label.layer.cornerRadius = 8;
        _label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_label];
        
        self.alpha = 1;
    }
    return self;
}

- (void)setTag:(SLVTag *)tag
{
    NSString *text = tag.name;
    self.label.text = [@"  " stringByAppendingString:text];
    self.label.layer.backgroundColor = [UIColor backgroundColorForTagWithText:text].CGColor;
}

- (void)updateConstraints
{
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.right.mas_equalTo(self).offset(-33);
        make.top.mas_equalTo(SLVStandardOffset);
        make.bottom.mas_equalTo(-SLVSmallOffset);
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

//+ (CGSize)sizeForTag:(SLVTag *)tag
//{
//    CGFloat textWidth = [tag.name sizeWithAttributes:@{NSFontAttributeName:[self labelFont]}].width;
//
//    CGFloat labelWidth =
//    textWidth > SLVMaxAllowedTagWidth ? SLVMaxAllowedTagWidth : (int)textWidth;
//
//    labelWidth = labelWidth + 2 * SLVBigOffset;
//    return CGSizeMake(labelWidth, SLVTagHeight);
//}

@end
