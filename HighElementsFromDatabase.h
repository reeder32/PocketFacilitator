//
//  HighElementsFromDatabase.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/7/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@class HighElementsDetails;

@interface HighElementsFromDatabase : NSObject{
    sqlite3 *_database;
}

+(HighElementsFromDatabase *)database;
-(NSArray *)highElementsArray;
@end
