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
-(void)viewDidDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.shopSynergoWebView.alpha = 0;
    NSURL *url = [NSURL URLWithString:urlString];
    [self.shopSynergoWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    self.shopSynergoWebView.alpha = 1;
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"There was a problem loading the web page :-("];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [SVProgressHUD showWithStatus:@"Loading"];
    return true;
}
@end
