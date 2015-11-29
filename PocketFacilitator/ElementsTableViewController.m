//
//  ElementsTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/12/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "ElementsTableViewController.h"
#import "UIColor+UIColor_SynergoColors.h"
#import "Favorites.h"
#import "LeftMenuViewController.h"


@interface ElementsTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@end

@implementation ElementsTableViewController

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
#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.superview.backgroundColor = [[UIColor synergoLightGrayColor]colorWithAlphaComponent:.2];
}
-(void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.superview.backgroundColor = [UIColor whiteColor];
}
@end
