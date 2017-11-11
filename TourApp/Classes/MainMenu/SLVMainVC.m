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

@interface SLVMainVC ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SLVMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"city2.jpg"];
    self.imageView.layer.opacity = 0.3;
    [self addButtons];
}

- (IBAction)clearDatabase:(id)sender {
    [self deleteAllEntities: @"Route"];
    [self deleteAllEntities:@"RouteNode"];
    [self deleteAllEntities:@"MyDescription"];
}

- (void)deleteAllEntities:(NSString *)nameEntity {
    
}

- (IBAction)goToMap:(id)sender {
    SLVPlacesVC *mapvc = [[SLVPlacesVC alloc] initWithPresenter:[SLVPresenterFactory nodesPresenter]];
    [self presentViewController:mapvc animated:YES completion:nil];
}

- (IBAction)storeButtonPressed:(id)sender {

}

- (IBAction)createRouteButtonPressed:(id)sender {

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
    
    UIButton *toMapButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 120, self.view.frame.size.height / 2 + 40, 240, 60)] ;
    toMapButton.backgroundColor = [UIColor redColor];
    toMapButton.layer.opacity = 0.7;
    [toMapButton setTitle:@"Временная: к карте" forState:UIControlStateNormal];
    [toMapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [toMapButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [toMapButton addTarget:self action:@selector(goToMap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toMapButton];
    
    UIButton *clearDatabaseButton=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-120,self.view.frame.size.height/2+110,240,60)] ;
    clearDatabaseButton.backgroundColor=[UIColor lightGrayColor];
    clearDatabaseButton.layer.opacity=0.7;
    [clearDatabaseButton setTitle:@"Временная: очистить память" forState:UIControlStateNormal];
    [clearDatabaseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearDatabaseButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [clearDatabaseButton addTarget:self action:@selector(clearDatabase:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearDatabaseButton];
}

@end
