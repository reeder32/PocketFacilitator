//
//  ProfileViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 10/31/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "ProfileViewController.h"
#import "ElementsFromDatabase.h"
#import <Parse/Parse.h>
#import "UserFavoritesTableViewCell.h"
#import "UIColor+UIColor_SynergoColors.h"
#import "SVProgressHUD.h"
#import "ElementsToAddToDayTableViewCell.h"
#import "SavedDayTableViewController.h"
#import "DaysCollectionViewCell.h"
#import "SavedDayInfoViewController.h"


@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIView *createAccountView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (strong, nonatomic) NSMutableArray *daysArray;
@property (strong, nonatomic) NSMutableArray *elementsToAddToDayArray;
@property (weak, nonatomic) IBOutlet UIButton *createDayButton;
@property (weak, nonatomic) IBOutlet UICollectionView *dayCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *explanationLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionViewExplanationLabel;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(queryParse) name:@"QueryParseUser" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(queryParseForDayPlans) name:@"QueryParseDayPlans" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadView) name:@"UserLoggedIn" object:nil];
    self.createDayButton.hidden = true;
    self.explanationLabel.hidden = false;
    self.elementsToAddToDayArray = [[NSMutableArray alloc]init];
    self.createDayButton.layer.borderColor = [UIColor synergoDarkGrayColor].CGColor;
    self.createDayButton.layer.borderWidth = 1.0;
    self.createDayButton.layer.cornerRadius = self.createDayButton.frame.size.width/2;
    [self.createDayButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    // Do any additional setup after loading the view.
    
}
-(void)reloadView{
    if (![PFUser currentUser]) {
        self.logoutButton.enabled = false;
        self.createAccountView.hidden = false;
        self.profileTableView.hidden = true;
        self.elementsToAddToDayTableView.hidden = true;
        self.collectionViewExplanationLabel.hidden = true;
    }else{
        [self queryParse];
        [self queryParseForDayPlans];
        self.logoutButton.enabled = true;
        self.createAccountView.hidden = true;
        self.profileTableView.hidden = false;
        self.elementsToAddToDayTableView.hidden = false;
        
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.profileTableView) {
        return self.favoritesArray.count;
    }else{
        return self.elementsToAddToDayArray.count;
    }
    
}
-(void)queryParse{
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:[PFUser currentUser].username];
    [SVProgressHUD showWithStatus:@"Loading..."];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (!error) {
            [SVProgressHUD dismiss];
            self.favoritesArray = object[@"favorites"];
            [self.profileTableView reloadData];
        }else{
            [self queryLocalDataStore];
        }
    }];
}
-(void)queryLocalDataStore{
    [SVProgressHUD showWithStatus:@"Loading..."];
    PFQuery *userQuery = [PFUser query];
    [userQuery fromLocalDatastore];
    [userQuery fromPinWithName:@"favorites"];
    [userQuery getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (!error) {
            [SVProgressHUD dismiss];
            NSArray *favorites = object[@"favorites"];
            self.favoritesArray = [favorites mutableCopy];
            [SVProgressHUD dismiss];
            [self.profileTableView reloadData];
            
        }else{
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
        
    }];
}
#pragma mark - tableview

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.elementsToAddToDayTableView) {
        return YES;
    }return NO;
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.elementsToAddToDayArray removeObjectAtIndex:indexPath.row];
        [self.elementsToAddToDayTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self checkForArrayCount];
        }
}
-(void)checkForArrayCount{
    if (self.elementsToAddToDayArray.count == 0) {
        self.createDayButton.hidden = true;
        self.explanationLabel.hidden = false;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.profileTableView) {
        return 45;
    }return 0;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *favoritesView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.profileTableView.tableHeaderView.frame.size.width, self.profileTableView.tableHeaderView.frame.size.height)];
    favoritesView.backgroundColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.0f];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 40)];
    [label setFont:[UIFont fontWithName:@"OpenSans-Bold" size:20.0]];
    label.textColor = [UIColor synergoMaroonColor];
    label.text = @"Favorites";
    [favoritesView addSubview:label];
    if (tableView == self.profileTableView) {
        return favoritesView;
    }else{
        return nil;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.profileTableView) {
        UserFavoritesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoritesCell"];
        cell.delegate = self;
        NSString *name = [self.favoritesArray objectAtIndex:indexPath.row];
        cell.nameLabel.text = name;
        return cell;
        
    }else{
        ElementsToAddToDayTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"DayElementsCell" forIndexPath:indexPath];
        
        cell.nameLabel.text = [self.elementsToAddToDayArray objectAtIndex:indexPath.row];
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.profileTableView) {
        UserFavoritesTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self addElementName:cell.nameLabel.text];
    }
}
-(NSString *) elementForIndex:(NSIndexPath*) path
{
    return [self.favoritesArray objectAtIndex:path.row];
    
}
-(NSString *)favoriteForIndex:(NSIndexPath*) path{
    return [self.elementsToAddToDayArray objectAtIndex:path.row];
}
#pragma mark Swipe Delegate

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction;
{
    return YES;
}

