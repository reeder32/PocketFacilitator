//
//  SearchElementsTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/8/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import "SearchElementsTableViewController.h"
#import "ElementsFromDatabase.h"
#import "SearchTableViewCell.h"
#import "UIColor+UIColor_SynergoColors.h"
#import "ElementObject.h"
#import "ElementsDetailViewTableViewController.h"
#import "AddFavoriteElementToArray.h"


@interface SearchElementsTableViewController ()
@property (strong, nonatomic) NSArray *allElementsArray;
@property (strong, nonatomic) NSArray *originalArray;
@end

@implementation SearchElementsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allElementsArray = [ElementsFromDatabase database].allElementsArray;
    self.originalArray = self.allElementsArray;
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

    return self.allElementsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCell" forIndexPath:indexPath];
    cell.swipeBackgroundColor = [UIColor synergoLightGrayColor];
    cell.delegate = self;
    cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
    cell.nameLabel.text = [[self.allElementsArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    // Configure the cell...
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowElementDetail" sender:[self.allElementsArray objectAtIndex:indexPath.row]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowElementDetail"]) {
        ElementObject *element = (ElementObject *)sender;
        ElementsDetailViewTableViewController *dvc = segue.destinationViewController;
        NSString *name = element.name;
        NSString *guidelines = element.guidelines;
        NSString *questions = element.reflectionQuestions;
        NSString *desiredOutcomes = element.desiredOutcomes;
        NSString *variations = element.variations;
        
        NSLog(@"%@ %@ %@ %@ %@", name, guidelines, questions, desiredOutcomes, variations);
        dvc.elementObject = element;
        dvc.name = name;
        dvc.guidelines = guidelines;
        dvc.reflectionQuestions = questions;
        dvc.desiredOutcomes = desiredOutcomes;
        dvc.variations = variations;
    }
}

#pragma mark - Search Bar Delegate Methods
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.allElementsArray = self.originalArray;
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
    NSArray *filteredElements = [self.allElementsArray filteredArrayUsingPredicate:predicate];
    self.allElementsArray = filteredElements;
    [self.tableView reloadData];
}
-(ElementObject *) elementForIndex:(NSIndexPath*) path
{
    return [self.allElementsArray objectAtIndex:path.row];
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
    
    __weak SearchElementsTableViewController * me = self;
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
