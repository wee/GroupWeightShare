//
//  User.m
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/13/12.
//
#include <stdlib.h>
#import "User.h"
#import "Entry.h"
#define ONE_DAY_AGO (60 * 60 * 24)

@interface User() 
- (void)assignSampleEntries;
@end

@implementation User

@synthesize isMale=_isMale;
@synthesize birthYear=_birthYear;
@synthesize isShared=_isShared;
@synthesize entries=_entries;

- (id)init
{
    if ((self = [super init])) {
        self.isMale = NO;
        self.birthYear = 1992;
        self.isShared = YES;
        [self assignSampleEntries];
    }
    return self;
}

- (NSUInteger)numberOfEntries {
    return self.entries.count;
}

- (NSNumber *)dateAsSecondsSinceReferenceDateForEntry:(NSUInteger)index {
    NSDate *date = ((Entry *)[self.entries objectAtIndex:index]).date;
    return [NSNumber numberWithDouble:[date timeIntervalSinceReferenceDate]];
}

- (NSDate *)earliestWeightRecordDate {
    NSDate *date = nil;
    for (int i = 0; i < self.entries.count; i++ ) {
        Entry *entry = (Entry *)[self.entries objectAtIndex:i];
        NSLog(@"date %@", entry.date);

        if (date == nil) {
            date = entry.date;
        } else {
            date = [entry.date earlierDate:date];
        }
    }
    NSLog(@"earliest date %@", date);

    return date;
}

- (NSDate *)lastWeightRecordDate {
    NSDate *date = nil;
    for (int i = 0; i < self.entries.count; i++ ) {
        Entry *entry = (Entry *)[self.entries objectAtIndex:i];
        if (date == nil) {
            date = entry.date;
        } else {
            date = [entry.date laterDate:date];
        }
    }
    NSLog(@"last date %@", date);
    return date;
}

- (NSNumber *)minimumWeight {
    NSNumber *minWeight = [NSNumber numberWithDouble:100000.0];
    
    for (int i = 0; i < self.entries.count; i++) {
        NSNumber *weight = ((Entry *)[self.entries objectAtIndex:i]).weight;
        if ([minWeight compare:weight] == NSOrderedDescending) {
            minWeight = weight;
        }
    }
    NSLog(@"minimum weight = %@", minWeight);
    return minWeight;
}

- (NSNumber *)maximumWeight {
    NSNumber *maxWeight = [NSNumber numberWithDouble:0.0];
    
    for (int i = 0; i < self.entries.count; i++) {
        NSNumber *weight = ((Entry *)[self.entries objectAtIndex:i]).weight;
        if ([maxWeight compare:weight] == NSOrderedAscending) {
            maxWeight = weight;
        }
    }
    NSLog(@"maximum weight = %@", maxWeight);
    return maxWeight;
}

- (NSNumber *)weightForEntry:(NSUInteger)index {
    return ((Entry *)[self.entries objectAtIndex:index]).weight;
}

- (void)assignSampleEntries {
    NSDate *now = [NSDate date];
    double weight = 180.0;
    NSMutableArray *entries = [NSMutableArray array];
    for (int i = 1; i <= 10; i++) {
        Entry *entry = [Entry entryWithDate:[NSDate dateWithTimeInterval:(ONE_DAY_AGO * i) sinceDate:now]
                                     weight:[NSNumber numberWithDouble:weight]];
        [entries addObject:entry];
        weight -= (arc4random() % 10) / 10.0;
    }
    
    self.entries = entries;
}
@end
