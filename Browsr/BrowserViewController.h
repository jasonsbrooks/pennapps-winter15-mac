//
//  BrowserViewController.h
//  Browsr
//
//  Created by Minh Tri Pham on 1/17/15.
//  Copyright (c) 2015 Jason Brooks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@import WebKit;
#import "BluetoothConnectionViewController.h"

@interface BrowserViewController : NSViewController

@property (nonatomic, strong) BluetoothConnectionViewController *myBC;
@property (strong) IBOutlet NSSearchField *searchField;
@property (strong) IBOutlet WebView *webView;

@end
