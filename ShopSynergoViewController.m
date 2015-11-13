//
//  ShopSynergoViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 10/31/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "ShopSynergoViewController.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import <WebKit/WebKit.h>



@interface ShopSynergoViewController ()

@end
static NSString *urlString = @"http://yhst-132339165737199.stores.yahoo.net/equipment.html";
@implementation ShopSynergoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [SVProgressHUD showWithStatus:@"Loading"];
    self.shopSynergoWebView.alpha = 0;
    NSURL *url = [NSURL URLWithString:urlString];
    [self.shopSynergoWebView loadRequest:[NSURLRequest requestWithURL:url]];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"Almost there..."];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.shopSynergoWebView.alpha = 1;
    [SVProgressHUD showSuccessWithStatus:@"Enjoy!"];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"There was a problem loading the web page :-("];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return true;
}
@end
