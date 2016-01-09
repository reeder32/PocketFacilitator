//
//  DesiredLearningOutcomesTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 12/28/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "DesiredLearningOutcomesTableViewController.h"
#import "DesiredLearningOutcomesTableViewCell.h"
#import "ElementObject.h"
#import "UIColor+UIColor_SynergoColors.h"
#import "ElementsDetailViewTableViewController.h"
#import "UIColor+UIColor_SynergoColors.h"

@interface DesiredLearningOutcomesTableViewController ()
@property NSArray *originalArray;
@end

@implementation DesiredLearningOutcomesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originalArray = self.outcomesArray;
    
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

    return self.outcomesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DesiredLearningOutcomesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DesiredLearningOutcomesCell" forIndexPath:indexPath];
    ElementObject *object = [self.outcomesArray objectAtIndex:indexPath.row];
    cell.outcomeLabel.textColor = [UIColor synergoDarkGrayColor];
    cell.outcomeLabel.text = object.name;
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowDetail" sender:[self.outcomesArray objectAtIndex:indexPath.row]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        ElementObject *element = (ElementObject *)sender;
        ElementsDetailViewTableViewController *dvc = segue.destinationViewController;
        NSString *name = element.name;
        NSString *guidelines = element.guidelines;
        NSString *variations = element.variations;
        NSString *desiredOutcomes = element.desiredOutcomes;
        NSString *reflectionQuestions = element.reflectionQuestions;
        NSString *equipment = element.equipment;
        
        NSLog(@"%@ %@ %@ %@ %@", name, guidelines, reflectionQuestions, desiredOutcomes, variations);
        dvc.name = name;
        dvc.guidelines = guidelines;
        dvc.variations = variations;
        dvc.desiredOutcomes = desiredOutcomes;
        dvc.reflectionQuestions = reflectionQuestions;
        if (equipment) {
            dvc.equipment = equipment;
        }
        

    }
}
#pragma mark - Search Bar Delegate Methods
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.outcomesArray = self.originalArray;
    searchBar.showsCancelButton = false;
    [self.tableView reloadData];
    searchBar.text = @"";
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.tintColor = [UIColor synergoRedColor];
    [searchBar setShowsCancelButton:true animated:true];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:false animated:true];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",
                              searchText];
    NSArray *filteredElements = [self.outcomesArray filteredArrayUsingPredicate:predicate];
    self.outcomesArray = filteredElements;
    [self.tableView reloadData];
}



@end
