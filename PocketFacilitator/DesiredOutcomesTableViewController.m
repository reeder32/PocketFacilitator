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
#import "ElementObject.h"
#import "DesiredLearningOutcomesTableViewController.h"

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
    self.desiredOutcomes = [ElementsFromDatabase database].allElementsArray;
    
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


-(void)viewDidAppear:(BOOL)animated{
    [self setUpArraysForTableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpArraysForTableView{
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
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@*"];
    for (ElementObject *element in self.desiredOutcomes) {
        NSString *outcomes = element.desiredOutcomes;
        NSArray *outcomesArray = [outcomes componentsSeparatedByCharactersInSet:set];
        if ([outcomesArray containsObject:@"Trust"]) {
            [trustMutArray addObject:element];
        } if ([outcomesArray containsObject:@"Communication"]){
            [commMutArray addObject:element];
        } if ([outcomesArray containsObject:@"Teamwork"]){
            [teamMutArray addObject:element];
        } if ([outcomesArray containsObject:@"Listening Skills"]){
            [listenMutArray addObject:element];
        } if ([outcomesArray containsObject:@"Self-Awareness"]){
            [selfAwareMutArray addObject:element];
        } if ([outcomesArray containsObject:@"Conflict Resolution"]){
            [conflictMutArray addObject:element];
        } if ([outcomesArray containsObject:@"Comfort Zones"]){
            [comfortZoneMutArray addObject:element];
        } if ([outcomesArray containsObject:@"Leadership"]){
            [learderShipArray addObject:element];
        } if ([outcomesArray containsObject:@"Interpersonal Skills"]){
            [interpersonalMutArray addObject:element];
        }else{
            [otherArray addObject:element];
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
#pragma mark - Tableview Selection Methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"TrustSegue" sender:nil];
    }else if (indexPath.row == 1){
        [self performSegueWithIdentifier:@"CommunicationSegue" sender:nil];
    }else if (indexPath.row ==2){
        [self performSegueWithIdentifier:@"LeadershipSegue" sender:nil];
    }else if (indexPath.row ==3){
        [self performSegueWithIdentifier:@"TeamworkSegue" sender:nil];
    }else if (indexPath.row ==4){
        [self performSegueWithIdentifier:@"ListeningSegue" sender:nil];
    }else if (indexPath.row ==5){
        [self performSegueWithIdentifier:@"SelfAwareSegue" sender:nil];
    }else if (indexPath.row ==6){
        [self performSegueWithIdentifier:@"InterpersonalSegue" sender:nil];
    }else if (indexPath.row ==7){
        [self performSegueWithIdentifier:@"ConflictSegue" sender:nil];
    }else{
        [self performSegueWithIdentifier:@"ComfortSegue" sender:nil];
    }
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     DesiredLearningOutcomesTableViewController *dvc = segue.destinationViewController;
     if ([segue.identifier isEqualToString:@"TrustSegue"]) {
         dvc.navigationItem.title = @"Trust";
         dvc.outcomesArray = self.trustArray;
     }else if ([segue.identifier isEqualToString:@"CommunicationSegue"]){
         dvc.navigationItem.title = @"Communication";
         dvc.outcomesArray = self.communicationArray;
     }else if ([segue.identifier isEqualToString:@"LeadershipSegue"]){
         dvc.navigationItem.title = @"Leadership";
         dvc.outcomesArray = self.leadershipArray;
     }else if ([segue.identifier isEqualToString:@"TeamworkSegue"]){
         dvc.navigationItem.title = @"Teamwork";
         dvc.outcomesArray = self.teamworkArray;
     }else if ([segue.identifier isEqualToString:@"ListeningSegue"]){
         dvc.navigationItem.title = @"Listening Skills";
         dvc.outcomesArray = self.listeningSkillsArray;
     }else if ([segue.identifier isEqualToString:@"SelfAwareSegue"]){
         dvc.navigationItem.title = @"Self-Awareness";
         dvc.outcomesArray = self.selfAwarenessArray;
     }else if ([segue.identifier isEqualToString:@"InterpersonalSegue"]){
         dvc.navigationItem.title = @"Interpersonal Skills";
         dvc.outcomesArray = self.interpersonalSkillsArray;
     }else if ([segue.identifier isEqualToString:@"ConflictSegue"]){
         dvc.navigationItem.title = @"Conflict Resolution";
         dvc.outcomesArray = self.conflictResolutionArray;
     }else{
         dvc.navigationItem.title = @"Comfort Zones";
         dvc.outcomesArray = self.comfortZonesArray;
     }
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 


@end
