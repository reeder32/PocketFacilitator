//
//  LowElementsTableViewCell.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/12/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface LowElementsTableViewCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
