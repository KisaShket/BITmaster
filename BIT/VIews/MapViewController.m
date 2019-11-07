//
//  MapViewController.m
//  BIT
//
//  Created by Miska  on 06/11/2019.
//  Copyright © 2019 Miska . All rights reserved.
//

#import "MapViewController.h"
#import "BIT-Swift.h"

@interface MapViewController ()

@end

@implementation MapViewController

-(void)loadView{
    
    //MARK:-Форматирование полученных данных
    double la = [_latit doubleValue];
    double lo = [_longit doubleValue];
    
    //MARK:-Центрирование карты
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:la
                                                            longitude:lo
                                                                 zoom:kGMSMinZoomLevel];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    //MARK:-Маркер по сгенерированным координатам
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(la, lo);
    marker.title = @"STARS*";
    marker.snippet = _starsCOUNT;
    marker.map = mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *printStars = self.starsCOUNT;
    NSLog(@"String: %@", printStars);
}

@end
