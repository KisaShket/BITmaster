//
//  MapViewController.m
//  BIT
//
//  Created by Miska  on 06/11/2019.
//  Copyright © 2019 Miska . All rights reserved.
//

#import "MapViewController.h"
#import "BIT-Swift.h"
@import GoogleMaps;

@interface MapViewController () <GMSMapViewDelegate>
@property (strong, nonatomic) GMSMapView *mapView;
@end

@implementation MapViewController{
    
}

-(void)loadView{
    
    //MARK:-Форматирование полученных данных
    double la = [_latit doubleValue];
    double lo = [_longit doubleValue];
  
    

    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
    iconView.image = [UIImage imageNamed:@"marker"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, -9,64,64)];
    label.text = _starsCOUNT;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font =[label.font fontWithSize:11];
    [iconView addSubview:label];
   
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(64, 64), NO, [[UIScreen mainScreen] scale]);
    [iconView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *icon = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    //MARK:-Центрирование карты
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:la
                                                            longitude:lo
                                                                 zoom:kGMSMinZoomLevel];
    _mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _mapView.myLocationEnabled = YES;
    self.view = _mapView;
    
    //MARK:-Маркер по сгенерированным координатам
   GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(la, lo);
    marker.title = @"my title";
    marker.icon = icon;
    marker.map = _mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *printStars = self.starsCOUNT;
    NSLog(@"String: %@", printStars);
}


@end
