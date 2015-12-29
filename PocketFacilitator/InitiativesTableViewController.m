//
//  InitiativesTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/28/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "InitiativesTableViewController.h"
#import "ElementsFromDatabase.h"
#import "InitiativesDetails.h"
#import "InitiativesTableViewCell.h"
#import "ElementsDetailViewTableViewController.h"

@interface InitiativesTableViewController ()
@property (strong, nonatomic) NSArray *initiativesArray;
@end

@implementation InitiativesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.initiativesArray = [ElementsFromDatabase database].initiativesArray;
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

    return self.initiativesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InitiativesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InitiativesCell" forIndexPath:indexPath];
    cell.elementNameLabel.text = [[self.initiativesArray objectAtIndex:indexPath.row ] valueForKey:@"name"];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowInitiativesDetails" sender:[self.initiativesArray objectAtIndex:indexPath.row]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ([segue.identifier isEqualToString:@"ShowInitiativesDetails"]) {
         InitiativesDetails *detail = (InitiativesDetails *)sender;
        ElementsDetailViewTableViewController *dvc = segue.destinationViewController;
        NSString *name = detail.name;
        NSString *guidelines = detail.guidelines;
        NSString *questions = detail.reflectionQuestions;
        NSString *desiredOutcomes = detail.desiredOutcomes;
        NSString *variations = detail.variations;
        NSString *equipment = detail.equipment;
        
        NSLog(@"%@ %@ %@ %@ %@", name, guidelines, questions, desiredOutcomes, variations);
        dvc.name = name;
        dvc.guidelines = guidelines;
        dvc.reflectionQuestions = questions;
        dvc.desiredOutcomes = desiredOutcomes;
        dvc.variations = variations;
        dvc.equipment = equipment;
    }

}


@end
