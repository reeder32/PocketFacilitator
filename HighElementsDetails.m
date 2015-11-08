//
//  HighElementsDetails.m
//  PocketFacilitator
//
//  Created by Nick Reeder on 11/7/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import "HighElementsDetails.h"

@implementation HighElementsDetails
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
