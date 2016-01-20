//
//  ElementsToAddToDayTableViewCell.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/12/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import "MGSwipeTableCell.h"

@interface ElementsToAddToDayTableViewCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIButton *createDayButton;

@end
