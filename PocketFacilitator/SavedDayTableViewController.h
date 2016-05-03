//
//  SavedDayTableViewController.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/12/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedDayTableViewController : UITableViewController<UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *elementsArray;
@property NSMutableArray *initialArray;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong, nonatomic) UITapGestureRecognizer *tap;
@end
