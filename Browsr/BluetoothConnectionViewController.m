//
//  BluetoothConnection.m
//  Browsr
//
//  Created by Jason Brooks on 1/17/15.
//  Copyright (c) 2015 Jason Brooks. All rights reserved.
//

#import "BluetoothConnectionViewController.h"
@interface BluetoothConnectionViewController ()

@property (nonatomic, strong) NSArray *devices;
@property (nonatomic, strong) NSFileManager *fileManager;
@end
@implementation BluetoothConnectionViewController

#define BASE_PATH @"/Library/Caches/Yale.Browsr"

- (NSFileManager *)fileManager {
  if (!_fileManager) {
    _fileManager = [[NSFileManager alloc] init];
  }
  return _fileManager;
}

- (void) bluetoothSearch {
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

- (void)bluetoothConnect: (IOBluetoothDevice*)device {
  self.phone = [[IOBluetoothHandsFreeDevice alloc] initWithDevice:device
                                                         delegate:self];
  if (self.phone) {
    NSLog(@"Connected!");
    
    [self.phone connect];
    NSLog(@"Input volume: %f",self.phone.inputVolume);
    NSLog(@"Output volume: %f",self.phone.outputVolume);
  }else{
    NSLog(@"Connection failed");
  }
}


- (void)deviceInquiryComplete:(IOBluetoothDeviceInquiry *)sender error:(IOReturn)error aborted:(BOOL)aborted {
  if (error != kIOReturnSuccess)
  {
    NSLog(@"Inquiry failed");
    return;
  }
  
  NSLog(@"Inquiry successful!");
  self.devices = [sender foundDevices];
  self.vc.devices = self.devices;
  [self.vc.devicesTableView reloadData];
  [self.vc.indicator stopAnimation:nil];
  self.vc.indicator.alphaValue = 0;
}
- (NSString *)downloadPageWithUrl:(NSString *)url {
  NSLog(@"downloading page...");
  //download file
  NSString *response = @"<html><body>hello world, baby</body></html>";
  
  NSError *error;
  if (![self.fileManager fileExistsAtPath:BASE_PATH isDirectory:nil]) {
    [self.fileManager createDirectoryAtPath:BASE_PATH withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
      NSLog(@"Error: %@", [error localizedDescription]);
    }
  }
  
  NSString *urlWithoutSlashes = [url stringByReplacingOccurrencesOfString:@"/" withString:@""];
  NSString *path = [NSString stringWithFormat:@"%@/%@.html", BASE_PATH, urlWithoutSlashes];
  [response writeToFile:path atomically:YES encoding:NSStringEncodingConversionExternalRepresentation error:&error];
  if (error) {
    NSLog(@"Error: %@", [error localizedDescription]);
  }
  
  return path;
  
}


@end
