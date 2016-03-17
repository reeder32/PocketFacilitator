//
//  ProfileViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 10/31/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "ProfileViewController.h"
#import "ElementsFromDatabase.h"
#import "UserFavoritesTableViewCell.h"
#import "UIColor+UIColor_SynergoColors.h"
#import "SVProgressHUD.h"
#import "ElementsToAddToDayTableViewCell.h"
#import "SavedDayTableViewController.h"
#import "DaysCollectionViewCell.h"
#import "SavedDayInfoViewController.h"
#import "DayPlanTableViewCell.h"
#import "AWSIdentityManager.h"
#import <AWSCore/AWSCore.h>
#import "UserSettings.h"


@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIView *createAccountView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (strong, nonatomic) NSMutableArray *daysArray;
@property (strong, nonatomic) NSMutableArray *elementsToAddToDayArray;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property UserSettings *userSettings;

@property (weak, nonatomic) IBOutlet UILabel *addFromFavoritesLabel;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadView];
    self.facebookButton.layer.cornerRadius = 4.0;
    self.userSettings = [[UserSettings alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadUserData) name:@"UserAddedElementToFavorites" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(queryUserDayPlans) name:@"QueryUserDayPlans" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadView) name:@"UserLoggedIn" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(eraseElementsToAddToDayArray) name:@"EraseArray" object:nil];
    [self checkForArrayCount];
    
    self.elementsToAddToDayArray = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
    
}
-(void)reloadView{
    AWSIdentityManager *identityManager = [AWSIdentityManager sharedInstance];

    NSLog(@"%@", identityManager.userName);
    if (identityManager.userName == nil) {
        self.logoutButton.enabled = false;
        self.createAccountView.hidden = false;
        self.profileTableView.hidden = true;
      
    }else{
        [self loadUserData];
        [self queryUserDayPlans];
        self.logoutButton.enabled = true;
        self.createAccountView.hidden = true;
        self.profileTableView.hidden = false;
    
        
    }

}
-(void)viewDidDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
    
}
-(void)loadUserData{
    
    UserSettings *settings = [[UserSettings alloc]init];
    [settings loadUserFavorites];
    self.favoritesArray = settings.favoritesArray;
    NSLog(@"self.favoritesArray is %@", self.favoritesArray);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)eraseElementsToAddToDayArray{
    [self.elementsToAddToDayArray removeAllObjects];
    [self.profileTableView reloadData];
    [self checkForArrayCount];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 && self.elementsToAddToDayArray.count ==0) {
        return 0;
    }else if (section == 0 && self.elementsToAddToDayArray.count >=1){
        return 1;
    
    }else if (section == 1){
        return self.daysArray.count;
    }else{
        return self.favoritesArray.count;
    }
}

