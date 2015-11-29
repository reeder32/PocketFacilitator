//
//  MenuTableViewController.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/28/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ElementsTableViewController.h"
@interface MenuTableViewController : UITableViewController
@property (nonatomic, weak) ElementsTableViewController *elementsTableViewController;
@end
