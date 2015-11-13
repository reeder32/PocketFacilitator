//
//  ElementsFromDatabase.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/7/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@class HighElementsDetails;
@class LowElementsDetails;

@interface ElementsFromDatabase : NSObject{
    sqlite3 *_database;
}

+(ElementsFromDatabase *)database;
-(NSArray *)highElementsArray;
-(NSArray *)lowElementsArray;
-(NSArray *)initiativesArray;
-(NSArray *)iceBreakersArray;
@end
