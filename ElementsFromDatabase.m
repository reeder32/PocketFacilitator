//
//  ElementsFromDatabase.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/7/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "ElementsFromDatabase.h"
#import "ElementObject.h"
#import <sqlite3.h>


@implementation ElementsFromDatabase

static ElementsFromDatabase *_database;
#define kDatabaseName (@"levelProgress.db")
+ (ElementsFromDatabase *)database{
    if (_database == nil) {
        _database = [[ElementsFromDatabase alloc]init];
        
    }
    return _database;
}

-(id)init{
    if ((self= [super init])) {
        self.dbFilePath = [[NSBundle mainBundle] pathForResource:@"PocketFacilitator" ofType:@"db"];
        if (sqlite3_open([self.dbFilePath UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        }
    }
    NSLog(@"self.dbFilePath is -->%@<--", self.dbFilePath);
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
                ElementObject *details = [[ElementObject alloc]initWithUniqueName:name variations:variations guidelines:guidelines desiredOutcomes:outcomes reflectionQuestions:questions equipment:nil];
                [mutArray addObject:details];
            }
            //  username.text=@"No Username";
            
            
            sqlite3_finalize(selectStatement);
            
        
    }
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSArray *returnArray = [mutArray sortedArrayUsingDescriptors:sortDescriptors];
    return returnArray;
    
}
-(NSArray *)lowElementsArray{
    
    NSMutableArray *mutArray = [NSMutableArray array];
    sqlite3_stmt *selectStatement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT name, variations, guidelines, desiredOutcomes, reflectionQuestions FROM LowElements",nil];
    
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
            ElementObject *details = [[ElementObject alloc]initWithUniqueName:name variations:variations guidelines:guidelines desiredOutcomes:outcomes reflectionQuestions:questions equipment:nil];
            [mutArray addObject:details];
        }
        //  username.text=@"No Username";
        
        
        sqlite3_finalize(selectStatement);
        
        
    }
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSArray *returnArray = [mutArray sortedArrayUsingDescriptors:sortDescriptors];
    return returnArray;
    
}
-(NSArray *)iceBreakersArray{
    
    NSMutableArray *mutArray = [NSMutableArray array];
    sqlite3_stmt *selectStatement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT name, variations, guidelines, desiredOutcomes, reflectionQuestions FROM IceBreakers",nil];
    
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
            ElementObject *details = [[ElementObject alloc]initWithUniqueName:name variations:variations guidelines:guidelines desiredOutcomes:outcomes reflectionQuestions:questions equipment:nil];
            [mutArray addObject:details];
        }
        //  username.text=@"No Username";
        
        
        sqlite3_finalize(selectStatement);
        
        
    }
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSArray *returnArray = [mutArray sortedArrayUsingDescriptors:sortDescriptors];
    return returnArray;
    
}
-(NSArray *)initiativesArray{
    
    NSMutableArray *mutArray = [NSMutableArray array];
    sqlite3_stmt *selectStatement;
    NSString *querySQL = [NSString stringWithFormat: @"SELECT name, variations, guidelines, desiredOutcomes, reflectionQuestions, equipment FROM Initiatives",nil];
    
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
            char *equipmentChar = (char *)sqlite3_column_text(selectStatement, 5);
            NSString *name = [NSString stringWithUTF8String:nameChars];
            NSString *variations = [NSString stringWithUTF8String:variationsChar];
            NSString *guidelines = [NSString stringWithUTF8String:guidelinesChar];
            NSString *outcomes = [NSString stringWithUTF8String:desiredOutcomesChar];
            NSString *questions = [NSString stringWithUTF8String:reflectionQuestionsChar];
            NSString *equipment = [NSString stringWithUTF8String:equipmentChar];
            ElementObject *details = [[ElementObject alloc]initWithUniqueName:name variations:variations guidelines:guidelines desiredOutcomes:outcomes reflectionQuestions:questions equipment:equipment];
            [mutArray addObject:details];
        }
        //  username.text=@"No Username";
        
        
        sqlite3_finalize(selectStatement);
        
        
    }
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSArray *returnArray = [mutArray sortedArrayUsingDescriptors:sortDescriptors];
    return returnArray;
    
}

-(NSArray *)allElementsArray{
    NSMutableArray *mutArray = [NSMutableArray array];
    for (ElementObject *element in self.highElementsArray) {
        [mutArray addObject:element];
    }
    for (ElementObject *element in self.lowElementsArray) {
        
        [mutArray addObject:element];
    }
    for (ElementObject *element in self.initiativesArray) {
        
        [mutArray addObject:element];
    }
    for (ElementObject *element in self.iceBreakersArray) {
        [mutArray addObject:element];
    }
    
    NSArray *sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSArray *returnArray = [mutArray sortedArrayUsingDescriptors:sortDescriptors];
    return returnArray;
    
}


@end
