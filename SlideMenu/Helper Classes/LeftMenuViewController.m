//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"

@implementation LeftMenuViewController

#pragma mark - UIViewController Methods -

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.slideOutAnimationEnabled = YES;
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate & Datasrouce -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
	
	switch (indexPath.row)
	{
		case 0:
			cell.textLabel.text = @"Home";
			break;
			
		case 1:
			cell.textLabel.text = @"Profile";
			break;
			
		case 2:
			cell.textLabel.text = @"Friends";
			break;
			
		case 3:
			cell.textLabel.text = @"Sign Out";
			break;
	}
	
	cell.backgroundColor = [UIColor clearColor];
	
	return cell;
}


@end
