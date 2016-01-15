//
//  DesiredLearningOutcomesTableViewController.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 12/28/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface DesiredLearningOutcomesTableViewController : UITableViewController<MGSwipeTableCellDelegate>
@property (strong, nonatomic) NSArray *outcomesArray;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

@end
