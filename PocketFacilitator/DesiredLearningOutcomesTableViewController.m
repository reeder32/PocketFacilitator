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
#import "AddFavoriteElementToArray.h"

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
    cell.swipeBackgroundColor = [UIColor synergoLightGrayColor];
    cell.delegate = self;
    cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
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
-(ElementObject *) elementForIndex:(NSIndexPath*) path
{
    return [self.outcomesArray objectAtIndex:path.row];
}
#pragma mark Swipe Delegate

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction;
{
    return YES;
}

-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    
    swipeSettings.transition = MGSwipeTransitionClipCenter;
    swipeSettings.keepButtonsSwiped = NO;
    expansionSettings.buttonIndex = 0;
    expansionSettings.threshold = 1.0;
    expansionSettings.expansionLayout = MGSwipeExpansionLayoutCenter;
    expansionSettings.expansionColor = [UIColor synergoMaroonColor];
    expansionSettings.triggerAnimation.easingFunction = MGSwipeEasingFunctionCubicOut;
    expansionSettings.fillOnTrigger = NO;
    
    __weak DesiredLearningOutcomesTableViewController * me = self;
    AddFavoriteElementToArray *addFav = [[AddFavoriteElementToArray alloc]init];
    UIColor * color = [UIColor synergoLightGrayColor];
    UIFont * font = [UIFont fontWithName:@"OpenSans-Bold" size:14.0];
    if (direction == MGSwipeDirectionLeftToRight) {
        MGSwipeButton * favoriteButton = [MGSwipeButton buttonWithTitle:@"Favorite" backgroundColor:color padding:15 callback:^BOOL(MGSwipeTableCell *sender) {
            ElementObject * element = [me elementForIndex:[me.tableView indexPathForCell:sender]];
            NSLog(@"Save Element: %@", element.name);
            [addFav addElementNameToCoreData:element.name];
            return YES;
        }];
        favoriteButton.titleLabel.font = font;
        
        return @[favoriteButton];
    }
    
    
    return nil;
    
}

-(void) swipeTableCell:(MGSwipeTableCell*) cell didChangeSwipeState:(MGSwipeState)state gestureIsActive:(BOOL)gestureIsActive
{
    NSString * str;
    switch (state) {
        case MGSwipeStateNone: str = @"None"; break;
        case MGSwipeStateSwippingLeftToRight: str = @"SwippingLeftToRight"; break;
        case MGSwipeStateSwippingRightToLeft: str = @"SwippingRightToLeft"; break;
        case MGSwipeStateExpandingLeftToRight: str = @"ExpandingLeftToRight"; break;
        case MGSwipeStateExpandingRightToLeft: str = @"ExpandingRightToLeft"; break;
    }
    NSLog(@"Swipe state: %@ ::: Gesture: %@", str, gestureIsActive ? @"Active" : @"Ended");
}



@end
