//
//  IceBreakersTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/28/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "IceBreakersTableViewController.h"
#import "ElementsFromDatabase.h"
#import "ElementsDetailViewTableViewController.h"
#import "IceBreakersTableViewCell.h"
#import "UIColor+UIColor_SynergoColors.h"
#import "AddFavoriteElementToArray.h"

@interface IceBreakersTableViewController ()
@property (strong, nonatomic) NSArray *iceBreakersArray;
@property (strong, nonatomic) NSArray *originalArray;

@end

@implementation IceBreakersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iceBreakersArray = [ElementsFromDatabase database].iceBreakersArray;
    self.originalArray = self.iceBreakersArray;
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

    return self.iceBreakersArray.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowIceBreakersDetails" sender:[self.iceBreakersArray objectAtIndex:indexPath.row]];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IceBreakersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IceBreakersCell" forIndexPath:indexPath];
    
    cell.elementNameLabel.text = [[self.iceBreakersArray objectAtIndex:indexPath.row ] valueForKey:@"name"];
    cell.swipeBackgroundColor = [UIColor synergoLightGrayColor];
    cell.delegate = self;
    cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
    // Configure the cell...
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowIceBreakersDetails"]) {
        ElementObject *element = (ElementObject *)sender;
        ElementsDetailViewTableViewController *dvc = segue.destinationViewController;
        NSString *name = element.name;
        NSString *guidelines = element.guidelines;
        NSString *questions = element.reflectionQuestions;
        NSString *desiredOutcomes = element.desiredOutcomes;
        NSString *variations = element.variations;
        NSString *equipment = element.equipment;
        
        NSLog(@"%@ %@ %@ %@ %@", name, guidelines, questions, desiredOutcomes, variations);
        dvc.elementObject = element;
        dvc.name = name;
        dvc.guidelines = guidelines;
        dvc.reflectionQuestions = questions;
        dvc.desiredOutcomes = desiredOutcomes;
        dvc.variations = variations;
        dvc.equipment = equipment;
    }
    
}
#pragma mark - Search Bar Delegate Methods
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.iceBreakersArray = self.originalArray;
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
    NSArray *filteredElements = [self.iceBreakersArray filteredArrayUsingPredicate:predicate];
    self.iceBreakersArray = filteredElements;
    [self.tableView reloadData];
}
-(ElementObject *) elementForIndex:(NSIndexPath*) path
{
    return [self.iceBreakersArray objectAtIndex:path.row];
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
    
    __weak IceBreakersTableViewController * me = self;
    AddFavoriteElementToArray *addFav = [[AddFavoriteElementToArray alloc]init];
    UIColor * color = [UIColor synergoLightGrayColor];
    UIFont * font = [UIFont fontWithName:@"OpenSans-Bold" size:14.0];
    if (direction == MGSwipeDirectionLeftToRight) {
        MGSwipeButton * favoriteButton = [MGSwipeButton buttonWithTitle:@"Favorite" backgroundColor:color padding:15 callback:^BOOL(MGSwipeTableCell *sender) {
            ElementObject * element = [me elementForIndex:[me.tableView indexPathForCell:sender]];
            NSLog(@"Save Element: %@", element.name);
            [addFav addElementName:element.name toUser:[PFUser currentUser]];
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
