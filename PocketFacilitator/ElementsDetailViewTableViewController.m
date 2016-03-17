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
#import "UIColor+UIColor_SynergoColors.h"
#import "SVProgressHUD.h"
#import "UserSettings.h"
#import "ProfileViewController.h"



@interface ElementsDetailViewTableViewController ()
@property (nonatomic) NSMutableArray *favorites;
@property (strong, nonatomic) UIView *headerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addFavoriteButton;
@property UserSettings *userSettings;

@end

NSString *path = @"PocketFacilitator.db";

@implementation ElementsDetailViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userSettings = [[UserSettings alloc]init];
    [self.userSettings loadUserFavorites];
    self.navBar.title = self.name;
    self.navigationItem.backBarButtonItem.tintColor = [UIColor synergoMaroonColor];
    [self formatTextData];

}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"self.userSettings.favoritesArray is %@ and self.name is %@", self.userSettings.favoritesArray, self.name);
    if ([self.userSettings.favoritesArray containsObject:self.name]) {
        self.addFavoriteButton.enabled = false;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    self.addFavoriteButton.enabled = false;
    [self.userSettings addUserFavorite:self.name];
 
    
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
