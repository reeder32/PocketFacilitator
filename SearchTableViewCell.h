//
//  SearchTableViewCell.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/8/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface SearchTableViewCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
