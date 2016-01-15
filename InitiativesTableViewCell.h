//
//  InitiativesTableViewCell.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 12/28/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"

@interface InitiativesTableViewCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel *elementNameLabel;

@end
