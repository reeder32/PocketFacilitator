//
//  Initiatives.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/28/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InitiativesDetails : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *variations;
@property (nonatomic, copy) NSString *guidelines;
@property (nonatomic, copy) NSString *desiredOutcomes;
@property (nonatomic, copy) NSString *reflectionQuestions;



- (id)initWithUniqueName:(NSString *)name variations:(NSString *)variations
              guidelines:(NSString *)guidelines desiredOutcomes:(NSString *)desiredOutcomes
     reflectionQuestions:(NSString *)reflectionQuestions;

@end
