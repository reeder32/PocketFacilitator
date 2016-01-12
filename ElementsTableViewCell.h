//
//  ElementsTableViewCell.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/7/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"


@interface ElementsTableViewCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel *elementNameLabel;

@end
