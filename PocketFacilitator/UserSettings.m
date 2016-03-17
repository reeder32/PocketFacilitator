//
//  AddFavoriteElementToArray.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/11/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import "UserSettings.h"
#import "SVProgressHUD.h"
#import "UIColor+UIColor_SynergoColors.h"
#import <AWSCognito/AWSCognito.h>
#import "AWSIdentityManager.h"
#import "AWSConfiguration.h"
#import "AWSTask+CheckExceptions.h"

@implementation UserSettings

- (void)loadUserFavorites{
   
    AWSCognito *syncClient = [AWSCognito defaultCognito];
    AWSCognitoDataset *userFavorites = [syncClient openOrCreateDataset:@"user_favorites"];
    self.favoritesArray = [[userFavorites.getAll allValues]mutableCopy];
}

-(void)addUserFavorite: (NSString *) name{
   
    AWSCognito *syncClient = [AWSCognito defaultCognito];
    AWSCognitoDataset *userFavorites = [syncClient openOrCreateDataset:@"user_favorites"];
    [userFavorites setString:name forKey:name];
    [[userFavorites synchronize] continueWithExceptionCheckingBlock:^(id result, NSError *error) {
        [SVProgressHUD showWithStatus:@"Saving..."];
        if (!result) {
            AWSLogError(@"saveSettings AWS task error: %@", [error localizedDescription]);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        } else {
            [SVProgressHUD dismiss];
            [self loadUserFavorites];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UserAddedElementToFavorites" object:nil];
        }
      
    }];
}

-(void)removeUserFavorite: (NSString *) name{
    AWSCognito *syncClient = [AWSCognito defaultCognito];
    AWSCognitoDataset *userFavorites = [syncClient openOrCreateDataset:@"user_favorites"];
    [userFavorites removeObjectForKey:name];
    [[userFavorites synchronize] continueWithExceptionCheckingBlock:^(id result, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        } else {
            [self loadUserFavorites];
        }
    }];
}
- (void) getDayPlanDataForUser{
    
}
@end
