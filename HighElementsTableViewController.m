//
//  HighElementsTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/6/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "HighElementsTableViewController.h"
#import "ElementsFromDatabase.h"
#import "HighElementsDetails.h"
#import "ElementsTableViewCell.h"
#import "ElementsDetailViewTableViewController.h"

@interface HighElementsTableViewController ()
@property NSArray *highElementsArray;
@end

@implementation HighElementsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.highElementsArray = [ElementsFromDatabase database].highElementsArray;
    self.tableView.rowHeight = 50;
    [self.tableView reloadData];

}

-(void)viewDidAppear:(BOOL)animated{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.highElementsArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ElementsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HighElementsCell" forIndexPath:indexPath];
    cell.elementNameLabel.text = [[self.highElementsArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowHighElementsDetails" sender:[self.highElementsArray objectAtIndex:indexPath.row]];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowHighElementsDetails"]) {
        HighElementsDetails *detail = (HighElementsDetails *)sender;
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
