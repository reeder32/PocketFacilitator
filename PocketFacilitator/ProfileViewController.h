//
//  ProfileViewController.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 10/31/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface ProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *profileTableView;
@property (strong, nonatomic) NSMutableArray *favoritesArray;
@end
