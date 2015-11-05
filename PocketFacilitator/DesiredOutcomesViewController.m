//
//  DesiredOutcomesViewController.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 10/31/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "DesiredOutcomesViewController.h"
#import "UIColor+UIColor_SynergoColors.h"

@interface DesiredOutcomesViewController()

@end

@implementation DesiredOutcomesViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.highElementsButton.layer.borderColor = [UIColor synergoRedColor].CGColor;
    self.highElementsButton.layer.borderWidth = 4.0;
    self.highElementsButton.layer.cornerRadius = 4.0;
    
    self.lowElementsButton.layer.borderColor = [UIColor synergoRedColor].CGColor;
    self.lowElementsButton.layer.borderWidth = 4.0;
    self.lowElementsButton.layer.cornerRadius = 4.0;
}

-(BOOL)prefersStatusBarHidden{
    return true;
}


@end
