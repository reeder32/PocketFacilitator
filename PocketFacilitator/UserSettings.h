//
//  AddFavoriteElementToArray.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/11/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserSettings : NSObject

-(void)loadUserFavorites;
-(void)addUserFavorite: (NSString *) name;
-(void)getDayPlanDataForUser;
-(void)removeUserFavorite: (NSString *) name;

@property NSMutableArray *favoritesArray;

@end
