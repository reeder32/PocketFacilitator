//
//  Favorites+CoreDataProperties.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/21/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Favorites.h"

NS_ASSUME_NONNULL_BEGIN

@interface Favorites (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
