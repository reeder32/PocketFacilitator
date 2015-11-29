//
//  LegalTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/29/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "LegalTableViewController.h"

@interface LegalTableViewController ()

@end

@implementation LegalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (IBAction)handleDownArrowPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
