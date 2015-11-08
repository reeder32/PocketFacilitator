//
//  HighElementsFromDatabase.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/7/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "HighElementsFromDatabase.h"
#import "HighElementsDetails.h"
#import <sqlite3.h>

@implementation HighElementsFromDatabase

static HighElementsFromDatabase *_database;
+ (HighElementsFromDatabase *)database{
    if (_database == nil) {
        _database = [[HighElementsFromDatabase alloc]init];
    }
    return _database;
}

-(id)init{
    if ((self= [super init])) {
        NSString *dbFilePath = [[NSBundle mainBundle] pathForResource:@"PocketFacilitator" ofType:@"db"];
        if (sqlite3_open([dbFilePath UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    return self;
}

-(NSArray *)highElementsArray{
    
    NSMutableArray *mutArray = [NSMutableArray array];
    sqlite3_stmt *selectStatement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT name, variations, guidelines, desiredOutcomes, reflectionQuestions FROM HighElements",nil];
        
        if (sqlite3_prepare_v2(_database,
                               [querySQL UTF8String], -1, &selectStatement, NULL) == SQLITE_OK)
        {
            
            
            while(sqlite3_step(selectStatement) == SQLITE_ROW)
            {
                
                char *nameChars = (char *) sqlite3_column_text(selectStatement, 0);
                char *variationsChar = (char *) sqlite3_column_text(selectStatement, 1);
                char *guidelinesChar = (char *) sqlite3_column_text(selectStatement, 2);
                char *desiredOutcomesChar = (char *) sqlite3_column_text(selectStatement, 3);
                char *reflectionQuestionsChar = (char *) sqlite3_column_text(selectStatement, 4);
                NSString *name = [NSString stringWithUTF8String:nameChars];
                NSString *variations = [NSString stringWithUTF8String:variationsChar];
                NSString *guidelines = [NSString stringWithUTF8String:guidelinesChar];
                NSString *outcomes = [NSString stringWithUTF8String:desiredOutcomesChar];
                NSString *questions = [NSString stringWithUTF8String:reflectionQuestionsChar];
                HighElementsDetails *details = [[HighElementsDetails alloc]initWithUniqueName:name variations:variations guidelines:guidelines desiredOutcomes:outcomes reflectionQuestions:questions];
                [mutArray addObject:details];
            }
            //  username.text=@"No Username";
            
            
            sqlite3_finalize(selectStatement);
            
        
    }
    return mutArray;
    
}


@end
