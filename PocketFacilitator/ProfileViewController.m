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


@interface ProfileViewController ()
@property (strong, nonatomic) NSMutableArray *favoritesArray;
@property (weak, nonatomic) IBOutlet UIView *createAccountView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (strong, nonatomic) NSArray *daysArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    if (![PFUser currentUser]) {
        
        self.createAccountView.hidden = false;
        self.profileTableView.hidden = true;
    }else{
        [self queryParse];
        
        self.createAccountView.hidden = true;
        self.profileTableView.hidden = false;
        
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
    
    return self.favoritesArray.count;
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Your favorite activities";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserFavoritesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoritesCell"];
    cell.nameLabel.text = [self.favoritesArray objectAtIndex:indexPath.row];
    NSLog(@"cell.nameLabel.text is %@", cell.nameLabel.text);
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    UserFavoritesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FavoritesCell"];
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.favoritesArray removeObjectAtIndex:indexPath.row];
        [[PFUser currentUser]removeObject:cell.nameLabel.text forKey:@"favorites"];
        [[PFUser currentUser]unpinWithName:@"favorites"];
        [[PFUser currentUser]saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                NSLog(@"YEAH Muthafucka!");
            }else{
                NSLog(@"Nope! try again %@", error.localizedDescription);
            }
        }];

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

#pragma mark - uicollectionview
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.daysArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DateCollectionCell" forIndexPath:indexPath];
    return cell;
}
- (IBAction)handleLogoutButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Log out?" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *logout = [UIAlertAction actionWithTitle:@"Log out" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
            if (!error) {
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
