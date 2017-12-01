//
//  ViewController.h
//  LocationTest
//
//  Created by cs.lim on 2017. 11. 20..
//  Copyright © 2017년 maxted. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *activateLocationBtn;
@property (strong, nonatomic) IBOutlet UIButton *nowLocationBtn;
@property (strong, nonatomic) IBOutlet UIButton *deactivateLocation;

- (IBAction)activateLocationBtnClicked:(id)sender;
- (IBAction)nowLocationBtnClicked:(id)sender;
- (IBAction)deactivateLocationBtnClicked:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;

@end

