//
//  LocationManager.h
//  LocationTest
//
//  Created by cs.lim on 2017. 11. 30..
//  Copyright © 2017년 maxted. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MyLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation* location;

// GPS 위치측정
- (int)getLocationServiceState;
- (void)activateLoaction;
- (void)deactivateLocation;
- (CLLocation *)getNowLocation;

// 거리측정
- (double)deg2rad:(double)inDeg;
- (double)rad2deg:(double)inRad;
- (double)distanceFromFirstLat:(double)lat1 firstLot:(double)lon1 toSecondLat:(double)lat2 secondLot:(double)lon2 withUnit:(NSString *)unit;

@end
