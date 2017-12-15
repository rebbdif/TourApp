//
//  SLVRouteStoreCell.m
//  TourApp
//
//  Created by Леонид Серебряный on 08/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVRouteStoreCell.h"
#import "UIColor+SLVColor.h"

@import Masonry;


@implementation SLVRouteStoreCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _routeName = [UILabel new];
        _routeName.numberOfLines = 2;
        _routeName.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightBold];
        [self.contentView addSubview:_routeName];
        
        _routeAuthor = [UILabel new];
        _routeAuthor.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightLight];
        _routeAuthor.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_routeAuthor];

        _shortInfo = [UILabel new];
        _shortInfo.numberOfLines = 0;
        _shortInfo.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightLight];
        _shortInfo.textAlignment = NSTextAlignmentNatural;
        [self.contentView addSubview:_shortInfo];
        
        UICollectionViewLayout *layout = [UICollectionViewFlowLayout new];
        _images = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.contentView addSubview:_images];

        _moreButton = [UIButton new];
        [_moreButton addTarget:self action:@selector(moreButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_moreButton setImage:[UIImage imageNamed:@"TourappMoreButton"] forState:UIControlStateNormal];
        [self.contentView addSubview:_moreButton];

        _downloadButton = [UIButton new];
        [_downloadButton addTarget:self action:@selector(downloadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_downloadButton setTitleColor:[UIColor downloadButtonGreen] forState:UIControlStateNormal];
        [self.contentView addSubview:_downloadButton];
        [_downloadButton setTitle:@"Загрузить" forState:UIControlStateNormal];
        _downloadButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
        _downloadButton.layer.borderColor = UIColor.lightGrayColor.CGColor;
        _downloadButton.layer.borderWidth = 1;
        _downloadButton.layer.cornerRadius = 8;
        
        [self layoutDebug];
    }
    return self;
}


- (IBAction)moreButtonPressed:(id)sender
{
    
}

- (IBAction)downloadButtonPressed:(id)sender
{
    
}

- (void)updateConstraints
{
    UIView *contentView = self.contentView;
    
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.mas_top).with.offset(SLVBigOffset);
        make.right.mas_equalTo(contentView.mas_right).offset(- SLVBigOffset);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(6);
    }];
    
    [_downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(_moreButton.mas_bottom).with.offset(SLVBigOffset);
        make.right.mas_equalTo(contentView.mas_right).offset(- SLVBigOffset);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(72);
    }];
    
    [_routeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.mas_top).with.offset(SLVStandardOffset);
        make.left.mas_equalTo(contentView.mas_left).with.offset(SLVStandardOffset);
        make.right.mas_equalTo(_downloadButton.mas_left).offset( - SLVBigOffset);
        make.height.mas_equalTo(48);
    }];
    
    [_routeAuthor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_routeName.mas_bottom).with.offset(SLVSmallOffset);
        make.left.mas_equalTo(contentView.mas_left).with.offset(SLVStandardOffset);
        make.right.mas_equalTo(_downloadButton.mas_left).offset( - SLVBigOffset);
        make.height.mas_equalTo(22);
    }];
    
    [_images mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_routeAuthor.mas_bottom).with.offset(SLVStandardOffset);
        make.left.mas_equalTo(contentView.mas_left).with.offset(SLVSmallOffset);
        make.right.mas_equalTo(contentView.mas_right).offset( - SLVBigOffset);
        make.height.mas_equalTo(105);
    }];
    
    [_shortInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_images.mas_bottom).with.offset(SLVSmallOffset);
        make.left.mas_equalTo(contentView.mas_left).with.offset(SLVStandardOffset);
        make.right.mas_equalTo(contentView.mas_right).offset(- SLVBigOffset);
        make.height.mas_lessThanOrEqualTo(150).with.priorityMedium();
        make.bottom.mas_equalTo(contentView.mas_bottom).with.offset(- SLVBigOffset);
    }];
    
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}


- (void)layoutDebug
{
    _images.backgroundColor = [UIColor.redColor colorWithAlphaComponent:0.2];
}

@end
