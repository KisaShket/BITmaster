//
//  MapViewController.h
//  BIT
//
//  Created by Miska  on 06/11/2019.
//  Copyright © 2019 Miska . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController
    @property (nonatomic,strong,nonnull) NSString *starsCOUNT;
    @property(nonatomic,strong,nonnull) NSString *latit;
    @property(nonatomic,strong,nonnull) NSString *longit;
@end

NS_ASSUME_NONNULL_END
