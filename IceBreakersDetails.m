//
//  IceBreakersDetails.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/28/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "IceBreakersDetails.h"

@implementation IceBreakersDetails
- (id)initWithUniqueName:(NSString *)name variations:(NSString *)variations
              guidelines:(NSString *)guidelines desiredOutcomes:(NSString *)desiredOutcomes
     reflectionQuestions:(NSString *)reflectionQuestions{
    if ((self = [super init])) {
        self.name = name;
        self.variations = variations;
        self.guidelines = guidelines;
        self.desiredOutcomes = desiredOutcomes;
        self.reflectionQuestions = reflectionQuestions;
    }
    return self;
}

@end
