//
//  MainVC.m
//  TourApp
//
//  Created by 1 on 19.07.17.
//  Copyright © 2017 serebryanyy. All rights reserved.
//

#import "SLVMainVC.h"
#import "SLVMapVC.h"
#import "SLVPlacesVC.h"
#import "SLVNodesPresenter.h"
#import "SLVPresenterFactory.h"
#import "SLVRouteStoreVC.h"
#import "SLVRoutesPresenter.h"


@interface SLVMainVC ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SLVMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"city2.jpg"];
    self.imageView.layer.opacity = 0.3;
    [self addButtons];
}

- (IBAction)storeButtonPressed:(id)sender
{
    SLVRouteStoreVC *routeStoreVC = [[SLVRouteStoreVC alloc] initWithPresenter:[SLVPresenterFactory routesPresenter]];
    [self.navigationController pushViewController:routeStoreVC animated:YES];
}

- (void)addButtons {
    UIButton *storeButton=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 120, self.view.frame.size.height / 2 - 30, 240, 60)] ;
    storeButton.backgroundColor = [UIColor redColor];
    [storeButton setTitle:@"Магазин маршрутов" forState:UIControlStateNormal];
    [storeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [storeButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [storeButton.layer setShadowOffset:CGSizeMake(5, 5)];
    [storeButton.layer setShadowOpacity:0.7];
    [storeButton.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    [storeButton.layer setShadowRadius:0];
    [storeButton addTarget:self action:@selector(storeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:storeButton];
    
    UIButton *createRouteButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 120,self.view.frame.size.height / 2 - 100, 240, 60)] ;
    createRouteButton.backgroundColor = [UIColor redColor];
    [createRouteButton setTitle:@"Создать маршрут" forState:UIControlStateNormal];
    [createRouteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createRouteButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [createRouteButton.layer setShadowOffset:CGSizeMake(5, 5)];
    [createRouteButton.layer setShadowOpacity:0.7];
    [createRouteButton.layer setShadowColor:[UIColor darkGrayColor].CGColor];
    [createRouteButton.layer setShadowRadius:0.3];
    [createRouteButton addTarget:self action:@selector(createRouteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createRouteButton];
    
}

@end
