//
//  SavedDayTableViewController.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/12/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedDayTableViewController : UITableViewController<UITextFieldDelegate>
@property NSMutableArray *elementsArray;

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;

@end
