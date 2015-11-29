//
//  LeftMenuSegue.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/28/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//
#define kAnimationDuration 0.5
#import "LeftMenuSegue.h"

@implementation LeftMenuSegue
- (void) perform {
    UIViewController *sourceViewController = (UIViewController *) self.sourceViewController;
    UIViewController *destinationViewController = (UIViewController *) self.destinationViewController;
    CGRect fm = self.sourceViewController.view.frame;
    fm.origin.x = self.sourceViewController.view.frame.size.width/2;
    [UIView animateWithDuration:0.3 animations:^{
        self.sourceViewController.view.frame = fm;
    }];
}
@end
