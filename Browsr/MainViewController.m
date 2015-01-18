//
//  ViewController.m
//  Browsr
//
//  Created by Jason Brooks on 1/17/15.
//  Copyright (c) 2015 Jason Brooks. All rights reserved.
//

#import "MainViewController.h"
#import "BrowserViewController.h"
#import "BluetoothConnectionViewController.h"
@interface MainViewController ()

@property BOOL searching;
@property (nonatomic, strong) BluetoothConnectionViewController *myBC;
@end
@implementation MainViewController

#define MARGIN 10

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"ninja";
  [self.view setAutoresizingMask:NSViewNotSizable];
  self.connectButton.alphaValue = 0;
  // Do any additional setup after loading the view.
}

- (void)viewDidAppear {
  //  [self performSegueWithIdentifier:@"showBrowser" sender:self];
}

- (void)prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"showBrowser"]) {
    BrowserViewController *vc = segue.destinationController;
    vc.myBC = self.myBC;
  }
  
}


- (void)setupChooseDevice {
  
  NSScrollView *tableContainer = [[NSScrollView alloc] initWithFrame:NSMakeRect(MARGIN, MARGIN, self.view.frame.size.width-2*MARGIN, self.view.frame.size.height-3*MARGIN-self.searchButton.frame.size.height)];
  self.devicesTableView = [[NSTableView alloc] initWithFrame:NSMakeRect(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
  
  
  NSTableColumn *column =[[NSTableColumn alloc]initWithIdentifier:@"Devices"];
  column.width = tableContainer.frame.size.width;
  [column.headerCell setTitle:@"   Devices"];
  [self.devicesTableView addTableColumn:column];
  
  self.devicesTableView.dataSource = self;
  self.devicesTableView.delegate = self;
  [tableContainer setDocumentView:self.devicesTableView];
  tableContainer.alphaValue = 0;
  [self.view addSubview:tableContainer];
  
  [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
    context.duration = 0.3;
    self.searchButton.animator.frame = NSMakeRect(MARGIN, self.view.frame.size.height - MARGIN - self.searchButton.frame.size.height, self.connectButton.frame.size.width, self.searchButton.frame.size.height);
    self.searchButton.title = @"Refresh";
    self.connectButton.animator.frame = NSMakeRect(self.view.frame.size.width - MARGIN - self.connectButton.frame.size.width, self.view.frame.size.height - MARGIN - self.connectButton.frame.size.height, self.connectButton.frame.size.width, self.connectButton.frame.size.height);
    
    
    self.connectButton.alphaValue = 1;
    
  } completionHandler:^{
    [self.searchButton setFrame:NSMakeRect(MARGIN, self.view.frame.size.height - MARGIN - self.searchButton.frame.size.height, self.searchButton.frame.size.width, self.searchButton.frame.size.height)
     ];
    NSLog(@"%f, %f", self.searchButton.frame.origin.x, self.searchButton.frame.origin.y);
    
    tableContainer.alphaValue = 1;
  }];
  
  
  
  
}

- (IBAction)connectBluetooth:(id)sender {
  if (!self.searching) {
    [self setupChooseDevice];
    self.searching = YES;
  }
  
  if (self.indicator && self.indicator.alphaValue == 1)
    return;
  
  if (!self.indicator) {
    self.indicator = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(self.view.frame.size.width/2 - 15, self.devicesTableView.frame.size.height/2 + 15, 30, 30)];
    self.indicator.style = NSProgressIndicatorSpinningStyle;
    [self.view addSubview:self.indicator];
  }
  self.indicator.alphaValue = 1;
  [self.indicator startAnimation:nil];
  BluetoothConnectionViewController* bc = [[BluetoothConnectionViewController alloc] init];
  self.myBC = bc;
  self.myBC.vc = self;
  [self.myBC bluetoothSearch];
  
  
  
}

- (IBAction)poundKey:(id)sender {
  NSInteger row = [self.devicesTableView selectedRow];
  if (row < 0 || row >= [self.devices count])
    return;
  [self.myBC bluetoothConnect:[self.devices objectAtIndex:[self.devicesTableView selectedRow]]];
  [self performSegueWithIdentifier:@"showBrowser" sender:sender];
}

#pragma mark Data Source

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  
  return [self.devices count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  IOBluetoothDevice *device = self.devices[row];
  return device.name;
}



@end
