//
//  AddFavoriteElementToArray.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/11/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import "AddFavoriteElementToArray.h"
#import <CoreData/CoreData.h>
#import "SVProgressHUD.h"
#import "UIColor+UIColor_SynergoColors.h"

@implementation AddFavoriteElementToArray

-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return  context;
}


-(void)addElementNameToCoreData:(NSString *)name{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Favorites"];
    NSMutableArray *favorites = [NSMutableArray array];
    favorites = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    if ([[favorites valueForKey:@"name"] containsObject:name]) {
        NSLog(@"This is already a favorite");
        return;
    }
    NSManagedObject *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"Favorites" inManagedObjectContext:context];
    [favorite setValue:name forKey:@"name"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"AddedFavorite" object:nil];
    
    NSError *error = nil;
    if (![context save:&error]) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        NSLog(@"Can't save! %@ %@", error, error.localizedDescription);
    } else {
        [SVProgressHUD showImage:[UIImage imageNamed:@"high-five"] status:@"Element added to favorites!"];
    }

}

@end