#pragma mark - tableview

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        return YES;
    }else{
        return NO;
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.profileTableView.tableFooterView.frame.size.width, self.profileTableView.tableFooterView.frame.size.height)];
    
    footerView.backgroundColor = [UIColor whiteColor];

    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            if (indexPath.section == 0) {
            [self.elementsToAddToDayArray removeAllObjects];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self checkForArrayCount];
        }
    }
    
}
-(void)checkForArrayCount{
    if (self.elementsToAddToDayArray.count == 0) {
        self.addFromFavoritesLabel.hidden = false;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    if (section == 1 || section ==2) {
        return 60;
    }return 0;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.profileTableView.tableHeaderView.frame.size.width, self.profileTableView.tableHeaderView.frame.size.height)];
    
    headverView.backgroundColor = [UIColor colorWithRed:0.96f green:0.97f blue:0.97f alpha:1.0f];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(8, 30, 182, 17)];
    [label setFont:[UIFont fontWithName:@"OpenSans-Bold" size:12.0]];
    label.textColor = [UIColor synergoMaroonColor];
    [headverView addSubview:label];
    if (section ==1) {
        label.text = @"Saved Days";
        return headverView;
    }else if (section == 2) {
        label.text = @"Favorites";
        return headverView;
    }else{
        return nil;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        ElementsToAddToDayTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"DayElementsCell" forIndexPath:indexPath];
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%lu activites added", (unsigned long)self.elementsToAddToDayArray.count];
        cell.createDayButton.layer.borderColor = [UIColor synergoDarkGrayColor].CGColor;
        cell.createDayButton.layer.borderWidth = 1.0;
        cell.createDayButton.layer.cornerRadius = cell.createDayButton.frame.size.width/2;
        [cell.createDayButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        return cell;
    }else if (indexPath.section == 2) {
        UserFavoritesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoritesCell"];
        cell.delegate = self;
     
        cell.nameLabel.text = [self.favoritesArray objectAtIndex:indexPath.row];
        
        return cell;
        

    //else{
//        PFObject *object = [self.daysArray objectAtIndex:indexPath.row];
//        NSDate *date = object[@"date"];
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//        [dateFormat setDateStyle:NSDateFormatterShortStyle];
//
//        DayPlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DayPlanCell" forIndexPath:indexPath];
//        cell.dateText.text = [dateFormat stringFromDate:date];
//       
//        return cell;
}else{
    return nil;
}
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        [self performSegueWithIdentifier:@"DayDetails" sender:[self.daysArray objectAtIndex:indexPath.row]];
    }
    if (indexPath.section == 2) {
        UserFavoritesTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self addElementName:cell.nameLabel.text];
        [tableView deselectRowAtIndexPath:indexPath animated:true];
    }
}
-(NSString *) elementForIndex:(NSIndexPath*) path
{
    return [self.favoritesArray objectAtIndex:path.row];
    
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
    self.addFromFavoritesLabel.hidden = true;
    [self.profileTableView reloadData];
    
    
    
}
-(void)removeElementName:(NSString *) name forIndexPath:(NSIndexPath *)path{
    
    [self.favoritesArray removeObjectAtIndex:path.row];
    [self.profileTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationLeft];
    [self.userSettings removeUserFavorite:name];

    
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

-(void)queryUserDayPlans{
    [self.elementsToAddToDayArray removeAllObjects];
    
    [self checkForArrayCount];
//    PFQuery *query = [PFQuery queryWithClassName:@"DayPlan"];
//    [query whereKey:@"user" equalTo:[PFUser currentUser]];
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        if (objects) {
//            self.daysArray = [objects mutableCopy];
//            [self.profileTableView reloadData];
//        }else{
//            
//        }
//    }];
    
}
- (IBAction)handleLogoutButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Log out?" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *logout = [UIAlertAction actionWithTitle:@"Log out" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AWSIdentityManager *identityManager = [AWSIdentityManager sharedInstance];
            [identityManager logoutWithCompletionHandler:^(id result, NSError *error) {
                if (!error) {
                    NSLog(@"logged out!");
                    [self reloadView];
                } else {
                    
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

#pragma mark - login methods and buttons
- (IBAction)handleLoginWithFacebookButtonPressed:(id)sender {
    [self handleLoginWithSignInProvider:AWSSignInProviderTypeFacebook];
}

- (void)handleLoginWithSignInProvider:(AWSSignInProviderType)signInProviderType {
    [[AWSIdentityManager sharedInstance]
     loginWithSignInProvider:signInProviderType
     completionHandler:^(id result, NSError *error) {
         if (!error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"UserLoggedIn" object:nil];
             });
         }
         NSLog(@"result = %@, error = %@", result, error);
     }];
}

- (void)showErrorDialog:(NSString *)loginProviderName withError:(const NSError *)error {
    // NSLog(@"%@: %@ failed to sign in w/ error: %@", LOG_TAG, loginProviderName, error);
    
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Sign-in Provider Sign-In Error",
                                                                  @"Sign-in error for sign-in failure.")
                                        message:NSLocalizedString(@"%@ failed to sign in w/ error: %@",
                                                                  @"Sign-in message structure for sign-in failure.")
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *doneAction =
    [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel",
                                                     @"Label to cancel sign-in failure.")
                             style:UIAlertActionStyleCancel
                           handler:nil];
    [alertController addAction:doneAction];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"CreateDay"]) {
        SavedDayTableViewController *dvc = segue.destinationViewController;
        dvc.elementsArray = self.elementsToAddToDayArray;
    }if ([segue.identifier isEqualToString:@"DayDetails"]) {
        SavedDayInfoViewController *dvc = segue.destinationViewController;
        //PFObject *object = (PFObject *)sender;
        //dvc.elementObject = object;
        
       
    }
}



@end
