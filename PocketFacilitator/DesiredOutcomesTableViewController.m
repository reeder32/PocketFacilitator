//
//  DesiredOutcomesTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/5/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "DesiredOutcomesTableViewController.h"
#import "UIColor+UIColor_SynergoColors.h"
#import "ElementsFromDatabase.h"
#import "DesiredLearningOutcomesObject.h"

@interface DesiredOutcomesTableViewController ()
@property NSArray *desiredOutcomes;
@property NSArray *trustArray;
@property NSArray *communicationArray;
@property NSArray *leadershipArray;
@property NSArray *teamworkArray;
@property NSArray *listeningSkillsArray;
@property NSArray *selfAwarenessArray;
@property NSArray *interpersonalSkillsArray;
@property NSArray *conflictResolutionArray;
@property NSArray *comfortZonesArray;
@end

@implementation DesiredOutcomesTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //* un-comment when i need a list of font names
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }

    self.tableView.preservesSuperviewLayoutMargins = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    self.desiredOutcomes = [ElementsFromDatabase database].desiredOutcomesArray;
}
-(void)viewDidAppear:(BOOL)animated{
    NSMutableArray *trustMutArray = [NSMutableArray array];
    NSMutableArray *commMutArray = [NSMutableArray array];
    NSMutableArray *learderShipArray = [NSMutableArray array];
    NSMutableArray *teamMutArray = [NSMutableArray array];
    NSMutableArray *listenMutArray = [NSMutableArray array];
    NSMutableArray *selfAwareMutArray = [NSMutableArray array];
    NSMutableArray *interpersonalMutArray = [NSMutableArray array];
    NSMutableArray *conflictMutArray = [NSMutableArray array];
    NSMutableArray *comfortZoneMutArray = [NSMutableArray array];
    NSMutableArray *otherArray = [NSMutableArray array];
    for (DesiredLearningOutcomesObject *object in self.desiredOutcomes) {
        NSString *outcomes = object.desiredOutcomes;
        NSArray *outcomesArray = [outcomes componentsSeparatedByString:@"@"];
        NSLog(@"outcomesArray is %@", outcomesArray);
        if ([outcomesArray containsObject:@"Trust"]) {
            [trustMutArray addObject:object];
        } if ([outcomesArray containsObject:@"Communication"]){
            [commMutArray addObject:object];
        } if ([outcomesArray containsObject:@"Teamwork"]){
            [teamMutArray addObject:object];
        } if ([outcomesArray containsObject:@"Listening Skills"]){
            [listenMutArray addObject:object];
        } if ([outcomesArray containsObject:@"Self-Awareness"]){
            [selfAwareMutArray addObject:object];
        } if ([outcomesArray containsObject:@"Conflict Resolution"]){
            [conflictMutArray addObject:object];
        } if ([outcomesArray containsObject:@"Comfort Zones"]){
            [comfortZoneMutArray addObject:object];
        } if ([outcomesArray containsObject:@"Leadership"]){
            [learderShipArray addObject:object];
        } if ([outcomesArray containsObject:@"Interpersonal Skills"]){
            [interpersonalMutArray addObject:object];
        }else{
            [otherArray addObject:object];
        }
    }
    
    self.trustArray = trustMutArray;
    self.communicationArray = commMutArray;
    self.leadershipArray = learderShipArray;
    self.teamworkArray = teamMutArray;
    self.listeningSkillsArray = listenMutArray;
    self.selfAwarenessArray = selfAwareMutArray;
    self.interpersonalSkillsArray = interpersonalMutArray;
    self.conflictResolutionArray = conflictMutArray;
    self.comfortZonesArray = comfortZoneMutArray;
     NSLog(@"trustArray is %@", self.trustArray);
     NSLog(@"communicationArray is %@", self.communicationArray);
     NSLog(@"leadershipArray is %@", self.leadershipArray);
     NSLog(@"teamworkArray is %@", self.teamworkArray);
     NSLog(@"listeningArray is %@", self.listeningSkillsArray);
     NSLog(@"selfawarenessArray is %@", self.selfAwarenessArray);
     NSLog(@"interpersnalArray is %@", self.interpersonalSkillsArray);
     NSLog(@"conflictArray is is %@", self.conflictResolutionArray);
     NSLog(@"comfortZoneArray is %@", self.comfortZonesArray);
    
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
    
    return 9;
}
-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.superview.backgroundColor = [[UIColor synergoLightGrayColor]colorWithAlphaComponent:.2];
   
}

-(void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.superview.backgroundColor = [UIColor whiteColor];
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
