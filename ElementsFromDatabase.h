//
//  ElementsFromDatabase.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/7/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ElementObject.h"


@interface ElementsFromDatabase : NSObject{
    sqlite3 *_database;
}

+(ElementsFromDatabase *)database;

@property (strong, nonatomic) NSString *dbFilePath;
-(NSArray *)highElementsArray;
-(NSArray *)lowElementsArray;
-(NSArray *)initiativesArray;
-(NSArray *)iceBreakersArray;
-(NSArray *)allElementsArray;

@end
