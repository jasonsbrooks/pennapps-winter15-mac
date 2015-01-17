//
//  ViewController.m
//  Browsr
//
//  Created by Jason Brooks on 1/17/15.
//  Copyright (c) 2015 Jason Brooks. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction) connectBluetooth:(id)sender {
    NSLog(@"BUTTON");
    BluetoothConnection* bc = [[BluetoothConnection alloc] init];
    [self setMyBC:bc];
    [self.myBC bluetoothSearch];
    
    
}

- (IBAction) poundKey:(id)sender {
    NSLog(@"POUND");
    [self.myBC.phone sendDTMF:@"1"];
}

@end
