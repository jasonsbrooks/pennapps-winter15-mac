//
//  BluetoothConnection.h
//  Browsr
//
//  Created by Minh Tri Pham on 1/17/15.
//  Copyright (c) 2015 Minh Tri Pham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
@import IOBluetooth;


@interface BluetoothConnectionViewController : NSObject <IOBluetoothDeviceInquiryDelegate>

@property (nonatomic, retain) MainViewController *vc;
@property (nonatomic, strong) IOBluetoothHandsFreeDevice *phone;
- (void)bluetoothConnect: (IOBluetoothDevice*)device;

- (void) bluetoothSearch;
- (NSString *)downloadPageWithUrl:(NSString *)url;

@end
