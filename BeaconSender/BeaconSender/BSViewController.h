//
//  BSViewController.h
//  BeaconSender
//
//  Created by suwa_yuki on 2013/10/01.
//  Copyright (c) 2013年 suwa.yuki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BSViewController : UITableViewController <CBPeripheralManagerDelegate>

@property(nonatomic) CLBeaconRegion *region;
@property(nonatomic) CBPeripheralManager *manager;
@property(nonatomic) NSUUID *proximityUUID;

@property (weak, nonatomic) IBOutlet UISwitch *firstSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *secondSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *thirdSwitch;

- (IBAction)didFirstSwitchValueChange:(id)sender;
- (IBAction)didSecondSwitchValueChanged:(id)sender;
- (IBAction)didThirdSwitchValueChanged:(id)sender;
@end
