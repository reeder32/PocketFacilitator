//
//  AcknowledgementsViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/28/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "AcknowledgementsViewController.h"

@interface AcknowledgementsViewController ()

@end

@implementation AcknowledgementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleDownButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
