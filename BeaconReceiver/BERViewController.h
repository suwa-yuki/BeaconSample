//
//  BERViewController.h
//  BeaconReceiver
//
//  Created by suwa.yuki on 12/12/13.
//  Copyright (c) 2013 suwa.yuki. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;
@import AVFoundation;

@interface BERViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) NSUUID *proximityUUID;
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLBeaconRegion *region;

@property (strong, nonatomic) AVAudioPlayer *enter;
@property (strong, nonatomic) AVAudioPlayer *exit;

@property (weak, nonatomic) IBOutlet UILabel *beaconLabel;
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *minorLabel;
@property (weak, nonatomic) IBOutlet UILabel *proximityLabel;
@property (weak, nonatomic) IBOutlet UILabel *accuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLabel;

@end
