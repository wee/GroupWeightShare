//
//  User.h
//  GroupWeightShare
//
//  Created by Weerasak Witthawaskul on 3/13/12.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, assign) BOOL isMale;
@property (nonatomic, assign) NSUInteger birthYear;
@property (nonatomic, assign) BOOL isShared;
@property (nonatomic, strong) NSArray *entries;

- (NSUInteger)numberOfEntries;
- (NSNumber *)dateAsSecondsSinceReferenceDateForEntry:(NSUInteger)index;
- (NSNumber *)weightForEntry:(NSUInteger)index;
- (NSNumber *)minimumWeight;
- (NSNumber *)maximumWeight;
- (NSDate *)earliestWeightRecordDate;
- (NSDate *)lastWeightRecordDate;

@end
