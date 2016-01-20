//
//  AddFavoriteElementToArray.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/11/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import "AddFavoriteElementToArray.h"
#import <Parse/Parse.h>
#import "SVProgressHUD.h"
#import "UIColor+UIColor_SynergoColors.h"

@implementation AddFavoriteElementToArray

-(void)addElementName:(NSString *)name toUser:(PFUser *)user{
    if (!user) {
        [SVProgressHUD showImage:[UIImage imageNamed:@"profile"] status:@"You need to be logged in to save"];
    }
    [user addUniqueObject:name forKey:@"favorites"];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"QueryParseUser" object:nil];
            
            [SVProgressHUD showImage:[UIImage imageNamed:@"high-five"] status:@"Element added to favorites!"];
        }else{
            [self saveToLocalDataStore:name];
        }
    }];
}
-(void)saveToLocalDataStore:(NSString *)name{
    [[PFUser currentUser]addUniqueObject:name forKey:@"favorites"];
    [[PFUser currentUser]pinInBackgroundWithName:@"favorites"];
    [[PFUser currentUser]saveEventually:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"YEAH Muthafucka!");
        }else{
            NSLog(@"Nope! try again %@", error.localizedDescription);
        }
    }];
    NSLog(@"saved to local datastore");
}
@end
