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



@interface ElementsTableViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;
@end

@implementation ElementsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
