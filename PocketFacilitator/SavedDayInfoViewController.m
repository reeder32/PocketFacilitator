//
//  SavedDayInfoViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/12/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import "SavedDayInfoViewController.h"
#import "SVProgressHUD.h"

@interface SavedDayInfoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@end

@implementation SavedDayInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"),\"("];
    
    [SVProgressHUD showInfoWithStatus:@""];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM-dd-yyyy";
    
    //NSDate *date = self.elementObject[@"date"];
    
    //NSString *dateString = [dateFormatter stringFromDate:date];
    //self.dateString = dateString;
    //self.navigationItem.title = dateString;
    //NSArray *array = self.elementObject[@"elementsArray"];
   // NSString *string = [array componentsJoinedByString:@""];
    //self.textField.text = [[[string stringByTrimmingCharactersInSet:set]stringByReplacingOccurrencesOfString:@"\"" withString:@""]stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    
 
    
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
//        [self.elementObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//            if (succeeded) {
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"QueryParseDayPlans" object:nil];
//                [SVProgressHUD showSuccessWithStatus:@"Deleted"];
//                [self.navigationController popViewControllerAnimated:true];
//            }else{
//                [SVProgressHUD showErrorWithStatus:@"There was a problem!"];
//            }
//        }];

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
