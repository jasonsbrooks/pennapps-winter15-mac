//
//  BrowserViewController.m
//  Browsr
//
//  Created by Minh Tri Pham on 1/17/15.
//  Copyright (c) 2015 Jason Brooks. All rights reserved.
//

#import "BrowserViewController.h"
@interface BrowserViewController ()
@property (nonatomic, strong) NSString *url;
@end


@implementation BrowserViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"browsr";
  
}


- (IBAction)urlSearched:(id)sender {
  
  [[self.webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.searchField stringValue]]]];
}

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame {
  if ([self.url rangeOfString:@"http://"].location != NSNotFound) {
    [[self.webView mainFrame] stopLoading];
    self.url = [self.myBC downloadPageWithUrl:[self.searchField stringValue]];
    NSLog(@"downloaded file into: %@", self.url);
    [[self.webView mainFrame] loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    return;
  }
  NSLog(@"loading: %@", self.url);
}







@end
