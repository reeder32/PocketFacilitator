//
//  AddFavoriteElementToArray.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 1/11/16.
//  Copyright © 2016 Nick Reeder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface AddFavoriteElementToArray : NSObject

-(void)addElementName:(NSString *)name toUser:(PFUser *)user;
@end
