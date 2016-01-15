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

@implementation AddFavoriteElementToArray

-(void)addElementName:(NSString *)name toUser:(PFUser *)user{
    if (!user) {
        [SVProgressHUD showImage:[UIImage imageNamed:@"light-on"] status:@"You need to be logged in to save"];
    }
    [user addUniqueObject:name forKey:@"favorites"];
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"QueryParseUser" object:nil];
            [SVProgressHUD showSuccessWithStatus:@"Element added to favorites"];
            NSLog(@"element successfully added!");
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
