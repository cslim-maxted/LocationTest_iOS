//
//  ViewController.m
//  LocationTest
//
//  Created by cs.lim on 2017. 11. 20..
//  Copyright © 2017년 maxted. All rights reserved.
//

#import "ViewController.h"
#import "MyLocationManager.h"

@interface ViewController ()

@property (nonatomic, strong) MyLocationManager *locManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.locManager = [[MyLocationManager alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 1000) {
        if (buttonIndex == 0) {
        } else {
            NSURL *url = [NSURL URLWithString:@"App-Prefs:root=Privacy&path=LOCATION"];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    else if (alertView.tag == 1001) {
        if (buttonIndex == 0) {
        } else {
            NSURL *url = [NSURL URLWithString:@"App-Prefs:root=Privacy&path=LOCATION/kr.maxted.ios.LocationTest"];
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark - Button Actions
- (IBAction)activateLocationBtnClicked:(id)sender {

    int permission = [_locManager getLocationServiceState];
    
    if (permission == 2) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"위치서비스 꺼져있음, 다시 켤꺼임?"
                                                       delegate:self
                                              cancelButtonTitle:@"아니"
                                              otherButtonTitles:@"응", nil];
        alert.tag = 1000;
        [alert show];
    }
    else if (permission == 1) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"위치정보 꺼져있음, 다시 켤꺼임?"
                                                       delegate:self
                                              cancelButtonTitle:@"아니"
                                              otherButtonTitles:@"응", nil];
        alert.tag = 1001;
        [alert show];
    }
    else {
        [_locManager activateLoaction];
    }
}

- (IBAction)nowLocationBtnClicked:(id)sender {
    
    [self.latitudeLabel setText:[NSString stringWithFormat:@"%f", [_locManager getNowLocation].coordinate.latitude]];
    [self.longitudeLabel setText:[NSString stringWithFormat:@"%f", [_locManager getNowLocation].coordinate.longitude]];

    
    // 1. 본사: 37.493690, 127.016155
    // 2. 서초중앙프라자: 37.496312, 127.019352
    double lat1 = 37.493690;
    double lon1 = 127.016155;
    double lat2 = 37.496312;
    double lon2 = 127.019352;
    
    double distance = [_locManager distanceFromFirstLat:lat1
                                               firstLot:lon1
                                            toSecondLat:lat2
                                              secondLot:lon2
                                               withUnit:@"M"];
    NSLog(@"두 지점 간 거리: %f", distance);
}

- (IBAction)deactivateLocationBtnClicked:(id)sender {
    
    [_locManager deactivateLocation];
}


@end
