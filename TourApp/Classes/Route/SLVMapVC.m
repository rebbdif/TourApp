//
//  MapVC.m
//  tourapp3
//
//  Created by 1 on 05.04.17.
//  Copyright © 2017 group1. All rights reserved.
//

#import "SLVMapVC.h"
#import "SLVMainVC.h"
#import "SLVNodesPresenter.h"

@import Mapbox;
@import MapboxDirections;

@interface SLVMapVC () <MGLMapViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) CLLocationCoordinate2D center;
@property (nonatomic, strong) SLVNodesPresenter *presenter;
@property (nonatomic, strong) MGLMapView *mapView;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation SLVMapVC

- (instancetype)initWithPresenter:(SLVNodesPresenter *)presenter {
    self = [super init];
    if (self) {
        _presenter = presenter;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [MGLMapView new];
    _mapView.frame = self.view.bounds;
    [self.view addSubview:_mapView];
    self.mapView.delegate = self;
    [self addMapButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    [self showMap];
}

#pragma mark - Nodes

- (void)showMap {
    if (!self.center.latitude || !self.center.longitude) {
        [self calculateBounds];
    } else {
        [self.mapView setCenterCoordinate:self.center zoomLevel:14 animated:YES];
    }
    [self showPoints];
}

- (void)showPoints {
    for (NSUInteger index = 0; index < [self.presenter numberOfPoints]; ++ index) {
        double longitude= [node.longitude doubleValue];
        double latitude=[node.latitude doubleValue];
        
        MGLPointAnnotation *point = [[MGLPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake(latitude,longitude);
        point.title = node.nodeName;
        point.subtitle = [NSString stringWithFormat:@"coordinates %f, %f", latitude,longitude];
        [self.mapView addAnnotation:point];
    }
}

- (void)calculateBounds {
    //    CLLocationCoordinate2D sw;
    //    sw.latitude = [_model.thisNodes[0].latitude doubleValue], sw.longitude = [_model.thisNodes[0].longitude doubleValue];
    //    CLLocationCoordinate2D ne = sw;
    //
    //    for (RouteNode *node in _model.thisNodes) {
    //        @autoreleasepool {
    //            const double longitude= [node.longitude doubleValue];
    //            const double latitude=[node.latitude doubleValue];
    //
    //            if (latitude < sw.latitude) {
    //                sw.latitude=latitude;
    //            }
    //            if (longitude < sw.longitude) {
    //                sw.longitude = longitude;
    //            }
    //            if (latitude > ne.latitude) {
    //                ne.latitude=latitude;
    //            }
    //            if (longitude > ne.longitude) {
    //                ne.longitude = longitude;
    //            }
    //        }
    //    }
    //    MGLCoordinateBounds bounds;
    //    double inset = 0.001;
    //    ne.latitude += inset;
    //    ne.longitude += inset;
    //    sw.latitude -= inset;
    //    sw.longitude -= inset;
    //    bounds.ne = ne;
    //    bounds.sw = sw;
    //    [self.mapView setVisibleCoordinateBounds:bounds animated:YES];
}

#pragma mark - MGLMapViewDelegate

- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation {
    return YES;
}

- (void)mapView:(MGLMapView *)mapView tapOnCalloutForAnnotation:(id <MGLAnnotation>)annotation{
    NSLog(@"callout for annotation tapped");
    // здесь можно сделать переход к конкретному месту в таблице маршрутов
}

#pragma mark - directions

- (IBAction)showDirections:(UIButton *)sender {
    [self showDirections];
}

- (void)showDirections {
    //copy
}

#pragma mark Buttons

- (void)addMapButtons {
    CGRect bounds = self.view.bounds;
    
    CGFloat d = 35;
    CGFloat w = bounds.size.width - 45;
    
    UIButton *zoomInButton = [UIButton new];
    [self configureButton:zoomInButton label:@"+" image:nil frame:CGRectMake(w, CGRectGetHeight(bounds) / 2 - 80 , d, d) selector:@selector(zoomIn:)];
    
    UIButton *zoomOutButton = [UIButton new];
    [self configureButton:zoomOutButton label:@"-" image:nil frame:CGRectMake(w, CGRectGetHeight(bounds) / 2 - 40, d-1, d-1) selector:@selector(zoomOut:)];
    
    UIButton *locateMeButton = [UIButton new];
    [self configureButton:locateMeButton label:@"Л" image:nil frame:CGRectMake(w, CGRectGetHeight(bounds) / 2 + 120, d, d) selector:@selector(showUserLocation:)];
    
    UIButton *makeDirectionsButton = [UIButton new];
    [self configureButton:makeDirectionsButton label:@"D" image:nil frame:CGRectMake(5, CGRectGetHeight(bounds) - 40, d, d) selector:@selector(showDirections:)];
    makeDirectionsButton.backgroundColor = [UIColor blueColor];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"nodes", @"map" ,@"main"]];
    segmentedControl.frame = CGRectMake(self.view.frame.size.width / 2 - 100, 25, 200, 30);
    [self.view addSubview:segmentedControl];
    segmentedControl.selectedSegmentIndex = 1;
    [segmentedControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
}

-(void)configureButton:(UIButton*)button label:(NSString*)label image:(UIImage*)image frame:(CGRect)frame selector:(SEL)selector {
    button.frame=frame;
    button.layer.cornerRadius=frame.size.width/2;
    button.layer.shadowOffset=CGSizeMake(2, 2);
    button.layer.shadowRadius=0.5;
    button.layer.borderColor=[UIColor grayColor].CGColor;
    button.layer.borderWidth=0.1;
    button.backgroundColor=[UIColor redColor];
    button.layer.opacity=0.7;
    [button setTitle:label forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    if (image) {
        button.layer.contents=CFBridgingRelease([image CGImage]);
        button.layer.contentsGravity=kCAGravityResize;
        button.layer.masksToBounds=YES;
        button.layer.shouldRasterize=YES;
    }
    
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

//- (void)segmentedControlValueDidChange:(UISegmentedControl *)segment {
//    switch (segment.selectedSegmentIndex) {
//        case 0: {
//            RouteNodesVC *vc = [RouteNodesVC new];
//            [self presentViewController:vc animated:YES completion:nil];
//            break;
//        } case 1: {
//            break;
//        } case 2: {
//            MainVC *mainvc = [MainVC new];
//            [self presentViewController:mainvc animated:YES completion:nil];
//            break;
//        }
//    }
//}

- (IBAction)zoomIn:(id)sender{
    @autoreleasepool {
        double currentZoomLevel = self.mapView.zoomLevel;
        double nextZoomLevel = currentZoomLevel + 1;
        [self.mapView setZoomLevel:nextZoomLevel animated:YES];
    }
}
- (IBAction)zoomOut:(id)sender{
    @autoreleasepool {
        double currentZoomLevel = self.mapView.zoomLevel;
        double nextZoomLevel = currentZoomLevel - 1;
        [self.mapView setZoomLevel:nextZoomLevel animated:YES];
    }
}

- (IBAction)showUserLocation:(id)sender{
    self.mapView.showsUserLocation = YES;
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
}

@end
