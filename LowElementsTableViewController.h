//
//  LowElementsTableViewController.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/6/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface LowElementsTableViewController : UITableViewController<UISearchBarDelegate,MGSwipeTableCellDelegate>
@property (strong, nonatomic) NSArray *lowElementsArray;
@end
