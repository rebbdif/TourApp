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
        self.backgroundColor = UIColor.whiteColor;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _name = [UILabel new];
        _name.font = [UIFont monospacedDigitSystemFontOfSize:25 weight:UIFontWeightRegular];
        _name.textAlignment = NSTextAlignmentNatural;
        _name.numberOfLines = 2;
        [self.contentView addSubview:_name];
        
        _info = [UILabel new];
        _info.numberOfLines = 0;
        _info.font = [UIFont monospacedDigitSystemFontOfSize:18 weight:UIFontWeightRegular];
        _info.adjustsFontSizeToFitWidth = NO;
        _info.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_info];
        
        _thumbnail = [UIImageView new];
        _thumbnail.backgroundColor = UIColor.redColor;
        _thumbnail.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnail.layer.cornerRadius = SLVCellThumbnailHeight / 2;
        _thumbnail.layer.masksToBounds = YES;
        [self.contentView addSubview:_thumbnail];
        
        _attribute = [UIImageView new];
        _attribute.backgroundColor = UIColor.greenColor;
        _attribute.userInteractionEnabled = YES;
        _attribute.image = [UIImage imageNamed:@"arrow"];
        _attribute.layer.cornerRadius = SLVCellAttributeSize / 2;
        _thumbnail.layer.masksToBounds = YES;

        UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAttribute:)];
        [singleTap setNumberOfTapsRequired:1];
        [_attribute addGestureRecognizer:singleTap];
        [self.contentView addSubview:_attribute];
    }
    return self;
}

- (void)updateConstraints
{
    UIView *contentView = self.contentView;
    [self.thumbnail mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).with.offset(SLVBigOffset);
        make.left.equalTo(contentView.mas_left).with.offset(SLVStandardOffset);
        make.size.equalTo(@(SLVCellThumbnailHeight));
        make.bottom.lessThanOrEqualTo(self.contentView.mas_bottom).with.offset(-SLVStandardOffset);
    }];
    [self.name mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top).with.offset(SLVStandardOffset);
        make.left.equalTo(self.thumbnail.mas_right).with.offset(SLVBigOffset + SLVSmallOffset);
        make.right.equalTo(contentView.mas_right).with.offset(SLVStandardOffset);
    }];
    [self.attribute mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(SLVCellAttributeSize);
        make.centerY.equalTo(self.thumbnail.mas_centerY);
        make.right.equalTo(contentView.mas_right).with.offset(-8);
    }];
    
    self.extended ? [self updateConstraintsForStateExtended] : [self updateConstraintsForStateNormal];
    
    [self shouldShowAttribute];
    
    [super updateConstraints];
}

- (void)updateConstraintsForStateNormal
{
    UIView *contentView = self.contentView;
    [self.info mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).with.offset(SLVBigOffset).priorityMedium();
        make.left.equalTo(self.thumbnail.mas_right).with.offset(SLVBigOffset);
        make.right.equalTo(self.attribute.mas_left).with.offset(-SLVStandardOffset);
        make.bottom.equalTo(contentView.mas_bottom).with.offset(-SLVStandardOffset).priorityLow();
        make.height.mas_equalTo(SLVCellInfoHeight);
    }];
    [self.name mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SLVCellTitleHeight);
    }];
}

- (void)updateConstraintsForStateExtended
{
    UIView *contentView = self.contentView;
    [self.info mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).with.offset(SLVBigOffset);
        make.left.equalTo(self.thumbnail.mas_right).with.offset(SLVBigOffset);
        make.right.equalTo(self.attribute.mas_left).with.offset(- SLVStandardOffset);
        make.bottom.equalTo(contentView.mas_bottom).with.offset(- SLVStandardOffset);
    }];
    [self.name mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_greaterThanOrEqualTo(SLVCellTitleHeight);
    }];
}

- (void)shouldShowAttribute
{
    CGSize maxSize = CGSizeMake(self.contentView.frame.size.width - SLVCellThumbnailHeight - SLVBigOffset, CGFLOAT_MAX);
    CGRect labelRect = [self.info.text boundingRectWithSize:maxSize
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{ NSFontAttributeName : self.info.font}
                                                    context:nil];
    CGFloat infoLabelHeights = CGRectGetHeight(labelRect);
    if (infoLabelHeights < SLVCellInfoHeight)
    {
        self.attribute.hidden = YES;
    }
}

- (IBAction)didTapAttribute:(id)sender
{
    self.extended = !self.extended;
    [self updateConstraints];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self turnAttribute];
                         [self emphasizeCell];
                     }];
    [self.delegate cellDidChangeState:self];
}

- (void)turnAttribute
{
    if (self.extended)
    {
        self.attribute.backgroundColor = UIColor.blueColor;
        self.attribute.transform = CGAffineTransformMakeRotation(M_PI_2);

    }
    else
    {
        self.attribute.backgroundColor = UIColor.greenColor;
        self.attribute.transform = CGAffineTransformMakeRotation(0);
    }
}

- (void)emphasizeCell
{
    if (self.extended)
    {
        self.name.font = [UIFont monospacedDigitSystemFontOfSize:25 weight:UIFontWeightBold];
        self.name.numberOfLines = 0;
        self.info.font = [UIFont monospacedDigitSystemFontOfSize:19 weight:UIFontWeightRegular];
        self.thumbnail.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }
    else
    {
        self.name.font = [UIFont monospacedDigitSystemFontOfSize:25 weight:UIFontWeightRegular];
        self.name.numberOfLines = 2;
        self.info.font = [UIFont monospacedDigitSystemFontOfSize:18 weight:UIFontWeightRegular];
        self.thumbnail.transform = CGAffineTransformIdentity;
    }
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

@end
