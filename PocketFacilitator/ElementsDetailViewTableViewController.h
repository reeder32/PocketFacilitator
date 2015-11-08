//
//  ElementsDetailViewTableViewController.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/8/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighElementsDetails.h"

@interface ElementsDetailViewTableViewController : UITableViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *guidelinesTextView;
@property (weak, nonatomic) IBOutlet UITextView *variationsTextView;
@property (weak, nonatomic) IBOutlet UITextView *questionsTextView;
@property (weak, nonatomic) IBOutlet UILabel *desiredOutcomesLabel;

@property NSString *name;
@property NSString *guidelines;
@property NSString *variations;
@property NSString *desiredOutcomes;
@property NSString *reflectionQuestions;


@property (weak, nonatomic) IBOutlet UINavigationItem *detailNavItem;
@property (strong, nonatomic) HighElementsDetails *elementDetail;
@property (weak, nonatomic) IBOutlet UITableViewCell *variationsTableViewCell;

@end
