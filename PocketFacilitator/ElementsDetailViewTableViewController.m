//
//  ElementsDetailViewTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/8/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "ElementsDetailViewTableViewController.h"
#import "UIColor+UIColor_SynergoColors.h"
#import "ElementsFromDatabase.h"
#import <CoreData/CoreData.h>
#import "UIColor+UIColor_SynergoColors.h"
#import "SVProgressHUD.h"
#import "AddFavoriteElementToArray.h"
#import "ProfileViewController.h"



@interface ElementsDetailViewTableViewController ()
@property (nonatomic) NSMutableArray *favorites;
@property (strong, nonatomic) UIView *headerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFavoriteButton;

@end

NSString *path = @"PocketFacilitator.db";

@implementation ElementsDetailViewTableViewController

-(NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = self.name;
    self.navigationItem.backBarButtonItem.tintColor = [UIColor synergoMaroonColor];
    [self formatTextData];
    [self checkCoreData];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkCoreData{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Favorites"];
    NSMutableArray *array = [NSMutableArray array];
    array = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    for (NSManagedObject *object in array) {
        if ([self.name isEqualToString:[object valueForKey:@"name"]]) {
            NSLog(@"title is %@ and name is %@", self.name, [object valueForKey:@"name"]);
            self.addFavoriteButton.enabled = false;
        }
    }
    
    

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.equipment.length >=1) {
        return 5;
    }else{
        return 4;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
- (IBAction)handlePlusButtonPressed:(id)sender {
    
    AddFavoriteElementToArray *addFavorite = [[AddFavoriteElementToArray alloc]init];
    
    [addFavorite addElementNameToCoreData:self.name];
    [self checkCoreData];
    
}
- (IBAction)handleCloseButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)formatTextData{
    
    //set numberOfLines to 0 as default
    self.variationsTitle.numberOfLines = 0;
    self.guidelinesTitle.numberOfLines = 0;
    self.desiredOutcomesTitle.numberOfLines = 0;
    self.reflectionQuestionsTitle.numberOfLines = 0;
    self.equipmentTitle.numberOfLines = 0;
    
    //These do not need formatting
    self.guidelinesTitle.text = self.guidelines;
    
    
    //These need formatting
    NSArray *equipmentArray = [self.equipment componentsSeparatedByString:@"@"];
    if (equipmentArray.count >1) {
        self.equipmentTitle.text = [equipmentArray componentsJoinedByString:@"\n"];
    }else{
        if (self.equipment.length >1) {
            self.equipmentTitle.text = self.equipment;
        }else{
            self.equipmentTitle.text = @"There isn't any equipment needed";
        }
    }
    NSArray *variationsArray = [self.variations componentsSeparatedByString:@"@"];
    NSLog(@"variationsArray is %@", variationsArray);
    if ([[variationsArray objectAtIndex:0]isEqualToString:@""]|| [[variationsArray objectAtIndex:0]isEqualToString:@" "]) {
        self.variationsTitle.text = @"There aren't any variations on file";
    }else{
        NSMutableString *mutString = [[variationsArray componentsJoinedByString:@"\n-"]mutableCopy];
        self.variationsTitle.text = [NSString stringWithFormat:@"-%@", mutString];
        
    }
    
    NSArray *questionsArray = [self.reflectionQuestions componentsSeparatedByString:@"?"];
    NSLog(@"questionsArray is %@", questionsArray);
    if ([[questionsArray objectAtIndex:0]isEqualToString:@""]|| [[questionsArray objectAtIndex:0]isEqualToString:@" "]) {
        self.reflectionQuestionsTitle.text = @"There aren't any reflection questions on file";
        
    }else{
        self.reflectionQuestionsTitle.text = [[questionsArray componentsJoinedByString:@"?\n"]stringByReplacingOccurrencesOfString:@"\n " withString:@""];
    }
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@*"];
    NSArray *desiredOutcomesArray = [self.desiredOutcomes componentsSeparatedByCharactersInSet:set];
    NSMutableString *mutString = [[desiredOutcomesArray componentsJoinedByString:@"\n*"]mutableCopy];
    self.desiredOutcomesTitle.text = [NSString stringWithFormat:@"*%@", mutString];
    NSArray *titleArray = @[self.desiredOutcomesTitle, self.reflectionQuestionsTitle, self.variationsTitle, self.guidelinesTitle, self.equipmentTitle];
    for (UILabel *label in titleArray) {
        [label sizeToFit];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}



@end
