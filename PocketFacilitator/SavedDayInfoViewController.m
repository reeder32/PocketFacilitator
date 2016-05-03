//
//  SavedDayInfoViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/12/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import "SavedDayInfoViewController.h"
#import "SVProgressHUD.h"
#import <CoreData/CoreData.h>

@interface SavedDayInfoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@end

@implementation SavedDayInfoViewController

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
    [SVProgressHUD showWithStatus:@"Loading..."];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd-yyyy";
    
    NSDate *date = [self.elementObject valueForKey:@"date"];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    self.dateString = dateString;
    self.navigationItem.title = dateString;
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[self.elementObject valueForKey:@"activitiesArray"]];
    
    NSString *string = [array componentsJoinedByString:@"\n"];
    self.textField.text = string;
    
    
    
    //self.textField.text = [array repl]
    [SVProgressHUD dismiss];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.textField setFont:[UIFont fontWithName:@"OpenSans" size:20]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)handleShareButtonTapped:(id)sender {
    NSString *textString = self.textField.text;
    NSString *dateString = self.dateString;
    NSArray *array = @[ dateString, textString];
    UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:array applicationActivities:nil];
    NSArray *excludeActivities = @[UIActivityTypePostToFacebook,
                                   UIActivityTypePostToTwitter,
                                   UIActivityTypeAssignToContact,
                                   UIActivityTypeAddToReadingList,
                                   UIActivityTypePostToFlickr,
                                   UIActivityTypePostToVimeo
                                   ];
    vc.excludedActivityTypes = excludeActivities;
    //if iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentViewController:vc animated:YES completion:nil];
    }
    //if iPad
    else {
        // Change Rect to position Popover
        UIPopoverController *popup = [[UIPopoverController alloc] initWithContentViewController:vc];
        [popup presentPopoverFromRect:CGRectMake(self.shareButton.frame.size.width/2, self.shareButton.frame.size.height/4, 0, 0)inView:self.tabBarController.tabBar permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    }
}
- (IBAction)handleTrashCanPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Would you like to delete this day from your profile?" message:@"please confirm below" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSManagedObjectContext *context = [self managedObjectContext];
        [context deleteObject:self.elementObject];
        [context save:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UpdateDayPlan" object:nil];
        
        [SVProgressHUD showSuccessWithStatus:@"Deleted"];
        [self.navigationController popViewControllerAnimated:true];
        
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:delete];
    [alert addAction:cancel];
    [self presentViewController:alert animated:true completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