-(NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    
    
    
    __weak ProfileViewController * me = self;
    
    UIColor * color = [UIColor synergoDarkGrayColor];
    UIFont * font = [UIFont fontWithName:@"OpenSans-Bold" size:14.0];
    if (direction == MGSwipeDirectionLeftToRight) {
        swipeSettings.transition = MGSwipeTransitionClipCenter;
        swipeSettings.keepButtonsSwiped = NO;
        expansionSettings.buttonIndex = 0;
        expansionSettings.threshold = 1.0;
        expansionSettings.expansionLayout = MGSwipeExpansionLayoutCenter;
        expansionSettings.expansionColor = [UIColor synergoRedColor];
        expansionSettings.triggerAnimation.easingFunction = MGSwipeEasingFunctionCubicOut;
        expansionSettings.fillOnTrigger = NO;
        MGSwipeButton * favoriteButton = [MGSwipeButton buttonWithTitle:@"Add to day" backgroundColor:color padding:15 callback:^BOOL(MGSwipeTableCell *sender) {
            NSString *element = [me elementForIndex:[me.profileTableView indexPathForCell:sender]];
            [self addElementName:element];
            
            
            return YES;
        }];
        
        favoriteButton.titleLabel.font = font;
        
        return @[favoriteButton];
    }
    if (direction == MGSwipeDirectionRightToLeft) {
        swipeSettings.transition = MGSwipeTransition3D;
        
        MGSwipeButton *deleteButton = [MGSwipeButton buttonWithTitle:@"Remove" backgroundColor:[UIColor redColor]padding:15 callback:^BOOL(MGSwipeTableCell *sender) {
            NSString *element = [me elementForIndex:[me.profileTableView indexPathForCell:sender]];
                     
                [self removeElementName:element forIndexPath:[me.profileTableView indexPathForCell:sender]];
            
            return YES;
        }];
        deleteButton.titleLabel.font = font;
        return @[deleteButton];
    }
    
    
    return nil;
    
}

-(void)addElementName:(NSString *) name{
    [self.elementsToAddToDayArray addObject:name];
    [self.elementsToAddToDayTableView reloadData];
    self.createDayButton.hidden = false;
    self.explanationLabel.hidden = true;
    
}
-(void)removeElementName:(NSString *) name forIndexPath:(NSIndexPath *)path{
    [self.favoritesArray removeObjectAtIndex:path.row];
    [[PFUser currentUser]removeObject:name forKey:@"favorites"];
    [[PFUser currentUser]unpinWithName:@"favorites"];
    [[PFUser currentUser]saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"YEAH Muthafucka!");
        }else{
            NSLog(@"Nope! try again %@", error.localizedDescription);
        }
    }];
    
    [self.profileTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationLeft];
    
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

#pragma mark - uicollectionview
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.daysArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PFObject *object = [self.daysArray objectAtIndex:indexPath.row];
    NSDate *date = object[@"date"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateStyle:NSDateFormatterShortStyle];
    
    DaysCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DateCollectionCell" forIndexPath:indexPath];
    cell.layer.cornerRadius = 5.0;
    cell.dateLabel.text = [dateFormat stringFromDate:date];
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"DayDetails" sender:[self.daysArray objectAtIndex:indexPath.row]];
}
-(void)queryParseForDayPlans{
    [self.elementsToAddToDayArray removeAllObjects];
    [self.elementsToAddToDayTableView reloadData];
    [self checkForArrayCount];
    PFQuery *query = [PFQuery queryWithClassName:@"DayPlan"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects) {
            self.daysArray = [objects mutableCopy];
            self.collectionViewExplanationLabel.hidden = true;
            [self.dayCollectionView reloadData];
        }else{
            self.collectionViewExplanationLabel.hidden = false;
        }
    }];
    
}
- (IBAction)handleLogoutButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Log out?" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *logout = [UIAlertAction actionWithTitle:@"Log out" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
            if (!error) {
                [PFObject unpinAllObjectsInBackgroundWithName:@"favorites"];
                [self.daysArray removeAllObjects];
                [self.dayCollectionView reloadData];
                self.logoutButton.enabled = false;
                self.elementsToAddToDayTableView.hidden = true;
                self.profileTableView.hidden = true;
                self.createAccountView.hidden = false;
            }else{
                [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            }
        }];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:logout];
    [alert addAction:cancel];
    [self presentViewController:alert animated:true completion:nil];
    
}
- (IBAction)handleCreateDayButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"CreateDay" sender:nil];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CreateDay"]) {
        SavedDayTableViewController *dvc = segue.destinationViewController;
        dvc.elementsArray = self.elementsToAddToDayArray;
    }if ([segue.identifier isEqualToString:@"DayDetails"]) {
        SavedDayInfoViewController *dvc = segue.destinationViewController;
        PFObject *object = (PFObject *)sender;
        dvc.elementObject = object;
        
       
    }
}



@end
