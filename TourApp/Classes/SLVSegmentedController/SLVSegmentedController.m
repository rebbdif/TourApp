//
//  SLVSegmentedController.m
//  TourApp
//
//  Created by 1 on 06.10.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVSegmentedController.h"

#import "SLVMapVC.h"
#import "SLVMainVC.h"
#import "SLVPlacesVC.h"

typedef NS_ENUM(NSUInteger, SLVControllerIndex) {
    SLVControllerIndexNodes,
    SLVControllerIndexMap,
    SLVControllerIndexMain,
};

@interface SLVSegmentedController ()

@property (nonatomic, strong) SLVNodesPresenter *presenter;

@end


@implementation SLVSegmentedController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSegmentedControl];
    SLVPlacesVC *placesVC = [[SLVPlacesVC alloc] initWithPresenter:self.presenter];
    SLVMapVC *mapVC = [[SLVMapVC alloc] initWithPresenter:self.presenter];
    SLVMainVC *mainVC = [SLVMainVC new];
    self.viewControllers = @[placesVC, mapVC, mainVC];
    self.tabBar.hidden = YES;
    self.selectedIndex = SLVControllerIndexMain;
}

- (void)addSegmentedControl {
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"nodes", @"map" ,@"main"]];
    segmentedControl.frame = CGRectMake(self.view.frame.size.width / 2 - 100, 25, 200, 30);
    [self.view addSubview:segmentedControl];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentedControlValueDidChange:(UISegmentedControl *)segment {
    switch (segment.selectedSegmentIndex) {
        case SLVControllerIndexNodes: {
            self.selectedIndex = SLVControllerIndexNodes;
            break;
        } case SLVControllerIndexMap: {
            self.selectedIndex = SLVControllerIndexMap;
            break;
        } case SLVControllerIndexMain: {
            self.selectedIndex = SLVControllerIndexMain;
            break;
        }
    }
}

@end
