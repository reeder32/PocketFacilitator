//
//  SavedDayTableViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/12/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import "SavedDayTableViewController.h"
#import <Parse/Parse.h>
#import "SVProgressHUD.h"
#import "UIColor+UIColor_SynergoColors.h"


@interface SavedDayTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *shareButton;



@end

@implementation SavedDayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.shareButton setSelected:false];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    self.dateTextField.text = [dateFormat stringFromDate:date];
    
    
}
-(void)dismissKeyboard{
    [self.dateTextField resignFirstResponder];
    
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
    return self.elementsArray.count;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.elementsArray objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}
#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// Override to support editing the table view.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            [self.elementsArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            if (self.elementsArray.count ==0) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"EraseArray" object:nil];
                [self.navigationController popViewControllerAnimated:true];
            }
        }
    }
    
}
-(void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView setEditing:true animated:true];
    [self.shareButton setTintColor:[UIColor synergoMaroonColor]];
    [self.shareButton setImage:nil forState:UIControlStateSelected|UIControlStateHighlighted];
    [self.shareButton setSelected:true];
}


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    id element = [self.elementsArray objectAtIndex:fromIndexPath.row];
    [self.elementsArray removeObjectAtIndex:fromIndexPath.row];
    [self.elementsArray insertObject:element atIndex:toIndexPath.row];

}

#pragma mark - Date Picker Methods
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.dateTextField.inputView = [self configureDatePicker];
}

- (UIDatePicker *)configureDatePicker
{
    self.tap = [[UITapGestureRecognizer alloc]init];
    self.tap.numberOfTapsRequired = 1;
    [self.tap addTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:self.tap];
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    NSDate *date = [NSDate date];
    datePicker.date = date;
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(handleDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    return datePicker;
}

-(void)dismissDatePicker
{
    [self.dateTextField resignFirstResponder];
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.view removeGestureRecognizer:self.tap];
    [self dismissDatePicker];
}
-(void)handleDatePickerValueChanged:(UIDatePicker *)datePicker
{
    NSDate *date = datePicker.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    self.dateTextField.text = [dateFormat stringFromDate:date];
}

- (IBAction)handleCalendarButtonPressed:(id)sender {
    
    [SVProgressHUD showWithStatus:@"Saving..."];
    PFObject *day = [PFObject objectWithClassName:@"DayPlan"];
    [day setObject:[PFUser currentUser] forKey:@"user"];
    [day addObject:self.elementsArray forKey:@"elementsArray"];
    UIDatePicker *datePicker = (UIDatePicker *)self.dateTextField.inputView;
    [day setObject:datePicker.date forKey:@"date"];
    [day saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"QueryParseDayPlans" object:nil];
            [SVProgressHUD showSuccessWithStatus:@"Success!"];
        }else{
            
            [self saveToLocalDataStore];
        }
    }];
    
    
    
}


-(void)saveToLocalDataStore{
    
}
- (IBAction)handleShareButtonPressed:(id)sender {
    [self checkButtonState];
   
}
-(void)checkButtonState{
    if ([self.shareButton isSelected]) {
       
        [self.tableView setEditing:false animated:true];
        [self.shareButton setSelected:false];
        
    }else {
        NSString *textString = [self.elementsArray componentsJoinedByString:@"\n"];
        NSString *dateString = self.dateTextField.text;
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
        [self presentViewController:vc animated:true completion:nil];
    }
    
    

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
