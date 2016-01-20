//
//  SavedDayInfoViewController.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/12/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SavedDayInfoViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (strong, nonatomic) PFObject *elementObject;
@property NSString *dateString;
@property NSString *textFieldString;

@end
