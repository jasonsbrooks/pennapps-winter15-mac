//
//  BluetoothConnection.h
//  Browsr
//
//  Created by Jason Brooks on 1/17/15.
//  Copyright (c) 2015 Jason Brooks. All rights reserved.
//

#import <Foundation/Foundation.h>
@import IOBluetooth;

@interface BluetoothConnection : NSObject <IOBluetoothDeviceInquiryDelegate>
@property (nonatomic, retain) IOBluetoothHandsFreeDevice *phone;

-(void) bluetoothSearch;


@end
