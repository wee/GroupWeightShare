//
//  Entry.h
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *weight;

+ (Entry *)entryWithDate:date weight:weight;

@end
