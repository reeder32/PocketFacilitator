//
//  LowElementsTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/6/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "LowElementsTableViewController.h"
#import "LowElementsDetails.h"
#import "ElementsFromDatabase.h"
#include "LowElementsTableViewCell.h"
#import "ElementsDetailViewTableViewController.h"


@interface LowElementsTableViewController ()

@end

@implementation LowElementsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lowElementsArray = [ElementsFromDatabase database].lowElementsArray;
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
    return self.lowElementsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LowElementsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LowElementsCell" forIndexPath:indexPath];
    cell.nameLabel.text = [[self.lowElementsArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowLowElementsDetails" sender:[self.lowElementsArray objectAtIndex:indexPath.row]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowLowElementsDetails"]) {
        LowElementsDetails *detail = (LowElementsDetails *)sender;
        ElementsDetailViewTableViewController *dvc = segue.destinationViewController;
        NSString *name = detail.name;
        NSString *guidelines = detail.guidelines;
        NSString *questions = detail.reflectionQuestions;
        NSString *desiredOutcomes = detail.desiredOutcomes;
        NSString *variations = detail.variations;
        
        NSLog(@"%@ %@ %@ %@ %@", name, guidelines, questions, desiredOutcomes, variations);
        dvc.name = name;
        dvc.guidelines = guidelines;
        dvc.reflectionQuestions = questions;
        dvc.desiredOutcomes = desiredOutcomes;
        dvc.variations = variations;
    }
}


@end
