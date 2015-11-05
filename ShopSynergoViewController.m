//
//  ShopSynergoViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 10/31/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "ShopSynergoViewController.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "Reachability.h"


@interface ShopSynergoViewController ()

@end

@implementation ShopSynergoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://yhst-132339165737199.stores.yahoo.net/equipment.html"];
    [self webPageHasLoaded:url];
}
-(BOOL)prefersStatusBarHidden{
    return true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkForInternetConnection{
    Reachability *reachability = [Reachability reachabilityForInternetConnection]
    [reachability startNotifier];
}


-(BOOL)webPageHasLoaded:(NSURL *)url{
    
    if (url) {
        [SVProgressHUD showWithStatus:@"Loading..."];
        [SVProgressHUD dismissWithDelay:3.0];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.shopSynergoWebView loadRequest:request];
        return true;
    }else{
    
    
    return false;
    }
}


@end
