//
//  ViewController.h
//  Browsr
//
//  Created by Jason Brooks on 1/17/15.
//  Copyright (c) 2015 Jason Brooks. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>


@property (strong) IBOutlet NSButton *searchButton;
@property (strong) IBOutlet NSButton *connectButton;
@property (nonatomic, strong) NSArray *devices;
@property (nonatomic, strong) NSTableView *devicesTableView;
@property (nonatomic, strong) NSProgressIndicator *indicator;




@end

