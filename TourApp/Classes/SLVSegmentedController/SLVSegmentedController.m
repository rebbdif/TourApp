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
#import "SLVPresenterFactory.h"


@interface SLVSegmentedController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) SLVNodesPresenter *presenter;
@property (nonatomic, strong) SLVMapVC *mapVC;
@property (nonatomic, strong) SLVMainVC *mainVC;
@property (nonatomic, strong) SLVPlacesVC *placesVC;

@end


@implementation SLVSegmentedController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSegmentedControl];
    self.presenter = [SLVPresenterFactory nodesPresenter];
    self.placesVC = [[SLVPlacesVC alloc] initWithPresenter:self.presenter];
    self.mapVC = [[SLVMapVC alloc] initWithPresenter:self.presenter];
    self.mainVC = [SLVMainVC new];
    self.viewControllers = @[self.placesVC, self.mapVC, self.mainVC];
    self.tabBar.hidden = YES;
    self.selectedIndex = SLVControllerIndexMain;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.segmentedControl.selectedSegmentIndex = 2;
}

- (void)addSegmentedControl
{
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"nodes", @"map" ,@"main"]];
    self.segmentedControl.frame = CGRectMake(self.view.frame.size.width / 2 - 100, 25, 200, 30);
    [self.view addSubview:self.segmentedControl];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentedControlValueDidChange:(UISegmentedControl *)segment
{
    SLVControllerIndex selectedIndex = segment.selectedSegmentIndex;
    [self showControllerFowIndex:selectedIndex];
}


- (void)selectControllerWithIndex:(SLVControllerIndex)controllerIndex
{
    self.segmentedControl.selectedSegmentIndex = controllerIndex;
    [self showControllerFowIndex:controllerIndex];
}

- (void)showControllerFowIndex:(SLVControllerIndex)selectedIndex
{
    switch (selectedIndex) {
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
