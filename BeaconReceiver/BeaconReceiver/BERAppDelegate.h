//
//  BERAppDelegate.h
//  BeaconReceiver
//
//  Created by suwa.yuki on 12/12/13.
//  Copyright (c) 2013 suwa.yuki. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;
@import AVFoundation;

@interface BERAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSUUID *proximityUUID;
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLBeaconRegion *region;

@property (strong, nonatomic) AVAudioPlayer *enter;
@property (strong, nonatomic) AVAudioPlayer *exit;

@end
