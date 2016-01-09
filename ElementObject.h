//
//  DesiredLearningOutcomesObject.h
//  PocketFacilitator
//
//  Created by Nick Reeder on 12/28/15.
//  Copyright © 2015 Nick Reeder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ElementObject : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *variations;
@property (nonatomic, copy) NSString *guidelines;
@property (nonatomic, copy) NSString *desiredOutcomes;
@property (nonatomic, copy) NSString *reflectionQuestions;
@property (nonatomic, copy) NSString *equipment;



- (id)initWithUniqueName:(NSString *)name variations:(NSString *)variations
              guidelines:(NSString *)guidelines
         desiredOutcomes:(NSString *)desiredOutcomes
     reflectionQuestions:(NSString *)reflectionQuestions
               equipment:(NSString *)equipment;
@end
