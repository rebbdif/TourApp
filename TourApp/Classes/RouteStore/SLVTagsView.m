//
//  SLVTagsView.m
//  TourApp
//
//  Created by Леонид Серебряный on 17/12/2017.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVTagsView.h"
#import "SLVTagCollectionCell.h"
@import Masonry;


static CGFloat const SLVSearchButtonWidth = 30;
static CGFloat const SLVSearchButtonHeight = 30;


@interface SLVTagsView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UICollectionView *tagsCollection;
@property (nonatomic, strong) UIButton *searchButton;

//TagsViewModel
@property (nonatomic, strong) NSMutableSet<SLVTag *> *tags;

@end


@implementation SLVTagsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addCollectionView];
        [self addSearchButton];
        
        _tags = [NSMutableSet new];
    }
    return self;
}

- (void)addCollectionView
{
    UICollectionViewFlowLayout *tagsLayout = [UICollectionViewFlowLayout new];
    _tagsCollection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:tagsLayout];
    tagsLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [_tagsCollection registerClass:[SLVTagCollectionCell class] forCellWithReuseIdentifier:@"SLVTag"];
    _tagsCollection.delegate = self;
    _tagsCollection.dataSource = self;
    _tagsCollection.backgroundColor = UIColor.clearColor;
    [self addSubview:_tagsCollection];
}

- (void)addSearchButton
{
    _searchButton = [UIButton new];
    [_searchButton setTitle:@"🔎" forState:UIControlStateNormal];
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:20];
    _searchButton.backgroundColor = UIColor.clearColor;
    [_searchButton addTarget:self action:@selector(didPressSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_searchButton];
}

- (CGFloat)height
{
    return 44;
}

- (void)updateConstraints
{
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SLVSearchButtonWidth);
        make.height.mas_equalTo(SLVSearchButtonHeight);
        make.right.mas_equalTo(self).offset(-SLVSmallOffset);
        make.centerY.mas_equalTo(self);
    }];
    [self.tagsCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self.searchButton.mas_left).offset(-SLVStandardOffset);
    }];
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}


#pragma mark - TagsViewModel

- (void)addTag:(SLVTag *)tag
{
    [self.tags addObject:tag];
    [self.tagsCollection reloadData];
}

- (void)addTags:(NSArray<SLVTag *> *)tags
{
    [self.tags addObjectsFromArray:tags];
    [self.tagsCollection reloadData];
}

- (void)removeTag:(SLVTag *)tag
{
    [self.tags removeObject:tag];
    [self.tagsCollection reloadData];
}


#pragma mark - TagsCollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tags.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLVTagCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SLVTag" forIndexPath:indexPath];
    
    SLVTag *tag = self.tags.allObjects[indexPath.item];
    [cell setTag:tag];
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

static CGFloat const insetBetweenCells = 12.0;

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SLVTag *tag = self.tags.allObjects[indexPath.item];
    return [SLVTagCollectionCell sizeForTag:tag];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, insetBetweenCells / 2, 0, insetBetweenCells / 2);
    return insets;
}


#pragma mark - Actions

- (IBAction)didPressSearchButton:(id)sender
{
    [self.delegate didPressSearchButton];
}

@end
