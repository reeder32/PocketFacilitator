//
//  ElementsDetailViewTableViewController.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/8/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ElementObject.h"
@import CoreData;

@interface ElementsDetailViewTableViewController : UITableViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *guidelinesTitle;
@property (weak, nonatomic) IBOutlet UILabel *variationsTitle;
@property (weak, nonatomic) IBOutlet UILabel *desiredOutcomesTitle;
@property (weak, nonatomic) IBOutlet UILabel *reflectionQuestionsTitle;
@property (weak, nonatomic) IBOutlet UILabel *equipmentTitle;


@property (weak, nonatomic) IBOutlet UITableViewCell *guidelinesTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *variationsTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *reflectionQuestionsTableViewCell;

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *downArrow;


@property NSString *name;
@property NSString *guidelines;
@property NSString *variations;
@property NSString *desiredOutcomes;
@property NSString *reflectionQuestions;
@property NSString *equipment;

@property ElementObject *elementObject;


@end
