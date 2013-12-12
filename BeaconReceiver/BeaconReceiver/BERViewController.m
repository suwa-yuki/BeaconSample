//
//  BERViewController.m
//  BeaconReceiver
//
//  Created by suwa.yuki on 12/12/13.
//  Copyright (c) 2013 suwa.yuki. All rights reserved.
//

#import "BERViewController.h"

@interface BERViewController ()

@end

@implementation BERViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 効果音
    NSString *path = [[NSBundle mainBundle] pathForResource:@"enter" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.enter = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    path = [[NSBundle mainBundle] pathForResource:@"exit" ofType:@"mp3"];
    url = [NSURL fileURLWithPath:path];
    self.exit = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    if ([CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        // CLLocationManagerの生成とデリゲートの設定
        self.manager = [CLLocationManager new];
        self.manager.delegate = self;
        
        // 生成したUUIDからNSUUIDを作成
        NSString *uuid = @"1E21BCE0-7655-4647-B492-A3F8DE2F9A02";
        self.proximityUUID = [[NSUUID alloc] initWithUUIDString:uuid];
        
        // CLBeaconRegionを作成
        self.region = [[CLBeaconRegion alloc]
                       initWithProximityUUID:self.proximityUUID
                       identifier:@"jp.classmethod.testregion"];
        
        // Beaconによる距離測定を開始
        [self.manager startRangingBeaconsInRegion:self.region];
    }
}

// ------------------------------
// CLLocationManagerDelegate
// ------------------------------

// Responding to Location Events

// locationManager:didUpdateLocations:
// Tells the delegate that new location data is available.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


// locationManager:didFailWithError:
// Tells the delegate that the location manager was unable to retrieve a location value.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


// locationManager:didFinishDeferredUpdatesWithError:
// Tells the delegate that updates will no longer be deferred.
- (void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


// Pausing Location Updates

// locationManagerDidPauseLocationUpdates:
// Tells the delegate that location updates were paused. (required)
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


// locationManagerDidResumeLocationUpdates:
// Tells the delegate that the delivery of location updates has resumed. (required)
- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


// Responding to Heading Events

// locationManager:didUpdateHeading:
// Tells the delegate that the location manager received updated heading information.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


// locationManagerShouldDisplayHeadingCalibration:
// Asks the delegate whether the heading calibration alert should be displayed.
- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return TRUE;
}


// Responding to Region Events

// locationManager:didEnterRegion:
// Tells the delegate that the user entered the specified region.

// Beaconに入ったときに呼ばれる
- (void)locationManager:(CLLocationManager *)manager
         didEnterRegion:(CLRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.enter play];
}


// locationManager:didExitRegion:
// Tells the delegate that the user left the specified region.

// Beaconから出たときに呼ばれる
- (void)locationManager:(CLLocationManager *)manager
          didExitRegion:(CLRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.exit play];
}


// locationManager:didDetermineState:forRegion:
// Tells the delegate about the state of the specified region. (required)

// Beaconとの状態が確定したときに呼ばれる
- (void)locationManager:(CLLocationManager *)manager
      didDetermineState:(CLRegionState)state
              forRegion:(CLRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    switch (state) {
        case CLRegionStateInside:
            NSLog(@"CLRegionStateInside");
            break;
        case CLRegionStateOutside:
            NSLog(@"CLRegionStateOutside");
            break;
        case CLRegionStateUnknown:
            NSLog(@"CLRegionStateUnknown");
            break;
        default:
            break;
    }
}


// locationManager:monitoringDidFailForRegion:withError:
// Tells the delegate that a region monitoring error occurred.
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


// locationManager:didStartMonitoringForRegion:
// Tells the delegate that a new region is being monitored.
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


// Responding to Ranging Events

// locationManager:didRangeBeacons:inRegion:
// Tells the delegate that one or more beacons are in range. (required)
- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    if ([beacons count] == 0) {
        // Beaconが存在しない場合は何もしない
        return;
    }
    
    CLProximity proximity = CLProximityUnknown;
    NSString *proximityString = @"CLProximityUnknown";
    CLLocationAccuracy locationAccuracy = 0.0;
    NSInteger rssi = 0;
    NSNumber* major = 0;
    NSNumber* minor = 0;
    
    // 最初のオブジェクト = 最も近いBeacon
    CLBeacon *beacon = beacons.firstObject;
    
    proximity = beacon.proximity;
    locationAccuracy = beacon.accuracy;
    rssi = beacon.rssi;
    major = beacon.major;
    minor = beacon.minor;
    
    switch (proximity) {
        case CLProximityUnknown:
            proximityString = @"CLProximityUnknown";
            break;
        case CLProximityImmediate:
            proximityString = @"CLProximityImmediate";
            break;
        case CLProximityNear:
            proximityString = @"CLProximityNear";
            break;
        case CLProximityFar:
            proximityString = @"CLProximityFar";
            break;
        default:
            break;
    }
    
    self.uuidLabel.text = beacon.proximityUUID.UUIDString;
    self.majorLabel.text = [NSString stringWithFormat:@"%@", major];
    self.minorLabel.text = [NSString stringWithFormat:@"%@", minor];
    self.proximityLabel.text = proximityString;
    self.accuracyLabel.text = [NSString stringWithFormat:@"%f", locationAccuracy];
    self.rssiLabel.text = [NSString stringWithFormat:@"%d", rssi];
    
    if ([minor isEqualToNumber:@1]) {
        // Beacon A
        self.beaconLabel.text = @"A";
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0.749 blue:1.0 alpha:1.0];
    } else if ([minor isEqualToNumber:@2]) {
        // Beacon B
        self.beaconLabel.text = @"B";
        self.view.backgroundColor = [UIColor colorWithRed:0.604 green:0.804 blue:0.196 alpha:1.0];
    } else if ([minor isEqualToNumber:@3]) {
        // Beacon C
        self.beaconLabel.text = @"C";
        self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.412 blue:0.706 alpha:1.0];
    } else {
        self.beaconLabel.text = @"-";
        self.view.backgroundColor = [UIColor colorWithRed:0.663 green:0.663 blue:0.663 alpha:1.0];
    }
}


// locationManager:rangingBeaconsDidFailForRegion:withError:
// Tells the delegate that an error occurred while gathering ranging information for a set of beacons. (required)
- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


// Responding to Authorization Changes

// ocationManager:didChangeAuthorizationStatus:
// Tells the delegate that the authorization status for the application changed.
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"kCLAuthorizationStatusNotDetermined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"kCLAuthorizationStatusRestricted");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"kCLAuthorizationStatusDenied");
            break;
        case kCLAuthorizationStatusAuthorized:
            NSLog(@"kCLAuthorizationStatusAuthorized");
            break;
        default:
            break;
    }
}

@end
