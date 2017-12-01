//
//  LocationManager.m
//  LocationTest
//
//  Created by cs.lim on 2017. 11. 30..
//  Copyright © 2017년 maxted. All rights reserved.
//

#import "MyLocationManager.h"
#import <UIKit/UIDevice.h>
#import <math.h>

#define pi 3.14159265358979323846


@implementation MyLocationManager

@synthesize locationManager=_locationManager;
@synthesize location=_location;

#pragma mark - initialize class
- (id)init {
    if (self == [super init]) {
    }
    return self;
}

#pragma mark - Custom Methods
- (int)getLocationServiceState {
    
    int resCod = 0;
    int authStatus = [CLLocationManager authorizationStatus];
    BOOL isLocServiceEnable = CLLocationManager.locationServicesEnabled;
    
    NSLog(@"locationServicesEnabled: %d", CLLocationManager.locationServicesEnabled);
    NSLog(@"status: %d", [CLLocationManager authorizationStatus]);

    if (authStatus == 2 && isLocServiceEnable == false) {
        resCod = 2; // 설정메뉴 위치서비스 on/off 체크
    }
    else if (authStatus == 2 && isLocServiceEnable == true) {
        resCod = 1; // 앱 위치정보 on/off 체크
    }
    
    return resCod;
}

- (void)activateLoaction {
    
    if (nil == _locationManager)
        self.locationManager = [[CLLocationManager alloc] init];

    if (nil == _location)
        self.location = [[CLLocation alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;    // 거리변경 시 노티피케이션 발생
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation; // 측정 정확도 설정(이게 제일 정확하다고...)
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [_locationManager requestWhenInUseAuthorization];
    
    [_locationManager startUpdatingLocation];
}

- (void)deactivateLocation {
    [_locationManager stopUpdatingLocation];
}

- (CLLocation *)getNowLocation {
    
    return _location;
}

#pragma mark - CLLocationManager Delegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations API_AVAILABLE(ios(6.0), macos(10.9)) {
    
    self.location = [locations lastObject];
    
    // Negative is invalid value.
    if (_location.horizontalAccuracy < 0) {
        // invalid
    }
    
    NSDate* eventDate = _location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              _location.coordinate.latitude,
              _location.coordinate.longitude);
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // handle errors
}

#pragma mark - Calc distance between two locations
- (double)deg2rad:(double)inDeg {
    return (inDeg * pi / 180);
}

- (double)rad2deg:(double)inRad {
    return (inRad * 180 / pi);
}

- (double)distanceFromFirstLat:(double)lat1 firstLot:(double)lon1 toSecondLat:(double)lat2 secondLot:(double)lon2 withUnit:(NSString *)unit {
    
    double theta, dist;
    theta = lon1 - lon2;
    dist = sin([self deg2rad:lat1]) * sin([self deg2rad:lat2]) + cos([self deg2rad:lat1]) * cos([self deg2rad:lat2]) * cos([self deg2rad:theta]);
    dist = acos(dist);
    dist = [self rad2deg:dist];
    dist = dist * 60 * 1.1515;      // Mile

    if ([unit isEqualToString:@"K"]) {
        dist = dist * 1.609344;     // Kilometer
    } else if ([unit isEqualToString:@"M"]) {
        dist = dist * 1609.344;     // meter
    }

    return dist;
}


@end
