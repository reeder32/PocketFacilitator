//
//  ElementsDetailViewTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/8/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "ElementsDetailViewTableViewController.h"

@interface ElementsDetailViewTableViewController ()

@end

@implementation ElementsDetailViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailNavItem.title = self.name;
    self.guidelinesTextView.text = self.guidelines;
    [self formatTextData];
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"%@", self.elementDetail);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }else if (section ==1) {
        return 1;
    }else if (section ==2){
        return 1;
    }else{
        return 1;
    }
}
- (IBAction)handleCloseButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)formatTextData{
    NSArray *outcomesArray = [self.desiredOutcomes componentsSeparatedByString:@"*"];
    NSString * outcomesString = [outcomesArray componentsJoinedByString:@" - "];
    self.desiredOutcomesLabel.text = outcomesString;
    
    NSArray *variationsArray = [self.variations componentsSeparatedByString:@","];
    NSString * variationsString = [variationsArray componentsJoinedByString:@".\n"];
    self.variationsTextView.text = variationsString;
    
    NSArray *questionsArray = [self.reflectionQuestions componentsSeparatedByString:@"?"];
    NSString * questionsString = [questionsArray componentsJoinedByString:@"?\n"];
    self.questionsTextView.text = questionsString;
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
