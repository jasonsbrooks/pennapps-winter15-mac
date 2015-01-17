//
//  BluetoothConnection.m
//  Browsr
//
//  Created by Jason Brooks on 1/17/15.
//  Copyright (c) 2015 Jason Brooks. All rights reserved.
//

#import "BluetoothConnection.h"


@implementation BluetoothConnection

-(void) bluetoothSearch {
    IOBluetoothDeviceInquiry* inquiry = [[IOBluetoothDeviceInquiry alloc] initWithDelegate:self];
    NSLog(@"Starting inquiry");
    IOReturn logVal = [inquiry start];
    if (logVal == kIOReturnSuccess)
        NSLog(@"Inquiry started successfully.");
    else if (logVal == kIOReturnBusy)
        NSLog(@"Error: Busy");
    else
        NSLog(@"Error value: %x",logVal&0x3fff);
}

-(void)bluetoothConnect: (IOBluetoothDevice*)device
{
            self.phone = [[IOBluetoothHandsFreeDevice alloc] initWithDevice:device
                                                                                              delegate:self];
            if(self.phone){
                NSLog(@"Connected!");
                
                [self.phone connect];
                NSLog(@"Input volume: %f",self.phone.inputVolume);
                NSLog(@"Output volume: %f",self.phone.outputVolume);
            }else{
                NSLog(@"Connection failed");
            }
}


-(void)deviceInquiryComplete:(IOBluetoothDeviceInquiry *)sender error:(IOReturn)error aborted:(BOOL)aborted
{
    if (error != kIOReturnSuccess)
    {
        NSLog(@"Inquiry failed");
        return;
    }
    NSLog(@"Inquiry successful!");
    NSArray* devices = [sender foundDevices];
    for (IOBluetoothDevice* device in devices)
    {
        [device remoteNameRequest:nil];
        NSString* deviceName = device.name;
        NSLog(@"%@", deviceName);
        if ([deviceName containsString:@"Jason's iPhone"])
        {
            NSLog(@"Found it");
            [self bluetoothConnect:device];
            return;
        }

    }
    NSLog(@"Jason's iPhone not found");

}


@end
