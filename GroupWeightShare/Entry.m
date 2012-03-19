//
//  Entry.m
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Entry.h"

@implementation Entry

@synthesize date=_date;
@synthesize weight=_weight;

+ (Entry *)entryWithDate:date weight:weight {
    Entry *entry = [[Entry alloc] init];
    entry.date = date;
    entry.weight = weight;
    return entry;
}
@end
